defmodule AdyenWeb.PageController do
  use AdyenWeb, :controller

  def index(conn, _params) do
    case create_session() do
      {:ok, response} ->
        session_id = response.body["id"]
        sessionData = response.body["sessionData"]

        render(conn, "index.html", session_id: session_id, sessionData: sessionData)

      {:error, _response} ->
        render(conn, "index.html", session_id: nil, sessionData: nil)
    end

  end

  def checkout(conn, %{"sessionId" => sessionId, "shopperOrder" => shopperOrder}) do

    IO.inspect(sessionId, label: "sessionId ....")
    IO.inspect(shopperOrder, label: "shopperOrder ....")

    render(conn, "success.html", session_id: nil, sessionData: nil)
  end

  defp create_session() do
    payload = %{
      "merchantAccount" => "ShuaibECOM",
      "amount" => %{
        "value" => 3000,
        "currency" => "GBP"
      },
      "returnUrl" => "http://localhost:4000/checkout?shopperOrder=#{Nanoid.generate(10)}",
      "reference" => Nanoid.generate(44),
      "countryCode" => "GB"
    }

    Tesla.post(client(), "/sessions", payload)
  end

  defp client() do
    middleware = [
      {Tesla.Middleware.BaseUrl, "https://checkout-test.adyen.com/v69"},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers,
       [
         {"x-API-key",
          api_key()}
       ]}
    ]

    Tesla.client(middleware)
  end
  defp api_key() do
    "AQEhhmfuXNWTK0Qc+iSDmnE5ruYLAbWrFHNL9vWG9COopgMWEMFdWw2+5HzctViMSCJMYAc=-sxm9GVZASO0LHHLDhCIQYcJn4Q22nPY9AWjdDSR5JLk=-YPT6T6=w}&X;Wevp"
  end
end
