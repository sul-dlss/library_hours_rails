Rails.configuration.middleware.use(IsItWorking::Handler) do |h|
  # Check the ActiveRecord database connection without spawning a new thread
  h.check :active_record, async: false

  h.check :directory, path: File.join(Rails.root, 'tmp', 'uploads'), permission: [:read, :write]
end
