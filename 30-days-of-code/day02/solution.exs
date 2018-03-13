# Input
{meal_cost, _} = IO.read(:line) |> Float.parse
{tip_pct, _} = IO.read(:line) |> Integer.parse
{tax_pct, _} = IO.read(:line) |> Integer.parse

# Computation
tip = meal_cost * (tip_pct / 100)
tax = meal_cost * (tax_pct / 100)
total = meal_cost + tip + tax

# Output
IO.write "The total meal cost is "
IO.write round(total)
IO.write " dollars."
