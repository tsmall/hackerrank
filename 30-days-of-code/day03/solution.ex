defmodule Solution do
  require Integer

  def run do
    parse_input()
      |> judge_number
      |> print_results
  end

  defp parse_input do
    {value, _} = IO.read(:line) |> Integer.parse
    value
  end

  defp judge_number(n) when Integer.is_odd(n) do
    "Weird"
  end

  defp judge_number(n) do
    cond do
      2 <= n && n <= 5 ->
        "Not Weird"
      6 <= n && n <= 20 ->
        "Weird"
      true ->
        "Not Weird"
    end
  end

  defp print_results(judgment) do
    IO.write judgment
  end

end

Solution.run
