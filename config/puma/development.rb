environment 'development'

bind 'tcp://0.0.0.0:3000'

threads 8,32

workers 4

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

preload_app!