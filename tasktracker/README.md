# TaskTracker

## Design Decisions
### Database Schema:
   * User Table:
        * Created a unique index for **email** field as users cannot have duplicate emails.
        * Both **email** and **name** are set to not null.
   * Task Table:
        * **assigned_to** references to the user_id.
        * All fields except **assigned_to** are set to not null.
        * **assigned_to** can be null, as the task should exist even if user is deleted.
        * Deleting a user will not delete the task, as that task can later be assigned to someone else.

### Log in page
   * User needs to be registered to log in.
   * If log in is successful, it redicts to All Tasks page.
   * Register link, redirects to New User page.
   
### Tasks
   * **All Tasks** page displays all the task titles, their status, their owner (if any) and option to delete them.
   * All Tasks page can only be accessed if the user is logged in.
   * Clicking on the task title loads a new page displaying other information like description and duration and an option to edit the task. 
   * Clicking on the name of the assignee, loads a new page displaying the profile info of the user.
   * New Task can be created where all the fields are required and duration should be in increments of 15.

### Users
   * **All Users** page displays all the registered user along with their email and an option to delete them.
   * **Only logged in users can see the All Tasks** button, as only they have access to that page.
   * Clicking on their email redirects to their profile page where you can edit the user information.

        

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
