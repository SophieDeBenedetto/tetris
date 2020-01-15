defmodule TetrisWeb.TetrisLive do
  @box_width 20
  @box_height 20
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(TetrisWeb.TetrisView, "show.html", assigns)
  end

  def mount(_session, socket) do
    if connected?(socket) do
      {:ok, new_game(socket)}
    else
      {:ok, assign(socket, boxes: nil)}
    end
  end

  def handle_event("keydown", %{"key" => "ArrowLeft"}, socket) do
    {:noreply, move(:left, socket)}
  end

  def handle_event("keydown", %{"key" => "ArrowRight"}, socket) do
    {:noreply, move(:right, socket)}
  end

  def handle_event("keydown", %{"key" => "ArrowDown"}, socket) do
    {:noreply, move(:down, socket)}
  end

  def handle_event("keydown", %{"key" => "ArrowUp"}, socket) do
    {:noreply, move(:turn, socket)}
  end

  def handle_event("keydown", _params, socket) do
    {:noreply, socket}
  end

  defp new_game(socket) do
    assign(socket,
      state: :playing,
      score: 0
    )
    |> new_block()
    |> show()
  end

  defp new_block(socket) do
    brick =
      Tetris.Brick.new_random()
      |> Map.put(:location, {3, 1})

    assign(socket, brick: brick)
  end

  defp show(%{assigns: %{brick: brick}} = socket) do
    points =
      brick
      |> Tetris.Brick.prepare
      |> Tetris.Points.move_to_location(brick.location)
      |> Tetris.Points.with_color(Tetris.Brick.color(brick))

    assign(socket, boxes: boxes(points))
  end

  def move(direction, socket) do
    socket
      |> assign(:brick, do_move(socket, direction))
      |> show()
  end

  defp do_move(%{assigns: %{brick: brick}}, :left) do
    Tetris.Brick.left(brick)
  end

  defp do_move(%{assigns: %{brick: brick}}, :right) do
    Tetris.Brick.right(brick)
  end

  defp do_move(%{assigns: %{brick: brick}}, :down) do
    Tetris.Brick.down(brick)
  end

  defp do_move(%{assigns: %{brick: brick}}, :turn) do
    Tetris.Brick.spin_90(brick)
  end

  defp boxes(points_with_colors) do
    points_with_colors
    |> Enum.map(fn {x, y, color} ->
        box({x,y}, color)
      end)
    |> Enum.join("\n")
  end

  defp box(point, color) do
    """
      #{square(point, shades(color).light)}
      #{triangle(point, shades(color).dark)}
    """
  end

  def square(point, shade) do
    {x, y} = to_pixels(point)
    """
    <rect
      x="#{x+1}" y="#{y+1}"
      style="fill:##{shade};"
      width="#{@box_width - 2}" height="#{@box_height - 1}"/>
    """
  end

  def triangle(point, shade) do
    {x, y} = to_pixels(point)
    {w, h} = {@box_width, @box_height}
    """
    <polyline
        style="fill:##{shade}"
        points="#{x + 1},#{y + 1} #{x + w},#{y + 1} #{x + w},#{y + h}" />
    """
  end

  defp to_pixels({x, y}) do
    {x * @box_width, y * @box_height}
  end

  defp shades(:red), do:    %{ light: "DB7160", dark: "AB574B"}
  defp shades(:blue), do:   %{ light: "83C1C8", dark: "66969C"}
  defp shades(:green), do:  %{ light: "8BBF57", dark: "769359"}
  defp shades(:orange), do: %{ light: "CB8E4E", dark: "AC7842"}
  defp shades(:grey), do:   %{ light: "A1A09E", dark: "7F7F7E"}
end
