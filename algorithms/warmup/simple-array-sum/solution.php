<?php

function simpleArraySum($n, $ar) {
    $sum = 0;
    foreach ($ar as $number) {
        $sum += $number;
    }
    return $sum;
}

$handle = fopen("php://stdin", "r");
fscanf($handle, "%i", $n);
$ar_temp = fgets($handle);
$ar = explode(" ", $ar_temp);
$ar = array_map('intval', $ar);
$result = simpleArraySum($n, $ar);
echo $result . "\n";
