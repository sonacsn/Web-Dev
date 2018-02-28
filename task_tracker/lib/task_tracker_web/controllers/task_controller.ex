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
    user = conn.assigns[:current_user]
    manages_map = Track.manages_map_for(user.id)
    user_id_list = Map.keys(manages_map)
    user_list = Track.get_managee(user_id_list)
    render(conn, "new.html", changeset: changeset, user_list: user_list, blocks: [])
  end

  def create(conn, %{"task" => task_params}) do
    case Track.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        user = conn.assigns[:current_user]
        manages_map = Track.manages_map_for(user.id)
        user_id_list = Map.keys(manages_map)
        user_list = Track.get_managee(user_id_list)
        render(conn, "new.html", changeset: changeset, user_list: user_list, blocks: [])
    end
  end

  def show(conn, %{"id" => id}) do
    task = Track.get_task!(id)
    started_block = Track.get_any_started_block(task)
    block_id = if started_block != nil && started_block != [] do 
	block = (hd started_block)
 	block.id
    else
	""
    end

    render(conn, "show.html", task: task, started_block: block_id)
  end

  def edit(conn, %{"id" => id}) do
    task = Track.get_task!(id)
    changeset = Track.change_task(task)
    user = conn.assigns[:current_user]
    manages_map = Track.manages_map_for(user.id)
    user_id_list = Map.keys(manages_map)
    user_list = Track.get_managee(user_id_list)
    blocks = Track.get_blocks(id)
    started_block = Track.get_any_started_block(task)
    block_id = if started_block != nil && started_block != [] do 
	block = (hd started_block)
 	block.id
    else
	""
    end
    render(conn, "edit.html", task: task, changeset: changeset, user_list: user_list, blocks: blocks, started_block: block_id )
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Track.get_task!(id)
    task_params = Map.put(task_params, "duration", Track.calculate_duration(task))
    case Track.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
    user = conn.assigns[:current_user]
    manages_map = Track.manages_map_for(user.id)
    user_id_list = Map.keys(manages_map)
    user_list = Track.get_managee(user_id_list)
    blocks = Track.get_blocks(id)
        render(conn, "edit.html", task: task, changeset: changeset, user_list: user_list, blocks: blocks)
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
