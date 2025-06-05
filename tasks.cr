# Require this file from your project's `tasks.cr` file:
# ```
# # ...
# require "breeze/tasks"
#
# LuckyCli::Runner.run
# ```

require "lucky_task"
require "avram"

# Require all of the built-in Breeze tasks
require "./tasks/**"

# Require the DB Migrations.
# This allows you to run `lucky db.migrate` from your
# project, without having to require anything extra
require "./db/migrations/**"
