defmodule IgrejotecaWeb.Utils.Translate do
  @translations %{
    "en" => %{
      "has invalid format" => "has an invalid format",
      # Outros mapeamentos de erro
    },
    "pt" => %{
      "has invalid format" => "possui um formato inválido",
      # Outros mapeamentos de erro para português
    }
  }

  def translate_error(error_message, locale \\ "en") do
    IO.inspect(locale, label: "Locale")
    IO.inspect(error_message, label: "error_message")
    IO.inspect(@translations, label: "Translations")
    IO.inspect(Map.fetch!(@translations, locale), label: "map fetch")
    case Map.fetch!(@translations, locale) do
      {_, translations} ->
        Map.get(translations, error_message, error_message)
      erro ->
        error_message
    end
  end
end
