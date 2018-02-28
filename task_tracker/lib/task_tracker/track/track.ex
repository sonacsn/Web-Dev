defmodule TaskTracker.Track do
  @moduledoc """
  The Track context.
  """

  import Ecto.Query, warn: false
  alias TaskTracker.Repo

  alias TaskTracker.Track.Task

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id) do
    Repo.get!(Task, id)
   |> Repo.preload(:user)
  end
 
  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{source: %Task{}}

  """
  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end

  alias TaskTracker.Track.Manage

  @doc """
  Returns the list of manages.

  ## Examples

      iex> list_manages()
      [%Manage{}, ...]

  """
  def list_manages do
    Repo.all(Manage)
  end

  @doc """
  Gets a single manage.

  Raises `Ecto.NoResultsError` if the Manage does not exist.

  ## Examples

      iex> get_manage!(123)
      %Manage{}

      iex> get_manage!(456)
      ** (Ecto.NoResultsError)

  """
  def get_manage!(id), do: Repo.get!(Manage, id)

  @doc """
  Creates a manage.

  ## Examples

      iex> create_manage(%{field: value})
      {:ok, %Manage{}}

      iex> create_manage(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_manage(attrs \\ %{}) do
    %Manage{}
    |> Manage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a manage.

  ## Examples

      iex> update_manage(manage, %{field: new_value})
      {:ok, %Manage{}}

      iex> update_manage(manage, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_manage(%Manage{} = manage, attrs) do
    manage
    |> Manage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Manage.

  ## Examples

      iex> delete_manage(manage)
      {:ok, %Manage{}}

      iex> delete_manage(manage)
      {:error, %Ecto.Changeset{}}

  """
  def delete_manage(%Manage{} = manage) do
    Repo.delete(manage)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking manage changes.

  ## Examples

      iex> change_manage(manage)
      %Ecto.Changeset{source: %Manage{}}

  """
  def change_manage(%Manage{} = manage) do
    Manage.changeset(manage, %{})
  end
  
  def manages_map_for(user_id) do
    Repo.all(from m in Manage,
      where: m.manager_id == ^user_id)
    |> Enum.map(&({&1.managee_id, &1.id}))
    |> Enum.into(%{})
  end
  def feed_tasks_for(user) do
    user = Repo.preload(user, :managees)
    managed_ids = Enum.map(user.managees, &(&1.id))
    Repo.all(Task)
    |> Enum.filter(&(Enum.member?(managed_ids, &1.assigned_to)))
    |> Repo.preload(:user)
  end

  def get_managee(managees) do
    query = from(u in TaskTracker.Accounts.User, select: {u.name, u.id}, where: u.id in ^managees)
    Repo.all(query)
  end

  def managed_by(user_id) do
    Repo.all(from u in TaskTracker.Accounts.User,join: m in Manage, select: u.name, where: u.id == m.manager_id and m.managee_id == ^user_id)
  end
 
  def get_underlings(user_id) do
    direct_map = manages_map_for(user_id)
    direct = Map.keys(direct_map)
    get_managees_tasks(some(direct, []))
  end
  
  def some(direct, underlings) do
    if direct == [] || direct == nil do 
	underlings
    else
  	IO.inspect underlings
    	[l | tail] = direct
        new = Repo.all(from m in TaskTracker.Track.Manage, select: m.managee_id, where: m.manager_id == ^l)
        newp = new ++ [l]
    	some(tail ++ new, underlings ++ newp)
    end
  end
  
  def get_managees_tasks(underlings) do
    Repo.all(Task)
    |> Enum.filter(&(Enum.member?(underlings, &1.assigned_to)))
    |> Repo.preload(:user)
  end

  alias TaskTracker.Track.TimeBlock

  def get_blocks(task_id) do
    Repo.all(from b in TimeBlock, where: b.task_id == ^task_id and b.started == false)
    |> Enum.map(&({&1.id, &1}))
    |> Enum.into(%{})
    # [%TimeBlock{}, ...]
  end

  def get_any_started_block(task) do
    task = Repo.preload(task, :blocks)
    block_ids = Enum.map(task.blocks, &(&1.id))
    Repo.all(TimeBlock)
    |> Enum.filter(&(Enum.member?(block_ids, &1.task_id)))
    |> Enum.filter(fn(x) -> x.started end)
    |> Repo.preload(:task)
  end

  def calculate_duration(task) do
    blocks = Repo.all(from b in TimeBlock, where: b.task_id == ^task.id and b.started == false)
    block_duration = Enum.map(blocks, &(Integer.floor_div(Time.diff(&1.end_time, &1.start),60)))
    Enum.reduce(block_duration, fn(x, acc) -> x + acc end)
  end
  @doc """
  Returns the list of timeblocks.

  ## Examples

      iex> list_timeblocks()
      [%TimeBlock{}, ...]

  """
  def list_timeblocks do
    Repo.all(TimeBlock)
  end

  @doc """
  Gets a single time_block.

  Raises `Ecto.NoResultsError` if the Time block does not exist.

  ## Examples

      iex> get_time_block!(123)
      %TimeBlock{}

      iex> get_time_block!(456)
      ** (Ecto.NoResultsError)

  """
  def get_time_block!(id), do: Repo.get!(TimeBlock, id)

  @doc """
  Creates a time_block.

  ## Examples

      iex> create_time_block(%{field: value})
      {:ok, %TimeBlock{}}

      iex> create_time_block(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_time_block(attrs \\ %{}) do
    IO.inspect attrs
    %TimeBlock{}
    |> TimeBlock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a time_block.

  ## Examples

      iex> update_time_block(time_block, %{field: new_value})
      {:ok, %TimeBlock{}}

      iex> update_time_block(time_block, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_time_block(%TimeBlock{} = time_block, attrs) do
    time_block
    |> TimeBlock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TimeBlock.

  ## Examples

      iex> delete_time_block(time_block)
      {:ok, %TimeBlock{}}

      iex> delete_time_block(time_block)
      {:error, %Ecto.Changeset{}}

  """
  def delete_time_block(%TimeBlock{} = time_block) do
    Repo.delete(time_block)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking time_block changes.

  ## Examples

      iex> change_time_block(time_block)
      %Ecto.Changeset{source: %TimeBlock{}}

  """
  def change_time_block(%TimeBlock{} = time_block) do
    TimeBlock.changeset(time_block, %{})
  end
end
