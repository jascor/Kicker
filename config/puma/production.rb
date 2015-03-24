environment 'production'

bind 'unix:///tmp/fhspost-prod.sock'

threads 8,32

workers 2

daemonize

pidfile '/tmp/fhspost-prod.pid'

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

preload_app!