defmodule TaskTrackerWeb.TaskController do
  import Ecto.Query, warn: false
  alias TaskTracker.Repo
  use TaskTrackerWeb, :controller

  alias TaskTracker.Track
  alias TaskTracker.Track.Task

  def index(conn, _params) do
    tasks = Track.list_tasks()
    render(conn, "index.html", tasks: tasks, user_list: create_user_list)
  end

  defp create_user_list() do
    query = from(u in TaskTracker.Accounts.User, select: {u.name, u.id})
    Repo.all(query)
  end

  def new(conn, _params) do
    changeset = Track.change_task(%Task{})
    render(conn, "new.html", changeset: changeset, user_list: create_user_list)
  end

  def create(conn, %{"task" => task_params}) do
    case Track.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, user_list: create_user_list)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Track.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Track.get_task!(id)
    changeset = Track.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset, user_list: create_user_list)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Track.get_task!(id)

    case Track.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset, user_list: create_user_list)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Track.get_task!(id)
    {:ok, _task} = Track.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end
end
