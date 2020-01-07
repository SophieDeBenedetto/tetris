defmodule Tetris.Brick do
  defstruct name: :i, location: {40, 0}, rotation: 0, reflection: false

  @spec new :: Tetris.Brick.t()
  def new(attributes \\ []), do: __MODULE__.__struct__(attributes)

  @spec new_random :: Tetris.Brick.t()
  def new_random do
    %__MODULE__{
      name: random_name(),
      location: {40, 0},
      rotation: random_rotation(),
      reflection: random_reflection()
    }
  end

  defp random_name do
    ~w(i l z o t)a
    |> Enum.random()
  end

  defp random_rotation do
    [0, 90, 180, 270]
    |> Enum.random()
  end

  defp random_reflection do
    [true, false]
    |> Enum.random()
  end

  @spec down(%{location: {number, number}}) :: %{location: {number, number}}
  def down(brick = %{location: location}) do
    %{brick | location: point_down(location)}
  end

  defp point_down({x, y}) do
    {x, y + 1}
  end

  @spec left(%{location: {number, number}}) :: %{location: {number, number}}
  def left(brick = %{location: location}) do
    %{brick | location: point_left(location)}
  end

  defp point_left({x, y}) do
    {x - 1, y}
  end

  @spec right(%{location: {number, number}}) :: %{location: {number, number}}
  def right(brick = %{location: location}) do
    %{brick | location: point_right(location)}
  end

  defp point_right({x, y}) do
    {x + 1, y}
  end

  @spec spin_90(%{rotation: number}) :: %{rotation: number}
  def spin_90(brick = %{rotation: rotation}) do
    %{brick | rotation: rotate(rotation)}
  end

  defp rotate(270), do: 0
  defp rotate(degrees), do: degrees + 90

  @spec points(%{name: :i | :l | :o | :t | :z}) :: [{2 | 3, 1 | 2 | 3 | 4}, ...]
  def points(%{name: :l}) do
    [
      {2, 1},
      {2, 2},
      {2, 3},
      {3, 3}
    ]
  end

  def points(%{name: :i}) do
    [
      {2, 1},
      {2, 2},
      {2, 3},
      {2, 4}
    ]
  end

  def points(%{name: :o}) do
    [
      {2, 2},
      {3, 2},
      {2, 3},
      {3, 3}
    ]
  end

  def points(%{name: :z}) do
    [
      {2, 2},
      {2, 3},
      {3, 3},
      {3, 4}
    ]
  end

  def points(%{name: :t}) do
    [
      {2, 1},
      {2, 2},
      {3, 3},
      {2, 3}
    ]
  end
end
