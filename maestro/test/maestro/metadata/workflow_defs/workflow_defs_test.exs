defmodule Maestro.Metadata.WorkflowDefsTest do
  use Maestro.DataCase
  alias Maestro.Metadata.WorkflowDefs

  describe "workflow_defs" do

    @valid_attrs %{
      "name" => "test_wf",
      "version" => 1,
      "tasks" => [%{
        "name" => "test_wf_task",
        "taskReferenceName" => "twt",
        "type" => "SIMPLE"
      }]
    }

    def workflow_def_fixture(attrs \\ %{}) do
      {:ok, workflow_def} =
        attrs
        |> Enum.into(@valid_attrs)
        |> WorkflowDefs.create_workflow_def()

      workflow_def
    end

    test "list_workflow_defs/0 returns all workflow_defs" do
      workflow_def = workflow_def_fixture()
      assert WorkflowDefs.list_workflow_defs() == [workflow_def]
    end

    test "get_workflow_def/1 returns latest workflow_def" do
      workflow_def_fixture(%{"version" => 1})
      workflow_def_fixture(%{"version" => 3})
      workflow_def_fixture(%{"version" => 2})

      expected_wf = %{"version" => 3} |> Enum.into(@valid_attrs)

      assert {:ok, expected_wf} == WorkflowDefs.get_workflow_def("test_wf")
    end

    test "get_workflow_def/1 returns err when not found" do
      assert {:error, :not_found} == WorkflowDefs.get_workflow_def("test_wf")
    end

    test "get_workflow_def/2 returns specified version" do
      workflow_def_fixture(%{"version" => 1})
      workflow_def_fixture(%{"version" => 2})

      expected_wf = %{"version" => 1} |> Enum.into(@valid_attrs)
      assert {:ok, expected_wf} == WorkflowDefs.get_workflow_def("test_wf", 1)
    end

    test "get_workflow_def/2 returns error when speciefied version not found" do
      workflow_def_fixture(%{"version" => 1})

      assert {:error, :not_found} == WorkflowDefs.get_workflow_def("test_wf", 2)
    end

    test "create_workflow_def/1 creates workflow_def" do
      assert @valid_attrs |> WorkflowDefs.create_workflow_def == {:ok, @valid_attrs}
    end

    test "create_workflow_def/1 returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
        %{"name" => nil}
        |> Enum.into(@valid_attrs )
        |> WorkflowDefs.create_workflow_def

      assert {:error, %Ecto.Changeset{}} =
        %{"version" => nil}
        |> Enum.into(@valid_attrs )
        |> WorkflowDefs.create_workflow_def
    end

  end
end
