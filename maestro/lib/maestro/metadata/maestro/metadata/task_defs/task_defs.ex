defmodule Maestro.Metadata.TaskDefs do
  @moduledoc """
  The Metadata context.
  """

  import Ecto.Query, warn: false
  alias Maestro.Repo

  alias Maestro.Metadata.TaskDefs.TaskDefRecord

  def list_task_defs do
    Repo.all(TaskDefRecord)
    |> Enum.map(fn r -> r.document end)
  end

  def get_task_def(name) do
    case Repo.get_by(TaskDefRecord, name: name) do
      nil -> {:error, :not_found}
      record -> {:ok, record.document}
    end
  end

  def save_task_def(doc) do
    name = Map.get(doc, "name")

    record = %{
      "name" => name,
      "document" => doc
    }

    case TaskDefRecord.changeset(%TaskDefRecord{}, record) |> Repo.insert() do
      {:ok, task_def} -> {:ok, task_def.document}
      err -> err
    end
  end


end
