defmodule Tetris.BrickTest do
  use ExUnit.Case

  import Tetris.Brick

  test "Creates a new brick" do
    brick = Tetris.Brick.new()
    assert brick.name == :i
  end

  test "Creates a new random brick" do
    random_brick = Tetris.Brick.new_random()
    assert Enum.member?(~w(i l z o t)a, random_brick.name)
  end

  test "Should manipulate brick" do
    actual =
    new()
    |> left()
    |> right()
    |> right()
    |> down()
    |> spin_90()
    |> spin_90()

    assert actual.location == {41, 1}
    assert actual.rotation == 180
  end
end
