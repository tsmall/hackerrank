#!/bin/python3

import sys
from typing import List


def birthday_cake_candles(candle_heights: List[int]) -> int:
    max_height = max(candle_heights)
    tallest_candles = [
        height
        for height in candle_heights
        if height == max_height
    ]
    return len(tallest_candles)


def parse_candle_heights(file) -> List[int]:
    n = int(file.readline())
    heights = file.readline().split()
    assert len(heights) == n
    return [int(height) for height in heights]


if __name__ == '__main__':
    candle_heights = parse_candle_heights(sys.stdin)
    candles_blown_out = birthday_cake_candles(candle_heights)
    print(candles_blown_out)
