defmodule Solution do

  def run do
    parse_input()
      |> will_meet()
      |> print_results()
  end

  defp parse_input do
    [x1, v1, x2, v2] =
      IO.read(:line)
        |> String.split(" ", trim: true)
        |> Enum.map(&Integer.parse/1)
        |> Enum.map(fn({n, _}) -> n end)

    [%{:position => x1, :velocity => v1},
     %{:position => x2, :velocity => v2}]
  end

  defp will_meet([%{:position => x1}, %{:position => x2}]) when x1 == x2 do
    true
  end

  defp will_meet([roo1, roo2]) do
    [back, front] = order(roo1, roo2)
    if not can_meet(back, front) do
      false
    else
      [back, front] = advance_until_crossed(back, front)
      back.position == front.position
    end
  end

  defp order(x, y) do
    Enum.sort_by([x, y], &(&1.position))
  end

  defp can_meet(back, front) do
    back.velocity > front.velocity
  end

  defp advance_until_crossed(back, front) do
    if back.position < front.position do
      advance_until_crossed(
        %{back | :position => back.position + back.velocity},
        %{front | :position => front.position + front.velocity}
      )
    else
      [back, front]
    end
  end

  defp print_results(will_meet) do
    yes_or_no = if will_meet, do: "YES", else: "NO"
    IO.puts yes_or_no
  end

end

Solution.run
