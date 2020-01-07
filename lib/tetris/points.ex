defmodule Tetris.Points do
  def translate(points, _adjustment = {x, y}) do
    Enum.map(points, fn {dx, dy} ->
      {dx + x, dy + y}
    end)
  end

  def rotate(points, 0), do: points
  def rotate(points, degrees) do
    points
    |> rotate_90()
    |> rotate(degrees - 90)
  end

  def rotate_90(points) do
    points
    |> transpose()
    |> mirror()
  end

  def transpose(points) do
    Enum.map(points, fn {x, y} ->
      {y, x}
    end)
  end

  def mirror(points) do
    Enum.map(points, fn {x,y} ->
      {5 - x, y}
    end)
  end

  def flip(points) do
    Enum.map(points, fn {x,y} ->
      {x, 5 - y}
    end)
  end
end
