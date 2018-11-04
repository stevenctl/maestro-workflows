defmodule Maestro.Metadata.WorkflowDefs.WorkflowDef do
  use Ecto.Schema
  import Ecto.Changeset

  alias Maestro.Metadata.WorkflowDefs.WorkflowDefTask

  embedded_schema do
    field :name, :string
    field :version, :integer
    field :description, :string
    embeds_many :tasks, WorkflowDefTask
    field :input_parameters, {:array, :string}
    field :output_parameters, {:map, :string}
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:name, :version, :description, :input_parameters, :output_parameters])
    |> cast_embed(:tasks)
    |> validate_required([:name, :version])
  end
end
