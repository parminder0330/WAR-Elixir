defmodule War do
  @moduledoc """
    Documentation for `War`.
  """

  @doc """
    Function stub for deal/1 is given below. Feel free to add
    as many additional helper functions as you want.

    The tests for the deal function can be found in test/war_test.exs.
    You can add your five test cases to this file.

    Run the tester by executing 'mix test' from the war directory
    (the one containing mix.exs)
  """
  def take(l, n) do #take function takes a list and integer to take at n intervals
    l |> Enum.with_index(1) |> Enum.filter(fn {_, i} -> rem(i, n) == 0 end) |> Enum.map(&elem(&1, 0))
  end
  def drop(l, n) do #give function takes a list and integer to drop at n intervals
    l |> Enum.with_index(1) |> Enum.reject(fn {_, i} -> rem(i, n) == 0 end) |> Enum.map(&elem(&1, 0))
  end
  def deal(shuf) do #main deal function which assigns cards to player1 and player2 and plays the game of war
    acc = []
    {player1, player2} = {shuf |> take(2) |> Enum.reverse(), shuf |> drop(2) |> Enum.reverse()}
    {newplayer1, newplayer2} = {player1 |> Enum.map(fn a -> if a == 1, do: 14, else: a end), player2 |> Enum.map(fn a -> if a == 1, do: 14, else: a end)}
    play(newplayer1, newplayer2, acc)
  end
  def play([], [], acc) do #when player1 and player 2 both are empty then this function returns accumulator as war chest
    played=Enum.sort(acc, :desc) #sorts in descending order
    played |> Enum.map(fn a -> if a == 14, do: 1, else: a end)
  end
  def play(player1, [], acc) do #when player1 wins
    played = player1 ++ acc
    played |> Enum.map(fn a -> if a == 14, do: 1, else: a end)
  end
  def play([], player2, acc) do #when player2 wins
    played = player2 ++ acc
    played |> Enum.map(fn a -> if a == 14, do: 1, else: a end)
  end
  def play([c1|r1], [c2|r2], acc) when c1 > c2 do #when player1's card is bigger than player2's card
    played=Enum.sort([c1, c2] ++ acc, :desc)
    play(r1 ++ played, r2, [])
  end
  def play([c1|r1], [c2|r2], acc) when c1 < c2 do #when player2's card is bigger than player1's card
    played=Enum.sort([c1, c2] ++ acc, :desc)
    play(r1, r2 ++ played, [])
  end
  def play([c1|r1], [c2|r2], acc) when length([c1|r1]) > 1 and length([c2|r2]) > 1 do #checks if length is greater than 1 and then recrusively calls to accumulate cards (for war purposes)
    play(tl(r1), tl(r2), acc ++ [c1, c2, hd(r1), hd(r2)])
  end
  def play([c1], [c2|r2], acc) do #pattern matching when player1 has one card
    played = Enum.sort(acc ++ [c1, c2], :desc)
    play([], r2 ++ played, [])
  end
  def play([c1|r1], [c2], acc) do #pattern matching when player2 has one card
      played=Enum.sort(acc ++ [c1, c2], :desc)
      play(r1 ++ played, [], [])
  end
end
