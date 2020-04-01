defmodule EachShareWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :each_share

  socket "/socket", EachShareWeb.UserSocket,
    websocket: true,
    longpoll: false

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "api/files",
    from: "priv/files"

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
  end


  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_each_share_key",
    signing_salt: "fqkIBAAU"

  # plug CORSPlug, origin: "*"
  plug Corsica,
    origins: [
      "http://localhost:3000",
      "https://eachshare.digital"
    ],
    allow_headers: ["accept", "content-type", "authorization"],
    allow_credentials: true

  plug EachShareWeb.Router
end
