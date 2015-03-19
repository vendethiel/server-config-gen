defmodule ServerConfigGen.Generator do
  require ADT
  # TODO it seems ADT doesn't define the structs *inside* of Generator
  ADT.define eex_template(variables: %{}) | yield_template(text: "")

  @templates %{
    "apache": "eex",
    "yield": "txt",
  }

  def generate(config) do
    ext = renderer_of(config[:kind])
    try do
      {:ok, content} = File.read("templates/#{config[:kind]}.#{ext}")
      {:ok, TemplateRenderer.render(template_for(ext, config), content)}
    rescue
      e -> {:error, e}
    end
  end

  defp renderer_of(template), do: Dict.fetch!(@templates, String.to_atom(template))

  defp template_for("eex", config), do: %EexTemplate{variables: config}
  defp template_for("txt", %{text: text}), do: %YieldTemplate{text: text}
end
