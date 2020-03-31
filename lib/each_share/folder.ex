defmodule EachShare.Folder do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias EachShare.Repo
  alias EachShare.Folder

  schema "folders" do
    field :name, :string
    field :type, :string
    belongs_to :folder, EachShare.Folder
    has_many :sub_folders, EachShare.Folder, foreign_key: :folder_id, on_replace: :delete, on_delete: :delete_all
    has_many :files, EachShare.File, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(folder, attrs) do
    folder
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def list_folders(type) when is_nil(type) do
    Repo.all(Folder) |> Repo.preload([:sub_folders, :files])
  end

  def list_folders(type) do
    Repo.all(from f in Folder, where: f.type == ^type, preload: [:sub_folders, :files])
  end

  def get_folder!(id), do: Repo.one(from f in Folder, where: f.id == ^id, preload: [:sub_folders, :files])

  def create_folder(attrs \\ %{}) do
    %Folder{}
    |> Folder.changeset(attrs)
    |> Repo.insert()
  end

  def update_folder(%Folder{} = folder, attrs) do
    folder
    |> Folder.changeset(attrs)
    |> Repo.update()
  end

  def delete_folder(folder_id) do
    Repo.get(Folder, folder_id)
    |> Repo.delete()
  end

  def change_folder(%Folder{} = folder) do
    Folder.changeset(folder, %{})
  end

  def add_sub_folder(%{"id" => id, "child_name" => child_name}) do
    folder = get_folder!(id)

    folder
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:sub_folders, [%Folder{name: child_name} | folder.sub_folders])
    |> Repo.update!
  end

  def add_file(folder_id, %{"file_name" => file_name, "file_url" => file_url}) do
    Repo.get!(Folder, folder_id)
    |> Ecto.build_assoc(:files, %EachShare.File{name: file_name, file_url: file_url})
    |> Repo.insert!()
  end

  def format(folders) when is_list(folders) do
    for folder <- folders, into: [], do: format(folder)
  end

  def format(e) do
    %{
      id: e.id,
      name: e.name,
      sub_folders: format_sub_folders(e.sub_folders),
      files: format_files(e.files)
    }
  end

  def format_files(files) do
    for file <- files, into: [], do: %{name: file.name, id: file.id, file_url: file.file_url}
  end

  def format_sub_folders(sub_folders) do
    for folder <- sub_folders, into: [], do: %{name: folder.name, id: folder.id}
  end
end
