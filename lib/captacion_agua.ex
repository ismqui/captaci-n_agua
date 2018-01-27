defmodule CaptacionAgua do
  @moduledoc """
  Module contains the API for the application.
  """

  @doc """
  API function that get the data for a specific place.

  ## Examples

    iex> CaptacionAgua.get_data("Extremadura")
    [%CaptacionAgua.Captacion{desalacion: ["0.0", "0.0", "0.0", "0.0", "0.0", "0.0",
       "0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0"],
      place: "Extremadura",
      subterraneas: ["7525.0", "16127.0", "6990.0", "10415.0", "7046.0", "1829.0",
       "1054.0", "8797.0", "9919.0", "9474.0", "24561.0", "21127.0", "30468.0",
       "41007.0", "13595.0"],
      superficiales: ["83507.0", "78191.0", "80535.0", "75062.0", "87195.0",
       "97373.0", "141059.0", "141535.0", "140453.0", "149820.0", "130441.0",
       "65072.0", "70718.0", "79729.0", "118573.0"],
      total: ["91032.0", "94318.0", "87525.0", "85477.0", "94241.0", "99202.0",
       "142113.0", "150332.0", "150372.0", "159294.0", "155002.0", "86199.0",
       "101186.0", "120736.0", "132168.0"],
      years: ["2014", "2013", "2012", "2011", "2010", "2009", "2008", "2007",
       "2006", "2005", "2004", "2003", "2002", "2001", "2000"]}]
  """
  defdelegate get_data(place), to: CaptacionAgua.CacheData

  @doc """
  API function that gets the data of all availables places.

  ## Example

    iex> CaptacionAgua.get_places
    ["España", "Andalucía", "Aragón", "Asturias", "Balears", "Canarias",
     "Cantabria", "Castilla y León", "Castilla-La Mancha", "Cataluña",
     "Comunitat Valenciana", "Extremadura", "Galicia", "Madrid", "Murcia",
     "Navarra", "País Vasco", "Rioja", "Ceuta y Melilla"]
  """
  defdelegate get_places(), to: CaptacionAgua.CacheData
end
