defmodule CaptacionAgua.Captacion do

  @moduledoc """
    Module that defines the struct to insert the data.
  """
  defstruct [
    place: "",
    years: [],
    superficiales: [],
    subterraneas:  [],
    desalacion:    [],
    total:         []
  ]
  @type captacion_agua :: %CaptacionAgua.Captacion{
    place:          String.t,
    years:         [String.t],
    superficiales: [String.t],
    subterraneas:  [String.t],
    desalacion:    [String.t],
    total:         [String.t]
  }
  @type list_captacion :: [CaptacionAgua.Captacion.captacion_agua]
end
