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
    case Map.fetch!(@translations, locale) do
      %{^error=> translations} ->
        IO.inspect(translations, label: "translations")
        translations
      erro ->
        error_message
    end
  end
end
