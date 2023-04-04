defmodule BerlinClockConverterTest do
  use ExUnit.Case

  alias BerlinClock

  describe "converts seconds with seconds lamp" do
    test "returning yellow lamp on even seconds" do
      result = BerlinClockConverter.convert(~T"00:00:00")

      assert result == %BerlinClock{seconds: :yellow}
    end

    test "returning lamp off on odd seconds" do
      result = BerlinClockConverter.convert(~T"00:00:01")

      assert result == %BerlinClock{seconds: :off}
    end
  end

  describe "converts minutes with single minutes lamp" do
    test "returning first lamp of single minutes on when minutes figures ends with 1" do
      result = BerlinClockConverter.convert(~T"00:01:00")

      assert %BerlinClock{single_minutes: [first: :yellow, second: :off, third: :off, fourth: :off]} = result
    end

    test "returning first lamp of single minutes on when minutes figures ends with 6" do
      result = BerlinClockConverter.convert(~T"00:06:00")

      assert %BerlinClock{single_minutes: [first: :yellow, second: :off, third: :off, fourth: :off]} = result
    end

    test "returning all lamps of single minutes off when minutes figures ends with 0" do
      result = BerlinClockConverter.convert(~T"00:00:00")

      assert %BerlinClock{single_minutes: [first: :off, second: :off, third: :off, fourth: :off]} = result
    end

    test "returning all lamps of single minutes off when minutes figures ends with 5" do
      result = BerlinClockConverter.convert(~T"00:00:00")

      assert %BerlinClock{single_minutes: [first: :off, second: :off, third: :off, fourth: :off]} = result
    end

    test "returning first two lamps of single minutes on when minutes figures ends with 2" do
      result = BerlinClockConverter.convert(~T"00:02:00")

      assert %BerlinClock{single_minutes: [first: :yellow, second: :yellow, third: :off, fourth: :off]} = result
    end

    test "returning first two lamps of single minutes on when minutes figures ends with 7" do
      result = BerlinClockConverter.convert(~T"00:07:00")

      assert %BerlinClock{single_minutes: [first: :yellow, second: :yellow, third: :off, fourth: :off]} = result
    end

    test "returning first three lamps of single minutes on when minutes figures ends with 3" do
      result = BerlinClockConverter.convert(~T"00:03:00")

      assert %BerlinClock{single_minutes: [first: :yellow, second: :yellow, third: :yellow, fourth: :off]} = result
    end

    test "returning first three lamps of single minutes on when minutes figures ends with 8" do
      result = BerlinClockConverter.convert(~T"00:08:00")

      assert %BerlinClock{single_minutes: [first: :yellow, second: :yellow, third: :yellow, fourth: :off]} = result
    end

    test "returning all lamps of single minutes on when minutes figures ends with 4" do
      result = BerlinClockConverter.convert(~T"00:04:00")

      assert %BerlinClock{single_minutes: [first: :yellow, second: :yellow, third: :yellow, fourth: :yellow]} = result
    end

    test "returning all lamps of single minutes on when minutes figures ends with 9" do
      result = BerlinClockConverter.convert(~T"00:09:00")

      assert %BerlinClock{single_minutes: [first: :yellow, second: :yellow, third: :yellow, fourth: :yellow]} = result
    end
  end
end
