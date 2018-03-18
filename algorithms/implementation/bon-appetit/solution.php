<?php

function main() {
  $bill_info = parse_input();
  $difference = calculate_difference($bill_info);
  print_results($difference);
}

function calculate_difference($bill_info) {
  $item_costs = $bill_info['item_costs'];
  $skipped_item_index = $bill_info['skipped_item_index'];
  $amount_charged = $bill_info['amount_charged'];

  $split_item_costs = array_values_except($item_costs, [$skipped_item_index]);
  $amount_expected = array_sum($split_item_costs) / 2;
  $difference = $amount_charged - $amount_expected;

  return $difference;
}

function array_values_except($array, $skip_indexes) {
  $result = [];
  foreach (range(0, count($array) - 1) as $i) {
    if (!in_array($i, $skip_indexes)) {
      $result[] = $array[$i];
    }
  }
  return $result;
}

function parse_input() {
  $handle = fopen("php://stdin","r");

  fscanf($handle, "%d %d", $item_count, $skipped_item_index);

  $arr_temp = fgets($handle);
  $item_costs = explode(" ", $arr_temp);
  array_walk($item_costs, 'intval');

  fscanf($handle, "%d", $amount_charged);

  return [
    'item_costs' => $item_costs,
    'skipped_item_index' => $skipped_item_index,
    'amount_charged' => $amount_charged,
  ];
}

function print_results($difference) {
  if ($difference == 0) {
    echo "Bon Appetit\n";
  } else {
    echo $difference . "\n";
  }
}

main();
