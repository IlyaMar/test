"""
Binomial coefficient C(n, k) = n! / (k! * (n - k)!)
Number of ways to choose k elements from a set of n elements.
"""


def binomial_coefficient(n: int, k: int) -> int:
    """
    Compute the binomial coefficient C(n, k).

    Args:
        n: Total number of elements (non-negative integer).
        k: Number of elements to choose (0 <= k <= n).

    Returns:
        C(n, k) as an integer.

    Raises:
        ValueError: If n < 0, k < 0, or k > n.
    """
    if n < 0 or k < 0:
        raise ValueError("n and k must be non-negative")
    if k > n:
        raise ValueError("k must not exceed n")

    # C(n, 0) = C(n, n) = 1
    if k == 0 or k == n:
        return 1

    # Use C(n, k) = C(n, n - k) to minimize iterations
    if k > n - k:
        k = n - k

    result = 1
    for i in range(k):
        result = result * (n - i) // (i + 1)
    return result
