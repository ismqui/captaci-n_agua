defmodule CaptacionAgua.CacheData do
  @moduledoc """
    Module that loads the data into an Agent, and defines the functions
    to get that data from memory.
  """

  alias CaptacionAgua.LoadData

  @doc """
  Loads the file data into an Agent.
  """
  def start_link do
    LoadData.load_data()
    list = LoadData.parse_data()
    Agent.start_link(fn -> list end, name: __MODULE__)
  end

  @doc """
  Get the data for an specific place from the Agent.

  ## Example
      iex> CaptacionAgua.CacheData.get_data("Canarias")
      [%CaptacionAgua.Captacion{desalacion: ["125386.0", "98271.0", "74736.0",
          "103635.0", "89535.0", "69694.0", "69589.0", "84500.0", "66991.0", "71941.0",
          "78051.0", "70816.0", "86031.0", "72802.0", "76835.0"], place: "Canarias",
         subterraneas: ["7803.0", "7382.0", "29100.0", "7192.0", "8652.0", "31580.0",
          "40257.0", "54873.0", "24173.0", "40415.0", "39025.0", "42423.0", "21452.0",
          "16778.0", "11657.0"],
         superficiales: ["5404.0", "9646.0", "23411.0", "22534.0", "47386.0",
          "38776.0", "29544.0", "33549.0", "38385.0", "17881.0", "18410.0", "14709.0",
          "19118.0", "14586.0", "18961.0"],
         total: ["138593.0", "115299.0", "127247.0", "133361.0", "145573.0",
          "140050.0", "139390.0", "172922.0", "129549.0", "130237.0", "135486.0",
          "127948.0", "126601.0", "104166.0", "107453.0"],
         years: ["2014", "2013", "2012", "2011", "2010", "2009", "2008", "2007",
          "2006", "2005", "2004", "2003", "2002", "2001", "2000"]}]
  """
  def get_data(place) do
    Agent.get(__MODULE__, fn list ->
       Enum.filter(list, fn x -> x.place == place end)
      end)
  end

  @doc """
  Get all the posible places from the Agent.

  ## Example
      iex> CaptacionAgua.CacheData.get_places
      ["España", "Andalucía", "Aragón", "Asturias", "Balears", "Canarias",
       "Cantabria", "Castilla y León", "Castilla-La Mancha", "Cataluña",
       "Comunitat Valenciana", "Extremadura", "Galicia", "Madrid", "Murcia",
       "Navarra", "País Vasco", "Rioja", "Ceuta y Melilla"]
  """
  def get_places do
    Agent.get(__MODULE__, fn list -> Enum.map(list, fn x -> x.place end) end)
  end

end
