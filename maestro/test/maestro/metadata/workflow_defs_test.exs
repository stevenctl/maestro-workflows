defmodule Maestro.Metadata.WorkflowDefsTest do
  use Maestro.DataCase
  alias Maestro.Metadata.WorkflowDefs

  alias Maestro.Metadata.WorkflowDefs.WorkflowDef
  alias Maestro.Metadata.WorkflowDefs.WorkflowDefTask


  describe "workflow_defs" do

    @valid_attrs %{
      "name" => "test_wf",
      "version" => 1,
      "tasks" => [%{
        "name" => "test_wf_task",
        "task_reference_name" => "twt",
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
      expected_wf = workflow_def_fixture(%{"version" => 3})

      assert {:ok, expected_wf} == WorkflowDefs.get_workflow_def("test_wf")
    end

    test "get_workflow_def/1 returns err when not found" do
      assert {:error, :not_found} == WorkflowDefs.get_workflow_def("test_wf")
    end

    test "get_workflow_def/2 returns specified version" do
      _expected_wf = workflow_def_fixture(%{"version" => 1})
      workflow_def_fixture(%{"version" => 2})

      assert {:ok, _expected_wf} = WorkflowDefs.get_workflow_def("test_wf", 1)
    end

    test "get_workflow_def/2 returns error when speciefied version not found" do
      workflow_def_fixture(%{"version" => 1})

      assert {:error, :not_found} == WorkflowDefs.get_workflow_def("test_wf", 2)
    end

    test "create_workflow_def/1 creates workflow_def" do
      _expected =  %WorkflowDef{
        name: "test_wf",
        tasks: [%WorkflowDefTask{name: "test_wf_task"}],
        version: 1
      }
      assert _expected = WorkflowDefs.create_workflow_def(@valid_attrs)

    end

    test "create_workflow_def/1 returns error changeset when name not defined" do
      assert {:error, %Ecto.Changeset{}} =
               @valid_attrs
               |> Map.delete("version")
               |> WorkflowDefs.create_workflow_def
    end

    test "create_workflow_def/1 returns error changeset when version not defined" do
      assert {:error, %Ecto.Changeset{}} =
               @valid_attrs
               |> Map.delete("version")
               |> WorkflowDefs.create_workflow_def
    end


    test "create_workflow_def/1 returns error changeset when task has no name" do

      no_name_task = Map.delete(@valid_attrs["tasks"] |> Enum.at(0), "name")
      assert {:error, %Ecto.Changeset{}} =
               %{"tasks" => [no_name_task]}
               |> Enum.into(@valid_attrs)
               |> WorkflowDefs.create_workflow_def
    end

    test "create_workflow_def/1 returns error changeset when task has no reference name" do

      no_name_task = Map.delete(@valid_attrs["tasks"] |> Enum.at(0), "task_reference_name")
      assert {:error, %Ecto.Changeset{}} =
               %{"tasks" => [no_name_task]}
               |> Enum.into(@valid_attrs)
               |> WorkflowDefs.create_workflow_def
    end


    test "create_workflow_def/1 returns error changeset when task has no type" do

      no_name_task = Map.delete(@valid_attrs["tasks"] |> Enum.at(0), "type")
      assert {:error, %Ecto.Changeset{}} =
               %{"tasks" => [no_name_task]}
               |> Enum.into(@valid_attrs)
               |> WorkflowDefs.create_workflow_def
    end

  end
end
