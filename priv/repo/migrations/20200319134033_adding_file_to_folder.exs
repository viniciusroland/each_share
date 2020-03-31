defmodule EachShare.Repo.Migrations.AddingFileToFolder do
  use Ecto.Migration

  def change do
    alter table(:files) do
      add :folder_id, references(:folders), on_delete: :delete_all
    end
  end
end
