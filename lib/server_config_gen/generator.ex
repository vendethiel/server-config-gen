defmodule ServerConfigGen.Generator do
  def generate(config) do
    IO.inspect "config", config
    case config[:kind] do
      :apache ->
        IO.puts "hey its apache"
        {:ok, []}
      _ ->
        {:error, "lol fialed cant parse :("}
    end
  end
end
