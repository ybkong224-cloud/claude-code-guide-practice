# claude-code-guide-practice

Python pipeline utility functions with strict type hints and error handling.

## Functions

### `add`

```python
def add(a: int | float, b: int | float) -> int | float
```

두 수를 더합니다.

```python
from ex_pipeline import add

add(1, 2)       # 3
add(1.5, 2.5)   # 4.0
add(-3, 5)      # 2
```

---

### `divide`

```python
def divide(a: int | float, b: int | float) -> float
```

두 수를 나눕니다.

**예외:**
- `ZeroDivisionError` — `b`가 `0` 또는 `0.0`인 경우
- `ValueError` — `b`가 `float('nan')`인 경우

```python
from ex_pipeline import divide

divide(10, 2)         # 5.0
divide(7.5, 2.5)      # 3.0
divide(-9, 3)         # -3.0

divide(1, 0)          # ZeroDivisionError: Cannot divide 1 by zero
divide(1.0, 0.0)      # ZeroDivisionError: Cannot divide 1.0 by zero
divide(1.0, float('nan'))  # ValueError: Cannot divide 1.0 by NaN
```

## Development

```bash
# 린트
.venv/bin/ruff check .

# 타입 검사
.venv/bin/mypy ex_pipeline.py

# 테스트
.venv/bin/pytest test_pipeline.py -v
```
