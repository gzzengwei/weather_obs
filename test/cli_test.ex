defmodule CliTest do
  use ExUnit.Case
  import WeatherObs.CLI, only: [ parse_args: 1 ]

  test ":help return by option parsing with -h and --help" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["-help", "anything"]) == :help
  end

  test "two values return by given two inputs" do
    assert parse_args(["current", "ABCD"]) == {:current, "ABCD"}
  end
end
