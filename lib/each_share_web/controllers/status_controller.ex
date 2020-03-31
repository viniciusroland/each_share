defmodule EachShareWeb.StatusController do
  use EachShareWeb, :controller
  def check_status(conn, _params) do
    json(conn, %{"server_status" => "up and running!"})
  end
end
