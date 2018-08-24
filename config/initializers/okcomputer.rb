OkComputer.mount_at = false
OkComputer::Registry.register "directory", OkComputer::DirectoryCheck.new(File.join(Rails.root, 'tmp', 'uploads'))
