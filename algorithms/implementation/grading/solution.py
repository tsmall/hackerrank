#!/bin/python3

import sys


class Grade:

    failing_score = 40

    def __init__(self, raw_grade: int):
        assert 0 <= raw_grade <= 100
        self._raw_grade = raw_grade

    @property
    def numeric_score(self) -> int:
        return self._raw_grade

    def print_to(self, file) -> None:
        file.write(str(self.numeric_score))


class SamGrade(Grade):

    @property
    def numeric_score(self) -> int:
        return self._rounded_score

    @property
    def _rounded_score(self) -> int:
        original = super().numeric_score
        possible = self._possible_rounded_score

        rounded = original
        if (possible - original) < 3:
            rounded = possible

        return (
            original if rounded < self.failing_score
            else rounded
        )

    @property
    def _possible_rounded_score(self) -> int:
        original = super().numeric_score
        possible = original
        while possible % 5 != 0:
            possible += 1
        return possible


class GradeList:

    def __init__(self):
        self._grades = []

    def add(self, grade: Grade) -> None:
        self._grades.append(grade)

    def print_to(self, file) -> None:
        for grade in self._grades:
            grade.print_to(file)
            file.write('\n')


class LineGradeLoader:

    def __init__(self, grade_constructor, input_file):
        self._in = input_file
        self._grade_constructor = grade_constructor

    @property
    def all_grades(self) -> GradeList:
        grade_count = int(self._in.readline())
        assert 1 <= grade_count <= 60

        l = GradeList()
        for _ in range(grade_count):
            grade_number = int(self._in.readline())
            l.add(self._grade_constructor(grade_number))
        return l


class App:

    def __init__(self, input_file, output_file):
        self._grade_loader = LineGradeLoader(SamGrade, input_file)
        self._out = output_file

    def run(self) -> None:
        grade_list = self._grade_loader.all_grades
        grade_list.print_to(self._out)


if __name__ == '__main__':
    app = App(sys.stdin, sys.stdout)
    app.run()
