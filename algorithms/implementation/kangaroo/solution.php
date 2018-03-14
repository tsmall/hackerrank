<?php

function will_meet($roo1, $roo2) {
  if (at_same_point($roo1, $roo2)) {
    return true;
  }

  list ($back, $front) = order($roo1, $roo2);
  if (!can_meet($back, $front)) {
    return false;
  }
  advance_until_crossed($back, $front);
  return at_same_point($back, $front);
}


function order(&$x, &$y) {
  $x_first = ($x['position'] < $y['position']);
  return $x_first ? [$x, $y] : [$y, $x];
}


function can_meet(&$back, &$front) {
  return $front['velocity'] < $back['velocity'];
}


function at_same_point(&$x, &$y) {
  return $x['position'] == $y['position'];
}


function advance_until_crossed(&$back, &$front) {
  while ($back['position'] < $front['position']) {
    $back['position'] += $back['velocity'];
    $front['position'] += $front['velocity'];
  }
}


function yes_or_no($bool) {
  return $bool ? 'YES' : 'NO';
}


$handle = fopen("php://stdin", "r");
fscanf($handle, "%i %i %i %i", $x1, $v1, $x2, $v2);

$result = will_meet(
  ['position' => $x1, 'velocity' => $v1],
  ['position' => $x2, 'velocity' => $v2]
);

echo yes_or_no($result) . "\n";
