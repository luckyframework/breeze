require "spec"

# TODO: running `crystal spec` throws this error
# In lib/avram/src/avram/database.cr:138:70
#  138 | @@db || Avram::Connection.new(url, database_class: self.class).open
#                                                                       ^---
# Error: BUG: no target defs

# require "../src/breeze"
