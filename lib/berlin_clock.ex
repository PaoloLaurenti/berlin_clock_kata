defmodule BerlinClock do
  defstruct seconds: :off,
            single_hours: [first: :off, second: :off, third: :off, fourth: :off],
            five_minutes: [
              first: :yellow,
              second: :off,
              third: :off,
              fourth: :off,
              fifth: :off,
              sixth: :off,
              seventh: :off,
              eighth: :off,
              ninth: :off,
              tenth: :off,
              eleventh: :off
            ],
            single_minutes: [first: :off, second: :off, third: :off, fourth: :off]
end
