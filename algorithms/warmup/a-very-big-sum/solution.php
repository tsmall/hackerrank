<?php

function aVeryBigSum($n, $ar) {
    return array_sum($ar);
}


$handle = fopen ("php://stdin", "r");

fscanf($handle, "%i",$n);
$ar_temp = fgets($handle);
$ar = explode(" ", $ar_temp);
$ar = array_map('intval', $ar);

$result = aVeryBigSum($n, $ar);
echo $result . "\n";
