<?php

function solve( $grades ){
    return array_map( 'round_grade', $grades );
}

function round_grade( $grade ) {
    if( $grade < 38 ) {
        return $grade;
    }

    $possible_score = next_multiple_of_five( $grade );
    $difference = $possible_score - $grade;
    return ( $difference < 3 ) ? $possible_score : $grade;
}

function next_multiple_of_five( $grade ) {
    $multiple = $grade;
    while( $multiple % 5 != 0 ) {
        $multiple++;
    }
    return $multiple;
}

function input() {
    $handle = fopen( "php://stdin", "r" );

    // The first line contains the number of student grades.
    fscanf( $handle, "%d", $student_count );

    // The next n lines contain the actual grades.
    $grades = array();
    for( $i = 0; $i < $student_count; $i++ ) {
       fscanf( $handle, "%d", $grades[] );
    }

    return $grades;
}

function output( $rounded_grades ) {
    foreach( $rounded_grades as $grade ) {
        printf( "%d\n", $grade );
    }
}

$grades = input();
$rounded_grades = solve( $grades );
output( $rounded_grades );
