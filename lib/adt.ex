defmodule ADT do
  @moduledoc """
  Pseudo-ADT definition generator
  """

  @doc """
  Use it like this:

    iex> ADT.define foo(a: "default") | bar(b: "value")
    iex> %Foo(a: "my value")
  """
  defmacro define(parts) do
    parts |> flatten_parts |> Enum.map(&generate_defmodule/1)
  end

  defp flatten_parts({:|, _, [elem, rest]}) do
    [elem] ++ flatten_parts(rest)
  end
  defp flatten_parts(elem), do: [elem]

  def generate_defmodule({name, _, [fields]}) do
    # name is lowercase atom, need to capitalize + re-atom
    # fields is [name: val, name: val]
    module_name = name |> to_string |> String.capitalize
    # then, generate a module name from the string
    module_name = Module.concat([module_name])

    quote do
      defmodule unquote(module_name) do
        defstruct unquote(fields)
      end
    end
  end
end
