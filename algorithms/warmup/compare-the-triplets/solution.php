<?php

function solve($alice_scores, $bob_scores){
    $alice_points = 0;
    $bob_points = 0;

    for ($i = 0; $i < 3; $i++) {
        $alice = $alice_scores[$i];
        $bob = $bob_scores[$i];

        if ($alice > $bob) {
            $alice_points += 1;
        }
        elseif ($bob > $alice) {
            $bob_points += 1;
        }
    }

    return [$alice_points, $bob_points];
}


$handle = fopen("php://stdin", "r");
fscanf($handle, "%d %d %d", $a0, $a1, $a2);
fscanf($handle, "%d %d %d", $b0, $b1, $b2);
$result = solve([$a0, $a1, $a2], [$b0, $b1, $b2]);
echo implode(" ", $result) . "\n";
