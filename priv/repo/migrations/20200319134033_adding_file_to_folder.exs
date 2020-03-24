defmodule EachShare.Repo.Migrations.AddingFileToFolder do
  use Ecto.Migration

  def change do
    alter table(:files) do
      add :folder_id, references(:folders)
    end
  end
end
