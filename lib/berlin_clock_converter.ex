defmodule BerlinClockConverter do
  alias BerlinClock
  alias Lamp
  alias LampRow

  def convert(%Time{second: seconds, minute: minutes, hour: hours}) do
    %BerlinClock{
      seconds: seconds_lamp(seconds),
      single_hours: single_hours_lamps(hours),
      five_minutes: five_minutes_lamps(minutes),
      single_minutes: single_minutes_lamps(minutes)
    }
  end

  defp seconds_lamp(seconds) do
    if even?(seconds), do: :yellow, else: :off
  end

  defp even?(number), do: rem(number, 2) == 0

  defp single_hours_lamps(hours) do
    4
    |> LampsRow.create(fn _ -> false end, :red, :yellow)
    |> LampsRow.turn_on_lamps(rem(hours, 5))
  end

  defp five_minutes_lamps(minutes) do
    11
    |> LampsRow.create(&multiple_of_three?/1)
    |> LampsRow.turn_on_lamps(div(minutes, 5))
  end

  defp single_minutes_lamps(minutes) do
    4
    |> LampsRow.create()
    |> LampsRow.turn_on_lamps(rem(minutes, 5))
  end

  defp multiple_of_three?(index) when rem(index + 1, 3) == 0, do: true
  defp multiple_of_three?(_index), do: false
end
