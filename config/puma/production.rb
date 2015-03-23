environment 'production'

bind 'unix:///var/run/fhspost-prod.sock'

threads 16,32

workers 4

daemonize

pidfile '/var/run/fhspost-prod.pid'

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

preload_app!