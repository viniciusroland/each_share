defmodule EachShareWeb.StatusController do
  use EachShareWeb, :controller
  def check_status(conn, _params) do
    json(conn, %{"status" => "server up@"})
  end
end
