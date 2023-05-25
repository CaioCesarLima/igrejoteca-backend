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

    headers = [{"Content-type", "application/json"}, {"Authorization", "key=AAAA5NlQu8k:APA91bHZ3O6lMewbdrbwLUNnTT1zSFNJj_xd8uoB1rQeiRQu14zDaVZ9Kz_BGj7N5sYGNosbN0r-xYVuTFgsoKR_NEJwqcaYws__CLKaenCgJTRTk3tEMz0qt7bjxdxUxUHAlUx3Bnt-"}]


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
