defmodule EachShare.Repo do
  use Ecto.Repo,
    otp_app: :each_share,
    adapter: Ecto.Adapters.Postgres

  # def init(_, config) do
  #   config = config
  #     |> Keyword.put(:hostname, System.get_env("POSTGRES_HOSTNAME"))
  #   {:ok, config}
  # end
end
