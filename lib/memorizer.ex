defmodule Memorizer do

  @consonants ["b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","z"]
  #vowels = ["a","e","i","u","o","y"]

  def get_memory_words(two_digit_num) do
    word_lis = word_list()
    get_consonants_from_num(two_digit_num)
    |> get_words_by_consonant(word_lis)
  end

  def word_list do
    "assets/words.txt"
    |> File.read!()
    |> String.split(~r/\n/)
    |> Enum.filter(fn str ->
      len = String.length(str)
      len < 6 && len > 3
    end)
  end

  def get_words_by_consonant([first_cons, second_cons], word_list) do
    word_list
    |> Enum.filter(
      fn word ->
        is_first_or_second(word,first_cons) && check_for_consonants(word, second_cons) && does_not_contain(word, except([first_cons,second_cons],@consonants))
      end)
  end

  defp except(not_list, complete_list) do
    complete_list -- not_list
  end

  defp does_not_contain(word, consonant_list) do
    reply = for consonant <- consonant_list, do: String.contains?(word,consonant)
    !Enum.any?(reply, fn x -> x == true end)
  end

  defp is_first_or_second(word, consonant) do
    String.at(word,0) == consonant || String.at(word,1) == consonant
  end

  defp check_for_consonants(word, consonant) do
    String.contains?(word, consonant)
  end

  def get_consonants_from_num(num_list) do
    for num <- num_list, do: num_to_consonant(num)
  end

  def num_to_consonant(num) do
    case num do
      0 -> Enum.random(["s","z"])
      1 -> Enum.random(["t","d"])
      2 -> "n"
      3 -> "m"
      4 -> "r"
      5 -> "l"
      6 -> Enum.random(["j","ch"])
      7 -> "k"
      8 -> "f"
      9 -> Enum.random(["p","b"])
    end
  end
end
