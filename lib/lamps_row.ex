defmodule LampsRow do
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
