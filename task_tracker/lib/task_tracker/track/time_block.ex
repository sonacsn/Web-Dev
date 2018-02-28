defmodule TaskTracker.Track.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.Track.TimeBlock


  schema "timeblocks" do
    field :end_time, :time
    field :start, :time
    field :started, :boolean, default: false, null: false
    belongs_to :task, TaskTracker.Track.Task

    timestamps()
  end

  @doc false
  def changeset(%TimeBlock{} = time_block, attrs) do
    time_block
    |> cast(attrs, [:start, :end_time, :task_id, :started])
    |> validate_required([ :started, :task_id])
  end
end
