module WithProjectCleanup
  private def with_project_cleanup(project_directory = "test-project", skip_db_drop = false, &)
    FileUtils.mkdir_p("tmp")
    FileUtils.cd("tmp")

    yield

    FileUtils.cd(project_directory) {
      output = IO::Memory.new
      result = Process.run(
        "lucky db.drop",
        output: output,
        shell: true
      )

      result.normal_exit?.should eq(true)
      output.to_s.should contain("Done dropping")
    } unless skip_db_drop
  ensure
    FileUtils.rm_rf project_directory
  end
end
