defmodule Maestro.Metadata.WorkflowDefs.WorkflowDefRecord do
  use Ecto.Schema
  import Ecto.Changeset
  alias Maestro.Metadata.WorkflowDefs.WorkflowDefRecord
  alias Maestro.Metadata.WorkflowDefs.WorkflowDef

  schema "workflow_defs" do
    field :name, :string
    embeds_one :document, WorkflowDef
    field :version, :integer

    timestamps()
  end

  def changeset(workflow_def) do
    %WorkflowDefRecord{}
    |> cast(workflow_def, [:name, :version])
    |> cast_embed(:document)
    |> validate_required([:name, :version])
  end
end
