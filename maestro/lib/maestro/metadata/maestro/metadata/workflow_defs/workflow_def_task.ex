defmodule Maestro.Metadata.WorkflowDefs.WorkflowDefTask do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :name, :string
    field :task_reference_name, :string
    field :type, :string
    field :description
    field :optional, :boolean, default: false
    field :input_parameters, {:map, :string}
    field :start_delay, :integer, default: 0
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:name, :task_reference_name, :type, :description, :optional, :input_parameters, :start_delay])
    |> validate_required([:name, :task_reference_name, :type])
  end


end
