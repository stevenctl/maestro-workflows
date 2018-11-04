defmodule Maestro.Metadata.TaskDefs.TaskDef do
  use Ecto.Schema
  import Ecto.Changeset

  alias Maestro.Metadata.TaskDefs.TaskDef

  embedded_schema do
    field :name, :string
    field :retry_count, :integer
    field :timeout_seconds, :integer
    field :input_keys, {:array, :string}
    field :output_keys, {:array, :string}
    field :timeout_policy, :string
    field :retry_logic, :string
    field :retry_delay_seconds, :integer, default: 10
  end


  def changeset(schema, params) do
    schema
    |> cast(params, [
      :name, :retry_count, :timeout_seconds, :input_keys,
      :output_keys, :timeout_policy, :retry_logic, :retry_delay_seconds
    ])
    |> validate_required([:name, :retry_count, :timeout_seconds, :timeout_policy, :retry_logic])
    |> validate_inclusion(:timeout_policy, ["RETRY", "TIME_OUT_WF"])
    |> validate_inclusion(:retry_logic, ["FIXED", "EXPONENTIAL_BACKOFF"])

  end

end