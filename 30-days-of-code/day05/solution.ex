defmodule Solution do

  def run do
    parse_input()
      |> multiples_of()
      |> Stream.take(10)
      |> Enum.each(&print_multiple/1)
  end

  defp parse_input do
    {n, _} = IO.read(:line) |> Integer.parse
    n
  end

  defp multiples_of(n) do
    Stream.unfold({n, 1}, fn ({n, m}) -> {multiple_of(n, m), {n, m + 1}} end)
  end

  defp multiple_of(n, m) do
    %{:number => n, :multiple => m, :result => n * m}
  end

  defp print_multiple(%{:number => n, :multiple => m, :result => r}) do
    :io.format "~B x ~B = ~B~n", [n, m, r]
  end

end

Solution.run
