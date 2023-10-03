defmodule IgrejotecaWeb.Utils.Translate do
  @translations %{
    "en" => %{
      "email" => %{
        "has invalid format" => "Email has an invalid format",
      }
    },
    "pt" => %{
      :email => %{
        "has invalid format" => "Email possui um formato inválido",
        "has already been taken" => "Email já cadastrado, tente realizar login",
      },
      :password => %{
        "has invalid format" => "A senha possui um formato inválido",
      }
    }
  }

  def translate_error(error, locale \\ "en") do
    pt_errors = Map.fetch!(@translations, locale)
    key = List.first(Map.keys(error))
    case Map.get(pt_errors, key) do
      %{"" => translation} ->
        translation
      erro ->
        erro
    end
  end
end
