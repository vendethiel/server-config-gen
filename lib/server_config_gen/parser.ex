defmodule ServerConfigGen.Parser do
  alias ServerConfigGen.ErrManager, as: Err

  def parse(_, ""), do: {:error, "invalid content"}
 
  def parse("toml", content) do
    # Tomlex returns a map, but need a keywords list for eex
    Err.try_wrap(fn -> Map.to_list(Tomlex.load(content)) end)
  end

  def parse(ext, _), do: {:error, "no parser available for #{ext}"}
end
