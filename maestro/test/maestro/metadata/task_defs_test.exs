defmodule Maestro.Metadata.TaskDefRecordsTest do
  use Maestro.DataCase

  alias Maestro.Metadata.TaskDefs

  describe "task_defs" do
    alias Maestro.Metadata.TaskDefs.TaskDef


    @valid_attrs %{
      "name" => "test_task",
      "retry_count" => 1,
      "timeout_seconds" => 30,
      "timeout_policy" => "RETRY",
      "retry_logic" => "FIXED"
    }

    @invalid_attrs %{
      "name" => "test_task",
      "retry_count" => 1,
      "timeout_seconds" => 30,
      "timeout_policy" => "NOT_REAL",
      "retry_logic" => "FIXED"
    }

    def task_def_fixture(attrs \\ %{}) do
      {:ok, task_def} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TaskDefs.save_task_def()
      task_def
    end

    test "list_task_defs/0 returns all task_defs" do
      task_def = task_def_fixture()
      assert TaskDefs.list_task_defs() == [task_def]
    end

    test "get_task_def/1 returns the task_def with given id" do
      task_def = task_def_fixture()
      assert TaskDefs.get_task_def(task_def.name) == {:ok, task_def}
    end

    test "save_task_def/1 with valid data creates a task_def" do
      assert {:ok, %TaskDef{name: "test_task"}} = TaskDefs.save_task_def(@valid_attrs)
    end

    test "save_task_def/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TaskDefs.save_task_def(@invalid_attrs)
    end

  end
end
