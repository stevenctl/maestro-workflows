defmodule MaestroWeb.Router do
  use MaestroWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/metadata", MaestroWeb do
    pipe_through :api
    get("/workflows", WorkflowDefController, :get_workflows)
    get("/workflows/:name", WorkflowDefController, :get_workflow)

  end

end
