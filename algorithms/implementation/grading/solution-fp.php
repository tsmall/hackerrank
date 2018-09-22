<?php

namespace numbers {

    function next_int($start, $divisible_by) {
        $num = $start;
        while ($num % $divisible_by !== 0) {
            $num += 1;
        }
        return $num;
    }

}

namespace grades {

    const FAILING_GRADE = 40;

    function round_grade($grade) {
        $possible = \numbers\next_int($grade, 5);
        $rounded = $grade;
        if (($possible - $grade) < 3) {
            $rounded = $possible;
        }
        return $rounded >= FAILING_GRADE ? $rounded : $grade;
    }

    function round_grades($grades) {
        return array_map('\grades\round_grade', $grades);
    }

}

namespace grades\io {

    function parse_grades($in_handle) {
        fscanf($in_handle, "%d", $student_count);
        assert($student_count >= 1 && $student_count <= 60);

        foreach (range(1, $student_count) as $i) {
            fscanf($in_handle, "%d", $grade);
            assert($grade >= 0 && $grade <= 100);
            $grades[] = $grade;
        }

        return $grades;
    }

    function print_grades($out_handle, $grades) {
        foreach ($grades as $grade) {
            fprintf($out_handle, "%d\n", $grade);
        }
    }

}

namespace main {

    function main() {
        $in_handle = fopen('php://stdin', 'r');
        $out_handle = fopen('php://stdout', 'w');

        try {
            $grades = \grades\io\parse_grades($in_handle);
            $rounded = \grades\round_grades($grades);
            \grades\io\print_grades($out_handle, $rounded);
        }
        finally {
            fclose($out_handle);
            fclose($in_handle);
        }
    }

    main();

}
