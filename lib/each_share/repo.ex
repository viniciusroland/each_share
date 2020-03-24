defmodule EachShare.Repo do
  use Ecto.Repo,
    otp_app: :each_share,
    adapter: Ecto.Adapters.Postgres
end
