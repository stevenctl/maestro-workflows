defmodule MaestroWeb.WorkflowDefController do
  use MaestroWeb, :controller
  alias Maestro.Metadata.WorkflowDefs

  def get_workflows(conn, _params), do: json(conn, WorkflowDefs.list_workflow_defs() |> IO.inspect)


  def get_workflow(conn, %{"name" => name, "version" => version}) do
    case WorkflowDefs.get_workflow_def(name, version) do
      {:ok, workflow_def} -> json(conn, workflow_def)
      {:error, :not_found} -> put_status(conn, :not_found)
                              |> json(%{"message" => "No workflow found with the name '#{name}' and version #{version}"})
    end
  end

  def get_workflow(conn, %{"name" => name}) do
    case WorkflowDefs.get_workflow_def(name) do
      {:ok, workflow_def} -> json(conn, workflow_def)
      {:error, :not_found} -> put_status(conn, :not_found)
                              |> json(%{"message" => "No workflow found with the name '#{name}'"})
    end
  end

  def create_workflow(conn, params) do
    case WorkflowDefs.create_workflow_def(params) do
      {:ok, _} -> send_resp(conn, :no_content, "")
      {:error, _} -> put_status(conn, :bad_request)
                          |> json(%{"message" => "Failed to create workflow. Make sure the definition is valid and another workflow does not exist with the same name and version. "})
    end
  end


end
