#!/bin/python3

import sys
from typing import List


Grade = int


FAILING_GRADE = 40


def parse_grade(raw: str) -> Grade:
    grade = Grade(raw)
    assert 0 <= grade <= 100
    return grade


def parse_grades(input_file) -> List[Grade]:
    n = int(input_file.readline())
    assert 1 <= n <= 60
    return [parse_grade(input_file.readline()) for _ in range(n)]


def print_grades(output_file, grades: List[Grade]) -> None:
    for grade in grades:
        output_file.write(str(grade))
        output_file.write('\n')


def next_number(start: int, divisible_by: int) -> int:
    num = start
    while num % divisible_by != 0:
        num += 1
    return num


def round_grade(grade: Grade) -> Grade:
    possible = next_number(start=grade, divisible_by=5)
    rounded = grade
    if (possible - grade) < 3:
        rounded = possible
    return rounded if rounded >= FAILING_GRADE else grade


def round_grades(grades: List[Grade]) -> List[Grade]:
    return [round_grade(grade) for grade in grades]


if __name__ == '__main__':
    grades = parse_grades(sys.stdin)
    rounded_grades = round_grades(grades)
    print_grades(sys.stdout, rounded_grades)
