require "./spec_helper"

include ShouldRunSuccessfully
include WithProjectCleanup
include ModifyFiles

describe "Initializing a new web project with Breeze" do
  it "runs a full integration" do
    puts "Breeze Specs: Running integration spec. This might take awhile...".colorize(:yellow)
    with_project_cleanup do
      should_run_successfully "lucky init.custom test-project"

      setup_and_compile_project_with_breeze
      ensure_project_specs_run
    end
  end
end

private def setup_and_compile_project_with_breeze
  FileUtils.cd "test-project" do
    insert_text in: "shard.yml", content: <<-TEXT
      breeze:
        path: #{ENV["BREEZE_TEST_LOCATION"]}
    TEXT

    insert_text in: "src/shards.cr", content: <<-TEXT
    require "breeze"
    TEXT

    insert_text in: "tasks.cr", before: "LuckyTask::Runner.run", content: <<-TEXT
    require "breeze/tasks"
    TEXT

    insert_text in: "spec/spec_helper.cr", before: %(require "./setup/**"), content: <<-TEXT
    require "breeze/spec_helpers"
    TEXT

    should_run_successfully "script/setup"
    should_run_successfully "lucky breeze.install"
    File.read("config/breeze.cr").should contain("Breeze.configure")
  end
end

private def ensure_project_specs_run
  FileUtils.cd "test-project" do
    should_run_successfully "crystal spec"
  end
end
