defmodule Solution do

  def run do
    parse_input()
      |> factorial()
      |> print_results()
  end

  defp factorial(1), do: 1
  defp factorial(n) do
    n * factorial(n - 1)
  end

  defp parse_input do
    {n, _} = IO.read(:line) |> Integer.parse
    n
  end

  defp print_results(result) do
    IO.write result
  end

end

Solution.run
