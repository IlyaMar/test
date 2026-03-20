"""Tests for binomial coefficient function."""

import sys
import unittest
from pathlib import Path

# Allow importing binomial when running from any directory (e.g. project root)
sys.path.insert(0, str(Path(__file__).resolve().parent))

from binomial import binomial_coefficient


class TestBinomialCoefficient(unittest.TestCase):
    """Tests for binomial_coefficient."""

    def test_c_5_0(self):
        """C(5, 0) = 1."""
        self.assertEqual(binomial_coefficient(5, 0), 1)

    def test_c_5_5(self):
        """C(5, 5) = 1."""
        self.assertEqual(binomial_coefficient(5, 5), 1)

    def test_c_5_2(self):
        """C(5, 2) = 10."""
        self.assertEqual(binomial_coefficient(5, 2), 10)

    def test_c_5_3(self):
        """C(5, 3) = 10 (symmetric to C(5, 2))."""
        self.assertEqual(binomial_coefficient(5, 3), 10)

    def test_c_0_0(self):
        """C(0, 0) = 1."""
        self.assertEqual(binomial_coefficient(0, 0), 1)

    def test_c_6_3(self):
        """C(6, 3) = 20."""
        self.assertEqual(binomial_coefficient(6, 3), 20)

    def test_c_10_4(self):
        """C(10, 4) = 210."""
        self.assertEqual(binomial_coefficient(10, 4), 210)

    def test_symmetry(self):
        """C(n, k) == C(n, n - k) for various n, k."""
        for n in [7, 12, 20]:
            for k in range(n + 1):
                self.assertEqual(
                    binomial_coefficient(n, k),
                    binomial_coefficient(n, n - k),
                )

    def test_sum_row_equals_2_power_n(self):
        """Sum of row n equals 2^n (e.g. row 5 sums to 32)."""
        n = 5
        row_sum = sum(binomial_coefficient(n, k) for k in range(n + 1))
        self.assertEqual(row_sum, 2**n)

    def test_n_negative_raises(self):
        """n < 0 raises ValueError."""
        with self.assertRaises(ValueError) as ctx:
            binomial_coefficient(-1, 0)
        self.assertIn("non-negative", str(ctx.exception))

    def test_k_negative_raises(self):
        """k < 0 raises ValueError."""
        with self.assertRaises(ValueError) as ctx:
            binomial_coefficient(5, -1)
        self.assertIn("non-negative", str(ctx.exception))

    def test_k_gt_n_raises(self):
        """k > n raises ValueError."""
        with self.assertRaises(ValueError) as ctx:
            binomial_coefficient(5, 6)
        self.assertIn("must not exceed", str(ctx.exception))


if __name__ == "__main__":
    unittest.main(verbosity=2)
