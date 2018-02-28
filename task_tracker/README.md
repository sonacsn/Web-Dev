# TaskTracker

## Design Decisions
### Database Schema:
   * User Table:
        * Contains has_many for managers.
   * Manage Table:
        * Contains foreign key to User table for manager_id and managee_id.
   * Task Table:
        * Contains has_many for time blocks.
   * TimeBlocks Table:
        * Contains start_time, end_time, and a foreign key to task.
   
### Tasks
   * All Tasks page can only be accessed if the user is logged in.
   * **All Staff** contains the report of all the underlings of a manager

### Users
   * **All Users** page displays all the registered user along with their email and an option to delete them.
   * **Only logged in users can see the All Tasks** button, as only they have access to that page.
   * Any user can manage/unmanage any other user using the **Manage/Unmanage** button.
### Time Blocks
   * Show Task page contains the *Start* button that starts the time block. It is implemented using AJAX. It creates a new time block  which can be viewed in the Edit Task Page.
   * Edit Task Page displays a list of all time blocks for that task
   * A user can delete an existing time block.
   * Duration is calculated here.

        

## Run on your system
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).
## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
