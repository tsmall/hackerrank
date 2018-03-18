defmodule Solution do

  def run do
    parse_input()
      |> Enum.map(&split_word/1)
      |> Enum.each(&print_split_word/1)
  end

  defp parse_input do
    {word_count, _} = IO.read(:line) |> Integer.parse
    parse_words word_count, []
  end

  defp split_word(word) do
    split_chars to_charlist(word), true, [], []
  end

  defp split_chars([], _, odds, evens) do
    %{:odds => odds, :evens => evens}
  end

  defp split_chars([h], is_odd, odds, evens) do
    if is_odd do
      split_chars [], not is_odd, odds ++ [h], evens
    else
      split_chars [], not is_odd, odds, evens ++ [h]
    end
  end

  defp split_chars([h | t], is_odd, odds, evens) do
    if is_odd do
      split_chars t, not is_odd, odds ++ [h], evens
    else
      split_chars t, not is_odd, odds, evens ++ [h]
    end
  end

  defp parse_words(0, results) do
    results
  end

  defp parse_words(count, results) do
    word = IO.read(:line) |> String.trim()
    parse_words count - 1, results ++ [word]
  end

  defp print_split_word(%{:evens => evens, :odds => odds}) do
    :io.format "~s ~s ~n", [odds, evens]
  end

end

Solution.run
