defmodule EachShare.File do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias EachShare.Repo

  schema "files" do
    field :file_url, :string
    field :name, :string
    belongs_to :folder, EachShare.Folder

    timestamps()
  end

  @doc false
  def changeset(file, attrs) do
    file
    |> cast(attrs, [:name, :file_url])
    |> validate_required([:name, :file_url])
  end

  def save_uploaded_file(upload) do
    timestamp_seconds =  DateTime.utc_now |> DateTime.to_unix
    filename = "#{timestamp_seconds}-#{upload.filename}"
    File.cp(upload.path, "priv/files/#{filename}")

    filename
  end

  def list_files do
    Repo.all(EachShare.File)
  end

  def get_file!(id), do: Repo.get!(EachShare.File, id)

  def create_file(attrs \\ %{}) do
    %EachShare.File{}
    |> EachShare.File.changeset(attrs)
    |> Repo.insert()
  end

  def update_file(%EachShare.File{} = file, attrs) do
    file
    |> EachShare.File.changeset(attrs)
    |> Repo.update()
  end

  def delete_file(%EachShare.File{} = file) do
    Repo.delete(file)
  end

  def change_file(%EachShare.File{} = file) do
    EachShare.File.changeset(file, %{})
  end

  # formatar resultado
  def format(contents) when is_list(contents) do
    for content <- contents, into: [], do: format(content)
  end

  def format(e) do
    %{
      id: e.id,
      name: e.name,
      file_url: e.file_url
    }
  end
end
