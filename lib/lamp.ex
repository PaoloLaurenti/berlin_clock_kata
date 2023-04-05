defmodule Lamp do
  defstruct color: :yellow, status: :off

  def create_yellow_lamp(), do: %__MODULE__{}
  def create_red_lamp(), do: %__MODULE__{color: :red}

  def turn_on(lamp), do: %__MODULE__{lamp | status: :on}
  def turn_off(lamp), do: %__MODULE__{lamp | status: :off}

  def get_light(%__MODULE__{status: :off}), do: :off
  def get_light(%__MODULE__{color: color}), do: color
end
