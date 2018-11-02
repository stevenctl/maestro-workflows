defmodule MaestroWeb.Router do
  use MaestroWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MaestroWeb do
    pipe_through :api
  end

  scope "/api/metadata", MaestroWeb do
    get("/workflow", WofklowDefController, :get_workflows)
    get("/workflow/:name", WofklowDefController, :get_workflow)
    post("/workflow", WorkflowDefController, :create_workflow)
  end

end
