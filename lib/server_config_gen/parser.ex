defmodule ServerConfigGen.Parser do
  alias ServerConfigGen.TryOrError, as: Toe
  
  def parse(content) do
    Toe.wrap(fn -> Tomlex.load(content) end)
  end
end
