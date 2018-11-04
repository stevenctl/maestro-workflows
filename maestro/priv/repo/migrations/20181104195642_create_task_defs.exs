defmodule Maestro.Repo.Migrations.CreateTaskDefs do
  use Ecto.Migration

  def change do
    create table(:task_defs) do
      add :name, :string
      add :document, :map

      timestamps()
    end

    create unique_index(:workflow_defs, [:name], name: :task_def_unique_name)

  end
end
