defmodule Tetris.BrickTest do
  use ExUnit.Case

  import Tetris.Brick
  alias Tetris.Points

  test "Creates a new brick" do
    brick = new()
    assert brick.name == :i
  end

  test "Creates a new random brick" do
    random_brick = new_random()
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

  test "Knows the points for :i shape" do
    brick = new(%{name: :i})

    assert points(brick) == [
             {2, 1},
             {2, 2},
             {2, 3},
             {2, 4}
           ]
  end

  test "Should translate a list of poits" do
    brick = new(%{name: :l})

    points =
      brick
      |> points()
      |> Points.translate({1, 1})

    assert points == [{3, 2}, {3, 3}, {3, 4}, {4, 4}]
  end

  test "should flip, rotate, flip and mirror points" do
    [{1, 1}]
    |> Points.mirror()
    |> assert_point({4, 1})
    |> Points.flip()
    |> assert_point({4, 4})
    |> Points.rotate_90()
    |> assert_point({1, 4})
    |> Points.rotate_90()
    |> assert_point({1, 1})
  end

  test "Should convert brick to string" do
    brick_string =
      new()
      |> Tetris.Brick.to_string()

    assert brick_string == "□■□□\n□■□□\n□■□□\n□■□□"
  end

  test "Should inspect bricks" do
    actual = new() |> inspect()

    expected = """
    □■□□
    □■□□
    □■□□
    □■□□
    {40, 0}
    false
    0
    """

    assert expected == "#{actual}\n"
  end

  def assert_point([points] = actual, expected) do
    assert points == expected
    actual
  end
end
