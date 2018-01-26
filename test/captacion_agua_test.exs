defmodule CaptacionAguaTest do
  use ExUnit.Case
  doctest CaptacionAgua

  test "load the list with all the data (19 registers)" do
    list_test = CaptacionAgua.LoadData.parse_data("assets/captacion_test.dat")
    assert Enum.count(list_test) == 19
  end

  test "the data load for the register spain (España)" do
    [spain] =
      CaptacionAgua.LoadData.parse_data("assets/captacion_test.dat")
      |> Enum.filter(fn x -> x.place == "España" end)

    assert spain.place == "España"
    assert Enum.count(spain.years) == Enum.count(spain.desalacion)
    assert Enum.count(spain.years) == Enum.count(spain.subterraneas)
    assert Enum.count(spain.years) == Enum.count(spain.superficiales)
    assert Enum.count(spain.years) == Enum.count(spain.total)
  end

  test "the data load for the register Canarias" do
    [canarias] =
      CaptacionAgua.LoadData.parse_data("assets/captacion_test.dat")
      |> Enum.filter(fn x -> x.place == "Canarias" end)

    assert canarias.place == "Canarias"
    assert Enum.count(canarias.years) == Enum.count(canarias.desalacion)
    assert Enum.count(canarias.years) == Enum.count(canarias.subterraneas)
    assert Enum.count(canarias.years) == Enum.count(canarias.superficiales)
    assert Enum.count(canarias.years) == Enum.count(canarias.total)
  end
end
