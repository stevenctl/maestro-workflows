defmodule Maestro.Repo.Migrations.CreateWorkflowDefs do
  use Ecto.Migration

  def change do
    create table(:workflow_defs) do
      add :name, :string
      add :version, :integer
      add :document, :map

      timestamps()
    end

    create unique_index(:workflow_defs, [:name, :version], name: :workflow_def_unique_name_version)

  end
end
