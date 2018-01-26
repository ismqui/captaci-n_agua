defmodule CaptacionAgua.LoadData do
  @remote_file_url "http://www.ine.es/jaxi/files/_px/es/csv_c/t26/p067/p01/serie/l0/01001.csv_c?nocab=1"

  def load_data do
    Download.get_file(@remote_file_url, "assets/captacion.dat")
  end

  def parse_data(name \\ "assets/captacion.dat") do
    {:ok, pid} = File.open(name, [:read, :utf8])
    read_titles(pid)
    years = read_years(pid)

    list_places = for _x <- 1..19, into: [], do: Map.merge(%CaptacionAgua.Captacion{}, read_data_place(pid, years))
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

  def read_titles(pid) do
    _titulo1     = IO.read(pid, :line)
    _titulo2     = IO.read(pid, :line)
    _descripcion = IO.read(pid, :line)
    _unidades    = IO.read(pid, :line)
    _linea       = IO.read(pid, :line)
  end

  def read_years(pid) do
    load_data(pid)
  end

  def read_data_place(pid, years) do
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

  defp load_place(pid) do
    IO.read(pid, :line) |> String.split(",") |> List.first
  end

  defp load_data(pid) do
    [ _h | t ] = IO.read(pid, :line) |> String.split("\n") |> List.first |> String.split(",")
    count = Enum.count(t)
    Enum.take(t, count - 1)
  end
end
