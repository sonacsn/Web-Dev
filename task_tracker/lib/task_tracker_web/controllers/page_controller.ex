defmodule TaskTrackerWeb.PageController do
  use TaskTrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
  def feed(conn, _params) do
    #tasks = TaskTracker.Track.list_tasks()
    tasks = Enum.reverse(TaskTracker.Track.get_underlings(conn.assigns[:current_user].id))
    changeset = TaskTracker.Track.change_task(%TaskTracker.Track.Task{})
    render conn, "feed.html", tasks: tasks, changeset: changeset
  end
end
