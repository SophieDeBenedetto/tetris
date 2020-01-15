defmodule Tetris do
  alias Tetris.{Brick, Points}

  def new_brick do
    Brick.new_random()
    |> Map.put(:location, {3, 1})
  end

  def points_for_brick(brick) do
    brick
    |> Brick.prepare
    |> Points.move_to_location(brick.location)
    |> Points.with_color(Brick.color(brick))
  end

  def move_left(brick), do: Brick.left(brick)
  def move_right(brick), do: Brick.right(brick)
  def spin_90(brick), do: Brick.spin_90(brick)
  def move_down(brick), do: Brick.down(brick)
end
