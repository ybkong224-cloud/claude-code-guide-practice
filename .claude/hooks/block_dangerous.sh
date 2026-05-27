#!/bin/bash
# Block dangerous bash commands before execution.
# Exit 2 to block; exit 0 to allow.

input=$(cat)
command=$(echo "$input" | python3 -c "import sys, json; d=json.load(sys.stdin); print(d.get('tool_input', {}).get('command', ''))")

DANGEROUS_PATTERNS=(
    "rm[[:space:]]+-[^[:space:]]*r[^[:space:]]*f"  # rm -rf / rm -fr
    "rm[[:space:]]+-[^[:space:]]*f[^[:space:]]*r"
    "DROP[[:space:]]+TABLE"                         # SQL DROP TABLE
    "DROP[[:space:]]+DATABASE"
    "TRUNCATE[[:space:]]+TABLE"
    "git[[:space:]]+push[[:space:]]+--force"        # git push --force
    "git[[:space:]]+push[[:space:]]+-f[[:space:]]"
    "git[[:space:]]+push[[:space:]]+-f$"
    "git[[:space:]]+reset[[:space:]]+--hard"        # git reset --hard
    "chmod[[:space:]]+777"                          # chmod 777
    ":[[:space:]]*\(\)[[:space:]]*{.*}.*:"          # fork bomb
    "mkfs\."                                        # disk format
    "dd[[:space:]]+if=.*of=/dev/"                  # dd to device
)

for pattern in "${DANGEROUS_PATTERNS[@]}"; do
    if echo "$command" | grep -qiE "$pattern"; then
        echo "BLOCKED: dangerous command detected — '$pattern' pattern matched." >&2
        echo "Command: $command" >&2
        exit 2
    fi
done

exit 0
