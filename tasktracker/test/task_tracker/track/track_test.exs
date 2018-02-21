defmodule TaskTracker.TrackTest do
  use TaskTracker.DataCase

  alias TaskTracker.Track

  describe "tasks" do
    alias TaskTracker.Track.Task

    @valid_attrs %{description: "some description", duration: ~T[14:00:00.000000], title: "some title"}
    @update_attrs %{description: "some updated description", duration: ~T[15:01:01.000000], title: "some updated title"}
    @invalid_attrs %{description: nil, duration: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Track.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Track.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Track.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Track.create_task(@valid_attrs)
      assert task.description == "some description"
      assert task.duration == ~T[14:00:00.000000]
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Track.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Track.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.description == "some updated description"
      assert task.duration == ~T[15:01:01.000000]
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Track.update_task(task, @invalid_attrs)
      assert task == Track.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Track.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Track.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Track.change_task(task)
    end
  end

  describe "tasks" do
    alias TaskTracker.Track.Task

    @valid_attrs %{description: "some description", duration: ~T[14:00:00.000000], status: true, title: "some title"}
    @update_attrs %{description: "some updated description", duration: ~T[15:01:01.000000], status: false, title: "some updated title"}
    @invalid_attrs %{description: nil, duration: nil, status: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Track.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Track.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Track.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Track.create_task(@valid_attrs)
      assert task.description == "some description"
      assert task.duration == ~T[14:00:00.000000]
      assert task.status == true
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Track.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Track.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.description == "some updated description"
      assert task.duration == ~T[15:01:01.000000]
      assert task.status == false
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Track.update_task(task, @invalid_attrs)
      assert task == Track.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Track.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Track.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Track.change_task(task)
    end
  end

  describe "tasks" do
    alias TaskTracker.Track.Task

    @valid_attrs %{completed: true, description: "some description", duration: ~T[14:00:00.000000], title: "some title"}
    @update_attrs %{completed: false, description: "some updated description", duration: ~T[15:01:01.000000], title: "some updated title"}
    @invalid_attrs %{completed: nil, description: nil, duration: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Track.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Track.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Track.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Track.create_task(@valid_attrs)
      assert task.completed == true
      assert task.description == "some description"
      assert task.duration == ~T[14:00:00.000000]
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Track.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Track.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.completed == false
      assert task.description == "some updated description"
      assert task.duration == ~T[15:01:01.000000]
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Track.update_task(task, @invalid_attrs)
      assert task == Track.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Track.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Track.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Track.change_task(task)
    end
  end
end
