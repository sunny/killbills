if defined?(Rack::MiniProfiler)
  # ActiveAdmin incompatibility
  # http://stackoverflow.com/q/11759977/311657
  Rack::MiniProfiler.config.skip_paths << '/en/admin'
  Rack::MiniProfiler.config.skip_paths << '/fr/admin'

  # Might as well
  Rack::MiniProfiler.config.use_existing_jquery = true
end
