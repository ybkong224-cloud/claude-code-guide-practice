def add(a: int | float, b: int | float) -> int | float:
    return a + b


def divide(a: int | float, b: int | float) -> float:
    if isinstance(b, float) and b != b:  # NaN != NaN is always True
        raise ValueError(f"Cannot divide {a!r} by NaN")
    if b == 0:
        raise ZeroDivisionError(f"Cannot divide {a!r} by zero")
    return a / b
