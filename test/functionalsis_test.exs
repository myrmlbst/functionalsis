defmodule FunctionalsisTest do
  use ExUnit.Case
  doctest Functionalsis

  test "greets the world" do
    assert Functionalsis.hello() == :world
  end
end
