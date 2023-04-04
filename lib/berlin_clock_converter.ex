defmodule BerlinClockConverter do
  alias BerlinClock

  def convert(%Time{second: seconds, minute: minutes}) do
    %BerlinClock{
      seconds: seconds_lamp(seconds),
      single_minutes: single_minutes_lamps(minutes)
    }
  end

  defp seconds_lamp(seconds) do
    if even?(seconds) do
      :yellow
    else
      :off
    end
  end

  defp even?(number), do: rem(number, 2) == 0

  defp single_minutes_lamps(minutes) do
    lamps = [:first, :second, :third, :fourth]
    lamps_to_turn_on = rem(minutes, 5)

    lamps
    |> Enum.with_index()
    |> Enum.map(fn
      {lamp, index} when index < lamps_to_turn_on -> {lamp, :yellow}
      {lamp, _index} -> {lamp, :off}
    end)
  end

  # defp single_minutes_lamps(minutes) when minutes == 1 or minutes == 6,
  #   do: [first: :yellow, second: :off, third: :off, fourth: :off]

  # defp single_minutes_lamps(minutes) when minutes == 2 or minutes == 7,
  #   do: [first: :yellow, second: :yellow, third: :off, fourth: :off]

  # defp single_minutes_lamps(minutes) when minutes == 3 or minutes == 8,
  #   do: [first: :yellow, second: :yellow, third: :yellow, fourth: :off]

  # defp single_minutes_lamps(minutes) when minutes == 4 or minutes == 9,
  #   do: [first: :yellow, second: :yellow, third: :yellow, fourth: :yellow]

  # defp single_minutes_lamps(_minutes) do
  #   [
  #     first: :off,
  #     second: :off,
  #     third: :off,
  #     fourth: :off
  #   ]
  # end
end
