defmodule Maestro.Metadata.TaskDefs.TaskDefRecord do
  use Ecto.Schema
  import Ecto.Changeset

  alias Maestro.Metadata.TaskDefs.TaskDef

  schema "task_defs" do
    field :name, :string
    embeds_one :document, TaskDef

    timestamps()
  end

  @doc false
  def changeset(task_def, attrs) do
    task_def
    |> cast(attrs, [:name])
    |> cast_embed(:document)
    |> validate_required(:name)
    |> unique_constraint(:name)
  end
end
