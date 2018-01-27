defmodule CaptacionAgua.LoadData do
  @moduledoc """
    Module that defines the functions that downloads the file
    and parse it, to load it into memory.
  """

  @remote_file_url "http://www.ine.es/jaxi/files/_px/es/csv_c/t26/p067/p01/serie/l0/01001.csv_c?nocab=1"

  alias CaptacionAgua.Captacion

  @doc """
  Function that downloads the data file and saves it in directory assets/
  """
  def load_data do
    Download.get_file(@remote_file_url, "assets/captacion.dat")
  end

  @doc """
  Parse the download file and return the data in a list.

  ## Examples
      iex> CaptacionAgua.LoadData.parse_data
      [%CaptacionAgua.Captacion{desalacion: ["159569.0", "131132.0", "102665.0",
   "127878.0", "105968.0", "103388.0", "100450.0", "129396.0", "107850.0",
   "107114.0", "119824.0", "128217.0", "128927.0", "118450.0", "85572.0"],
  place: "España",
  subterraneas: ["1003828.0", "1124635.0", "1057111.0", "1004668.0",
   "1065852.0", "1118600.0", "1212979.0", "1226742.0", "1220691.0", "1147594.0",
   "1094961.0", "1179605.0", "996163.0", "970566.0", "928413.0"],
  superficiales: ["2436040.0", "2479923.0", "2402343.0", "2258931.0",
   "2463835.0", "2517139.0", "2443677.0", "2406481.0", "2511679.0", "2811633.0",
   "2978828.0", "2906338.0", "2980542.0", "3094641.0", "2999577.0"],
  total: ["3599437.0", "3735690.0", "3562119.0", "3391477.0", "3635655.0",
   "3739127.0", "3757106.0", "3762619.0", "3840220.0", "4066341.0", "4193613.0",
   "4214160.0", "4105632.0", "4183657.0", "4013562.0"],
  years: ["2014", "2013", "2012", "2011", "2010", "2009", "2008", "2007",
   "2006", "2005", "2004", "2003", "2002", "2001", "2000"]},
  ..]
  """
  @spec parse_data(String.t) :: Captacion.list_captacion
  def parse_data(name \\ "assets/captacion.dat") do
    {:ok, pid} = File.open(name, [:read, :utf8])
    read_titles(pid)
    years = read_years(pid)

    list_places = for _x <- 1..19, into: [],
      do: Map.merge(%Captacion{}, read_data_place(pid, years))
    _notas = IO.read(pid, :line)
    _fuente = IO.read(pid, :line)
    list_places
  end

#
# [years | places ] =
#   "assets/captacion.dat"
#     |> File.stream!
#     |> Stream.with_index
#     |> Stream.filter( fn {line, i} -> i > 4 and i < 101 end)
#     |> Stream.map(fn {line, i} -> line end)
#     |> Enum.take(100)
#
  @spec read_titles(pid) :: any
  defp read_titles(pid) do
    _titulo1     = IO.read(pid, :line)
    _titulo2     = IO.read(pid, :line)
    _descripcion = IO.read(pid, :line)
    _unidades    = IO.read(pid, :line)
    _linea       = IO.read(pid, :line)
  end

  @spec read_years(pid) :: [String.t]
  defp read_years(pid) do
    load_data(pid)
  end

  @spec read_data_place(pid, [String.t]) :: map
  defp read_data_place(pid, years) do
    place         = load_place(pid)
    total         = load_data(pid)
    superficiales = load_data(pid)
    subterraneas  = load_data(pid)
    desalacion    = load_data(pid)
    %{
      place: place,
      years: years,
      total: total,
      superficiales: superficiales,
      subterraneas: subterraneas,
      desalacion: desalacion
    }
  end

  @spec load_place(pid) :: [String.t]
  defp load_place(pid) do
    pid |> IO.read(:line) |> String.split(",") |> List.first
  end

  @spec load_data(pid) :: [String.t]
  defp load_data(pid) do
    [_h | t] =
      pid
      |> IO.read(:line)
      |> String.split("\n")
      |> List.first
      |> String.split(",")

    count = Enum.count(t)
    Enum.take(t, count - 1)
  end
end
