module ModifyFiles
  private def insert_text(*, in filename : String, content : String, before : String? = nil)
    file = File.read(filename)

    updated_file = if before
                     location = file.rindex(before)

                     if location
                       file.insert(location - 1, "\n" + content + "\n")
                     else
                       raise "Unable to find #{before} in #{filename}"
                     end
                   else
                     file + "\n" + content + "\n"
                   end

    File.write(filename, updated_file)
  end
end
