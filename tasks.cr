# This file loads your app and all your tasks when running 'lucky'
#
# Run 'lucky --help' to see all available tasks.
#
# Learn to create your own tasks:
# https://luckyframework.org/guides/command-line-tasks/custom-tasks

# See `LuckyEnv#task?`
ENV["LUCKY_TASK"] = "true"

require "./src/breeze"
require "lucky_task"

# You can add your own tasks here in the ./tasks folder
require "./tasks/**"

# Load migrations
require "./db/migrations/**"

LuckyTask::Runner.run
