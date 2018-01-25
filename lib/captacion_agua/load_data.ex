defmodule CaptacionAgua.LoadData do
  @remote_file_url "http://www.ine.es/jaxi/files/_px/es/csv_c/t26/p067/p01/serie/l0/01001.csv_c?nocab=1"

  def load_data do
    Download.get_file(@remote_file_url, "assets/captacion.dat")
  end
end
