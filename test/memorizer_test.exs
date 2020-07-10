defmodule MemorizerTest do
  use ExUnit.Case
  doctest Memorizer

  test "greets the world" do
    assert Memorizer.hello() == :world
  end
end
