defmodule IgrejotecaWeb.Utils.Response do
    use IgrejotecaWeb, :controller

    defp send_return(conn, status_code) do
        conn
        |> resp(status_code, "")
        |> send_resp()
        |> halt()
    end

    def ok(conn),
        do: send_return(conn, 200)

    def created(conn),
        do: send_return(conn, 201)

    def bad_request(conn),
        do: send_return(conn, 400)

    def unauthorized(conn),
        do: send_return(conn, 401)

    def forbidden(conn),
        do: send_return(conn, 403)

    def not_found(conn),
        do: send_return(conn, 404)

    def method_not_allowed(conn),
        do: send_return(conn, 405)

    def conflict(conn),
        do: send_return(conn, 409)

    def internal_error(conn),
        do: send_return(conn, 500)
end
