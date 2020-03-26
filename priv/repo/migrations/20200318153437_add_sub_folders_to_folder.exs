defmodule EachShare.Repo.Migrations.AddSubFoldersToFolder do
  use Ecto.Migration

  def change do
    alter table(:folders) do
      add :folder_id, references(:folders), on_delete: :delete_all
    end
  end
end
