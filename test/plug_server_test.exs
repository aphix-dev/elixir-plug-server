defmodule PlugServerTest do
  use ExUnit.Case
  doctest PlugServer

  test "greets the world" do
    assert PlugServer.hello() == :world
  end
end
