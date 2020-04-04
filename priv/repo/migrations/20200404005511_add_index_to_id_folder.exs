defmodule EachShare.Repo.Migrations.AddIndexToIdFolder do
  use Ecto.Migration

  def change do
    create index(:folders, [:id])
  end
end
