defmodule BerlinClockConverterTest do
  use ExUnit.Case

  alias BerlinClock

  describe "converts seconds with seconds lamp" do
    test "returning yellow lamp on even seconds" do
      result = BerlinClockConverter.convert(~T"00:00:00")

      assert %BerlinClock{seconds: :yellow} = result
    end

    test "returning lamp off on odd seconds" do
      result = BerlinClockConverter.convert(~T"00:00:01")

      assert %BerlinClock{seconds: :off} = result
    end
  end

  describe "converts minutes with single minutes lamps" do
    test "returning first lamp on when minutes figures ends with 1" do
      result = BerlinClockConverter.convert(~T"00:01:00")

      assert %BerlinClock{
               single_minutes: [first: :yellow, second: :off, third: :off, fourth: :off]
             } = result
    end

    test "returning first lamp on when minutes figures ends with 6" do
      result = BerlinClockConverter.convert(~T"00:06:00")

      assert %BerlinClock{
               single_minutes: [first: :yellow, second: :off, third: :off, fourth: :off]
             } = result
    end

    test "returning all lamps off when minutes figures ends with 0" do
      result = BerlinClockConverter.convert(~T"00:00:00")

      assert %BerlinClock{single_minutes: [first: :off, second: :off, third: :off, fourth: :off]} =
               result
    end

    test "returning all lamps off when minutes figures ends with 5" do
      result = BerlinClockConverter.convert(~T"00:00:00")

      assert %BerlinClock{single_minutes: [first: :off, second: :off, third: :off, fourth: :off]} =
               result
    end

    test "returning first two lamps on when minutes figures ends with 2" do
      result = BerlinClockConverter.convert(~T"00:02:00")

      assert %BerlinClock{
               single_minutes: [first: :yellow, second: :yellow, third: :off, fourth: :off]
             } = result
    end

    test "returning first two lamps when minutes figures ends with 7" do
      result = BerlinClockConverter.convert(~T"00:07:00")

      assert %BerlinClock{
               single_minutes: [first: :yellow, second: :yellow, third: :off, fourth: :off]
             } = result
    end

    test "returning first three lamps on when minutes figures ends with 3" do
      result = BerlinClockConverter.convert(~T"00:03:00")

      assert %BerlinClock{
               single_minutes: [first: :yellow, second: :yellow, third: :yellow, fourth: :off]
             } = result
    end

    test "returning first three lamps on when minutes figures ends with 8" do
      result = BerlinClockConverter.convert(~T"00:08:00")

      assert %BerlinClock{
               single_minutes: [first: :yellow, second: :yellow, third: :yellow, fourth: :off]
             } = result
    end

    test "returning all lamps on when minutes figures ends with 4" do
      result = BerlinClockConverter.convert(~T"00:04:00")

      assert %BerlinClock{
               single_minutes: [first: :yellow, second: :yellow, third: :yellow, fourth: :yellow]
             } = result
    end

    test "returning all lamps on when minutes figures ends with 9" do
      result = BerlinClockConverter.convert(~T"00:09:00")

      assert %BerlinClock{
               single_minutes: [first: :yellow, second: :yellow, third: :yellow, fourth: :yellow]
             } = result
    end
  end

  describe "converts minutes with five minutes lamps" do
    test "returning first yellow lamp on when minutes are >= 5" do
      result = BerlinClockConverter.convert(~T"00:05:00")

      assert %BerlinClock{
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
               ]
             } = result
    end

    test "returning first two yellow lamps on when minutes are >= 10" do
      result = BerlinClockConverter.convert(~T"00:10:00")

      assert %BerlinClock{
               five_minutes: [
                 first: :yellow,
                 second: :yellow,
                 third: :off,
                 fourth: :off,
                 fifth: :off,
                 sixth: :off,
                 seventh: :off,
                 eighth: :off,
                 ninth: :off,
                 tenth: :off,
                 eleventh: :off
               ]
             } = result
    end

    test "returning first two yellow lamps and the third red on when minutes are >= 15" do
      result = BerlinClockConverter.convert(~T"00:15:00")

      assert %BerlinClock{
               five_minutes: [
                 first: :yellow,
                 second: :yellow,
                 third: :red,
                 fourth: :off,
                 fifth: :off,
                 sixth: :off,
                 seventh: :off,
                 eighth: :off,
                 ninth: :off,
                 tenth: :off,
                 eleventh: :off
               ]
             } = result
    end

    test "returning all lamps op when minutes are >= 55" do
      result = BerlinClockConverter.convert(~T"00:55:00")

      assert %BerlinClock{
               five_minutes: [
                 first: :yellow,
                 second: :yellow,
                 third: :red,
                 fourth: :yellow,
                 fifth: :yellow,
                 sixth: :red,
                 seventh: :yellow,
                 eighth: :yellow,
                 ninth: :red,
                 tenth: :yellow,
                 eleventh: :yellow
               ]
             } = result
    end

    test "returning all lamps op when minutes are equal to 59" do
      result = BerlinClockConverter.convert(~T"00:59:00")

      assert %BerlinClock{
               five_minutes: [
                 first: :yellow,
                 second: :yellow,
                 third: :red,
                 fourth: :yellow,
                 fifth: :yellow,
                 sixth: :red,
                 seventh: :yellow,
                 eighth: :yellow,
                 ninth: :red,
                 tenth: :yellow,
                 eleventh: :yellow
               ]
             } = result
    end
  end

  describe "converts hours with single hours lamps" do
    test "returning first lamp on when hours figures ends with 1" do
      result = BerlinClockConverter.convert(~T"01:00:00")

      assert %BerlinClock{
               single_hours: [first: :red, second: :off, third: :off, fourth: :off]
             } = result
    end

    test "returning first lamp on when hours figures ends with 6" do
      result = BerlinClockConverter.convert(~T"06:00:00")

      assert %BerlinClock{
               single_hours: [first: :red, second: :off, third: :off, fourth: :off]
             } = result
    end

    test "returning all lamps off when hours figures ends with 0" do
      result = BerlinClockConverter.convert(~T"00:00:00")

      assert %BerlinClock{single_hours: [first: :off, second: :off, third: :off, fourth: :off]} =
               result
    end

    test "returning all lamps off when hours figures ends with 5" do
      result = BerlinClockConverter.convert(~T"05:00:00")

      assert %BerlinClock{single_hours: [first: :off, second: :off, third: :off, fourth: :off]} =
               result
    end

    test "returning first two lamps on when hours figures ends with 2" do
      result = BerlinClockConverter.convert(~T"02:00:00")

      assert %BerlinClock{
               single_hours: [first: :red, second: :red, third: :off, fourth: :off]
             } = result
    end

    test "returning first two lamps when hours figures ends with 7" do
      result = BerlinClockConverter.convert(~T"07:00:00")

      assert %BerlinClock{
               single_hours: [first: :red, second: :red, third: :off, fourth: :off]
             } = result
    end

    test "returning first three lamps on when hours figures ends with 3" do
      result = BerlinClockConverter.convert(~T"03:00:00")

      assert %BerlinClock{
               single_hours: [first: :red, second: :red, third: :red, fourth: :off]
             } = result
    end

    test "returning first three lamps on when hours figures ends with 8" do
      result = BerlinClockConverter.convert(~T"08:08:00")

      assert %BerlinClock{
               single_hours: [first: :red, second: :red, third: :red, fourth: :off]
             } = result
    end

    test "returning all lamps on when hours figures ends with 4" do
      result = BerlinClockConverter.convert(~T"04:00:00")

      assert %BerlinClock{
               single_hours: [first: :red, second: :red, third: :red, fourth: :red]
             } = result
    end

    test "returning all lamps on when hours figures ends with 9" do
      result = BerlinClockConverter.convert(~T"09:00:00")

      assert %BerlinClock{
               single_hours: [first: :red, second: :red, third: :red, fourth: :red]
             } = result
    end
  end

  describe "converts hours with five hours lamps" do
    test "returning first red lamp on when hours are >= 5" do
      result = BerlinClockConverter.convert(~T"05:00:00")

      assert %BerlinClock{five_hours: [first: :red, second: :off, third: :off, fourth: :off]} =
               result
    end

    test "returning first two red lamps on when hours are >= 10" do
      result = BerlinClockConverter.convert(~T"10:00:00")

      assert %BerlinClock{five_hours: [first: :red, second: :red, third: :off, fourth: :off]} =
               result
    end

    test "returning first three red lamps on when hours are >= 15" do
      result = BerlinClockConverter.convert(~T"15:00:00")

      assert %BerlinClock{five_hours: [first: :red, second: :red, third: :red, fourth: :off]} =
        result
    end

    test "returning all lamps op when hours are >= 20" do
      result = BerlinClockConverter.convert(~T"20:00:00")

      assert %BerlinClock{five_hours: [first: :red, second: :red, third: :red, fourth: :red]} =
        result
    end
  end
end
