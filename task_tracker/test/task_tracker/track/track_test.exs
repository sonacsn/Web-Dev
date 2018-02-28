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

  describe "manages" do
    alias TaskTracker.Track.Manage

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def manage_fixture(attrs \\ %{}) do
      {:ok, manage} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Track.create_manage()

      manage
    end

    test "list_manages/0 returns all manages" do
      manage = manage_fixture()
      assert Track.list_manages() == [manage]
    end

    test "get_manage!/1 returns the manage with given id" do
      manage = manage_fixture()
      assert Track.get_manage!(manage.id) == manage
    end

    test "create_manage/1 with valid data creates a manage" do
      assert {:ok, %Manage{} = manage} = Track.create_manage(@valid_attrs)
    end

    test "create_manage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Track.create_manage(@invalid_attrs)
    end

    test "update_manage/2 with valid data updates the manage" do
      manage = manage_fixture()
      assert {:ok, manage} = Track.update_manage(manage, @update_attrs)
      assert %Manage{} = manage
    end

    test "update_manage/2 with invalid data returns error changeset" do
      manage = manage_fixture()
      assert {:error, %Ecto.Changeset{}} = Track.update_manage(manage, @invalid_attrs)
      assert manage == Track.get_manage!(manage.id)
    end

    test "delete_manage/1 deletes the manage" do
      manage = manage_fixture()
      assert {:ok, %Manage{}} = Track.delete_manage(manage)
      assert_raise Ecto.NoResultsError, fn -> Track.get_manage!(manage.id) end
    end

    test "change_manage/1 returns a manage changeset" do
      manage = manage_fixture()
      assert %Ecto.Changeset{} = Track.change_manage(manage)
    end
  end

  describe "timeblocks" do
    alias TaskTracker.Track.TimeBlock

    @valid_attrs %{end: ~T[14:00:00.000000], start: ~T[14:00:00.000000]}
    @update_attrs %{end: ~T[15:01:01.000000], start: ~T[15:01:01.000000]}
    @invalid_attrs %{end: nil, start: nil}

    def time_block_fixture(attrs \\ %{}) do
      {:ok, time_block} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Track.create_time_block()

      time_block
    end

    test "list_timeblocks/0 returns all timeblocks" do
      time_block = time_block_fixture()
      assert Track.list_timeblocks() == [time_block]
    end

    test "get_time_block!/1 returns the time_block with given id" do
      time_block = time_block_fixture()
      assert Track.get_time_block!(time_block.id) == time_block
    end

    test "create_time_block/1 with valid data creates a time_block" do
      assert {:ok, %TimeBlock{} = time_block} = Track.create_time_block(@valid_attrs)
      assert time_block.end == ~T[14:00:00.000000]
      assert time_block.start == ~T[14:00:00.000000]
    end

    test "create_time_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Track.create_time_block(@invalid_attrs)
    end

    test "update_time_block/2 with valid data updates the time_block" do
      time_block = time_block_fixture()
      assert {:ok, time_block} = Track.update_time_block(time_block, @update_attrs)
      assert %TimeBlock{} = time_block
      assert time_block.end == ~T[15:01:01.000000]
      assert time_block.start == ~T[15:01:01.000000]
    end

    test "update_time_block/2 with invalid data returns error changeset" do
      time_block = time_block_fixture()
      assert {:error, %Ecto.Changeset{}} = Track.update_time_block(time_block, @invalid_attrs)
      assert time_block == Track.get_time_block!(time_block.id)
    end

    test "delete_time_block/1 deletes the time_block" do
      time_block = time_block_fixture()
      assert {:ok, %TimeBlock{}} = Track.delete_time_block(time_block)
      assert_raise Ecto.NoResultsError, fn -> Track.get_time_block!(time_block.id) end
    end

    test "change_time_block/1 returns a time_block changeset" do
      time_block = time_block_fixture()
      assert %Ecto.Changeset{} = Track.change_time_block(time_block)
    end
  end

  describe "timeblocks" do
    alias TaskTracker.Track.TimeBlock

    @valid_attrs %{end: ~T[14:00:00.000000], start: ~T[14:00:00.000000], started: true}
    @update_attrs %{end: ~T[15:01:01.000000], start: ~T[15:01:01.000000], started: false}
    @invalid_attrs %{end: nil, start: nil, started: nil}

    def time_block_fixture(attrs \\ %{}) do
      {:ok, time_block} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Track.create_time_block()

      time_block
    end

    test "list_timeblocks/0 returns all timeblocks" do
      time_block = time_block_fixture()
      assert Track.list_timeblocks() == [time_block]
    end

    test "get_time_block!/1 returns the time_block with given id" do
      time_block = time_block_fixture()
      assert Track.get_time_block!(time_block.id) == time_block
    end

    test "create_time_block/1 with valid data creates a time_block" do
      assert {:ok, %TimeBlock{} = time_block} = Track.create_time_block(@valid_attrs)
      assert time_block.end == ~T[14:00:00.000000]
      assert time_block.start == ~T[14:00:00.000000]
      assert time_block.started == true
    end

    test "create_time_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Track.create_time_block(@invalid_attrs)
    end

    test "update_time_block/2 with valid data updates the time_block" do
      time_block = time_block_fixture()
      assert {:ok, time_block} = Track.update_time_block(time_block, @update_attrs)
      assert %TimeBlock{} = time_block
      assert time_block.end == ~T[15:01:01.000000]
      assert time_block.start == ~T[15:01:01.000000]
      assert time_block.started == false
    end

    test "update_time_block/2 with invalid data returns error changeset" do
      time_block = time_block_fixture()
      assert {:error, %Ecto.Changeset{}} = Track.update_time_block(time_block, @invalid_attrs)
      assert time_block == Track.get_time_block!(time_block.id)
    end

    test "delete_time_block/1 deletes the time_block" do
      time_block = time_block_fixture()
      assert {:ok, %TimeBlock{}} = Track.delete_time_block(time_block)
      assert_raise Ecto.NoResultsError, fn -> Track.get_time_block!(time_block.id) end
    end

    test "change_time_block/1 returns a time_block changeset" do
      time_block = time_block_fixture()
      assert %Ecto.Changeset{} = Track.change_time_block(time_block)
    end
  end
end
