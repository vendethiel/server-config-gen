defmodule ServerConfigGen.Parser do
  alias ServerConfigGen.ErrManager, as: Err
 
  # TODO only take content
  #  (and have a def parse(""))
  def parse({:ok, content}) when content != "" do
    # Tomlex returns a map, but need a keywords list for eex
    Err.try_wrap(fn -> Map.to_list(Tomlex.load(content)) end)
  end

  def parse(_), do: {:error, "invalid content"}
end
