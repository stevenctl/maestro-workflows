defmodule MaestroWeb.WorkflowDefController do
  use MaestroWeb, :controller
  alias Maestro.Metadata.WorkflowDefs

  def get_workflows(conn, _params), do: json(conn, WorkflowDefs.list_workflow_defs() |> IO.inspect)

  def get_workflow(conn, %{"name" => name, "version" => version}),
      do: json(conn, WorkflowDefs.get_workflow_def(name, version))

  def get_workflow(conn, %{"name" => name}) do
    case WorkflowDefs.get_workflow_def(name) do
      {:ok, workflow_def} -> json(conn, workflow_def)
      {:error, :not_found} -> put_status(conn, :not_found)
                              |> json(%{"message" => "No workflow found with the name '#{name}'"})
    end
  end

  def get_workflow(conn, %{"name" => name, "version" => version}) do
    case WorkflowDefs.get_workflow_def(name, version) do
      {:ok, workflow_def} -> json(conn, workflow_def)
      {:error, :not_found} -> put_status(conn, :not_found)
                              |> json(%{"message" => "No workflow found with the name '#{name}' at version #{version}"})
    end
  end

end
