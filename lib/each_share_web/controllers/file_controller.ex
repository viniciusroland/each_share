defmodule EachShareWeb.FileController do
  use EachShareWeb, :controller

  def upload_file(conn, %{"file" => uploaded_file, "name" => name}) do
    file_url = EachShare.File.save_uploaded_file(uploaded_file)

    case EachShare.File.create_file(%{
      "name" => name,
      "file_url" => file_url
    }) do
      {:ok, _file} -> 
        json(conn, %{"status" => "ok"})
      _ -> 
        conn
        |> put_status(:bad_request)
        |> json(%{"status" => "error"})
    end
  end

  def upload_file(conn, _) do
    conn
    |> put_status(:bad_request)
    |> json(%{"error" => "missing file"})
  end
end