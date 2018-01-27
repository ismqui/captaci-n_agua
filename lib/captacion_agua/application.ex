defmodule CaptacionAgua.Application do
  @moduledoc """
    Module that starts the application.
  """
  use Application

  alias CaptacionAgua.CacheData

  @doc """
  Function that start the app, loads data from a file into cache with agents
  and waits for clients to call it. The function is call when the app is loaded.
  """
  def start(_type, _args) do
    IO.puts "Starting Captacion Agua..."
    {:ok, _pid} = CacheData.start_link()
  end

end
