defmodule IgrejotecaWeb.AuthView do
    use IgrejotecaWeb, :view
    alias IgrejotecaWeb.AuthView

    def render("login.json", %{auth: data}) do
        render_one(data, AuthView, "auth.json")
    end

    def render("auth.json",%{auth: %{token: token, user: user}}) do
      %{
        token: token,
        user: %{
            id: user.id,
            name: user.name,
            email: user.email
        }
      }
    end
  end
