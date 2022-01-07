defmodule HangmanImplGameTest do
  use ExUnit.Case
  alias Hangman.Impl.Game
  # import Unicode

  test "new game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
    assert game.letters |> Enum.reduce(true, &(&2 && String.match?(&1, ~r/[a-z]/)))
    # assert Unicode.lowercase?(List.to_string(game.letters)) == true
  end

  test "new game returns correct word" do
    game = Game.new_game("wombat")

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert game.letters == ~w(w o m b a t)
    assert game.letters == ["w", "o", "m", "b", "a", "t"]
  end

  test "state doesn't change if game is won or lost" do
    for state <- [:won, :lost] do
      game = Game.new_game("wombat")
      game = Map.put(game, :game_state, state)
      {new_game, _tally} = Game.make_move(game, "x")

      assert new_game == game
    end
  end
end
