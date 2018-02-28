defmodule TaskTracker.Track.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.Track.Task
  alias TaskTracker.Track.TimeBlock

  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :duration, :integer, default: 0
    field :title, :string
    field :started, :boolean, default: false, null: false
    belongs_to :user, TaskTracker.Accounts.User, foreign_key: :assigned_to
    has_many :block, TimeBlock, foreign_key: :task_id
    has_many :blocks, through: [:block, :task]

    timestamps()
  end

  def validate_interval(changeset) do
    field = get_field(changeset, :duration)
    if rem(field, 15) == 0 do
      changeset
    else
      add_error(changeset, :duration, "Duration should be in 15 minute intervals")
    end
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :duration, :completed, :assigned_to])
    |> validate_required([:title, :description, :duration, :completed])
  end
end
