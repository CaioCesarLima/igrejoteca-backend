defmodule Igrejoteca.Utils.HttpPoison do

  @doc false
  def push_notification(token, message, title) do
    url = "https://fcm.googleapis.com/fcm/send"

    body = "{
      \"to\": \"#{token}\",
      \"notification\":
        {
          \"title\": \"#{title}\",
          \"body\": \"#{message}\",
        }
    }"

    headers = [{"Content-type", "application/json"}, {"Authorization", "key=AAAAa1tsGck:APA91bHgb_kYg-CDptuzI1-JBtfI3TDMdgEtXyi2pX7Yf0UeMjBNGHj_MDVzAYyUWasPZED_Yf5SyouZ7_z4S5TsPDMgA7EpDY1r_rjWf2W2OWpOZbeh0EJKS8vFyO8JJ1cUt4yxzjck"}]


    case HTTPoison.post(url, body, headers, []) do
      {:ok, %{status_code: 200, body: body}} ->
        IO.puts(body)
    end
  end

  @doc false
  def validate(plain, hashed) do
      plain
      |> Argon2.verify_pass(hashed)
  end

end
