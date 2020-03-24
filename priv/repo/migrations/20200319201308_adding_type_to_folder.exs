defmodule EachShare.Repo.Migrations.AddingTypeToFolder do
  use Ecto.Migration

  def change do
    alter table(:folders) do
      add :type, :string
    end
  end
end
