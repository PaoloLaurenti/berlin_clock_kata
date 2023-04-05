defmodule BerlinClockConverter do
  alias BerlinClock

  def convert(%Time{second: seconds, minute: minutes}) do
    %BerlinClock{
      seconds: seconds_lamp(seconds),
      five_minutes: five_minutes_lamps(minutes),
      single_minutes: single_minutes_lamps(minutes)
    }
  end

  defp seconds_lamp(seconds) do
    if even?(seconds), do: :yellow, else: :off
  end

  defp even?(number), do: rem(number, 2) == 0

  defp single_minutes_lamps(minutes) do
    4
    |> LampsRow.create()
    |> LampsRow.turn_on_lamps(rem(minutes, 5))
  end

  defp five_minutes_lamps(minutes) do
    11
    |> LampsRow.create(&is_five_minutes_red_lamp/1)
    |> LampsRow.turn_on_lamps(div(minutes, 5))
  end

  defp is_five_minutes_red_lamp(index) when rem(index + 1, 3) == 0, do: true
  defp is_five_minutes_red_lamp(_index), do: false
end

defmodule LampsRow do
  @default_color_lamp :yellow
  @alternate_color_lamp :red
  @available_lamps [
    :first,
    :second,
    :third,
    :fourth,
    :fifth,
    :sixth,
    :seventh,
    :eighth,
    :ninth,
    :tenth,
    :eleventh
  ]

  defstruct lamps: []

  def create(lamps_count, red_lamp_predicate \\ fn _ -> false end) do
    lamps =
      @available_lamps
      |> Enum.with_index()
      |> Enum.map(fn {lamp_ordinal_seq, index} ->
        lamp =
          if red_lamp_predicate.(index),
            do: Lamp.create_red_lamp(),
            else: Lamp.create_yellow_lamp()

        {lamp_ordinal_seq, lamp}
      end)
      |> Enum.slice(0..(lamps_count - 1))

    %__MODULE__{lamps: lamps}
  end

  def turn_on_lamps(%__MODULE__{lamps: lamps}, lamps_to_turn_on) do
    lamps
    |> Enum.with_index()
    |> Enum.map(fn
      {{lamp_ordinal_seq, lamp}, index} when index < lamps_to_turn_on ->
        {lamp_ordinal_seq, Lamp.turn_on(lamp)}

      {{lamp_ordinal_seq, lamp}, _index} ->
        {lamp_ordinal_seq, Lamp.turn_off(lamp)}
    end)
    |> Enum.map(fn {lamp_ordinal_seq, lamp} -> {lamp_ordinal_seq, Lamp.get_light(lamp)} end)
  end
end

defmodule Lamp do
  defstruct color: :yellow, status: :off

  def create_yellow_lamp(), do: %__MODULE__{}
  def create_red_lamp(), do: %__MODULE__{color: :red}

  def turn_on(lamp), do: %__MODULE__{lamp | status: :on}
  def turn_off(lamp), do: %__MODULE__{lamp | status: :off}

  def get_light(%__MODULE__{status: :off}), do: :off
  def get_light(%__MODULE__{color: color}), do: color
end
