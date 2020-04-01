defmodule EachShareWeb.FolderController do
  use EachShareWeb, :controller
  alias EachShare.Folder
  def create(conn, %{"name" => name}) do
    case Folder.create_folder(%{
      "name" => name
    }) do
      {:ok, _folder} -> json(conn, %{"status" => "ok"})
      {:error, _error_changeset} ->
        conn
        |> put_status(:bad_request)
        |> json(%{"status" => "error"})
    end
  end

  def index(conn, params) do
    folders =
      Map.get(params, "type")
      |> Folder.list_folders()
      |> Folder.format()

    json(conn, folders)
  end

  def associate_folder(conn, %{"id" => id, "childs" => childs}) do
    for child <- childs, do: Folder.add_sub_folder(%{
      "id" => id,
      "child_name" => child["name"]
    })
    json(conn, %{"status" => "ok"})
  end

  def associate_file(conn, %{"file_name" => name, "file" => file, "folder_id" => folder_id}) do
    file_url = EachShare.File.save_uploaded_file(file)
    file_name = if name == "", do: file.filename, else: name
    Folder.add_file(folder_id, %{"file_name" => file_name, "file_url" => file_url})

    json(conn, %{"status" => "ok"})
  end

  def update(conn, %{"id" => id} = params) do
    folder = Folder.get_folder!(id)
    case Folder.update_folder(folder, params) do
      {:ok, __folder} -> json(conn, %{"status" => "ok"})
      {:error, _error_changeset} ->
        conn
        |> put_status(:bad_request)
        |> json(%{"status" => "error"})
    end
  end

  def show(conn, %{"id" => id}) do
    folder =
      id
      |> Folder.get_folder!()
      |> Folder.format()

    json(conn, folder)
  end

  def delete(conn, %{"id" => id}) do
    case get_req_header(conn, "authorization") do
      ["viniciusroland:123"] ->
        Folder.delete_folder(id)
        json(conn, %{"stats" => "ok"})
      _ -> conn |> put_status(:unauthorized) |> json(%{"error" => "bad auth"})
    end
  end
end
