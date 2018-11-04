defmodule Maestro.Metadata.WorkflowDefs do
  @moduledoc """
  The Metadata context.
  """

  import Ecto.Query, warn: false
  alias Maestro.Repo

  alias Maestro.Metadata.WorkflowDefs.WorkflowDefRecord

  def list_workflow_defs do
    Repo.all(WorkflowDefRecord)
    |> Enum.map(fn wf -> wf.document end)
  end

  def get_workflow_def(name) do
    query = from wf in WorkflowDefRecord,
             where: wf.name == ^name,
             order_by: [desc: wf.version],
             limit: 1

    case Repo.all(query) |> Enum.at(0) do
      %{name: ^name} = wf ->  {:ok, wf.document}
      nil -> {:error, :not_found}
    end

  end

  def get_workflow_def(name, version) do
    case Repo.get_by(WorkflowDefRecord, name: name, version: version) do
      %{name: ^name} = wf ->  {:ok, wf.document}
      nil -> {:error, :not_found}
    end
  end

  def create_workflow_def(doc) do
    name = Map.get(doc, "name")
    version = Map.get(doc, "version")

    record = %{
      "name" => name,
      "version" => version,
      "document" => doc
    }
    case WorkflowDefRecord.changeset(record) |> Repo.insert() do
        {:ok, workflow_def} -> {:ok, workflow_def.document}
        err -> err
    end
  end

end
