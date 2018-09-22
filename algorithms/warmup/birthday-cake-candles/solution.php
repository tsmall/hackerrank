<?php

function birthday_cake_candles( $age, $candle_heights ) {
    $max_height = max( $candle_heights );
    $height_counts = array_count_values( $candle_heights );
    return $height_counts[ $max_height ];
}

function input() {
    $handle = fopen("php://stdin", "r");
    fscanf( $handle, "%i", $age );
    $ar_temp = fgets( $handle );
    $ar = explode( " ", $ar_temp );
    $candle_heights = array_map( 'intval', $ar );
    return [ $age, $candle_heights ];
}

function output( $extinguished_candle_count ) {
    printf( "%d\n", $extinguished_candle_count );
}

list( $age, $candle_heights ) = input();
$extinguished_candle_count = birthday_cake_candles( $age, $candle_heights );
output( $extinguished_candle_count );
