defmodule IgrejotecaWeb.Utils.Translate do
  @translations %{
    "en" => %{
      "has invalid format" => "has an invalid format",
      # Outros mapeamentos de erro
    },
    "pt" => %{
      "email" => %{
        "has invalid format" => "possui um formato inválido",
      }
      # Outros mapeamentos de erro para português
    }
  }

  def translate_error(error, locale \\ "en") do
    IO.inspect(Map.fetch!(@translations, locale), label: "map fetch")
    case Map.fetch!(@translations, locale) do
      %{^error=> translations} ->
        IO.inspect(translations, label: "translations")
        translations
      _erro ->
        error
    end
  end
end
