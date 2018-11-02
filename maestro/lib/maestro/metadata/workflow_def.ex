defmodule Maestro.Metadata.WorkflowDefs.WorkflowDef do
  use Ecto.Schema
  import Ecto.Changeset
  alias Maestro.Metadata.WorkflowDefs.WorkflowDef


  schema "workflow_defs" do
    field :name, :string
    field :document, :map
    field :version, :integer

    timestamps()
  end

  @doc false
  def changeset(workflow_def) do
    %WorkflowDef{}
    |> cast(workflow_def, [:name, :version, :document])
    |> validate_required([:name, :version, :document])
  end
end
