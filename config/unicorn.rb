root = File.expand_path(File.dirname(File.dirname(__FILE__)))
working_directory root

pid "#{root}/tmp/pids/unicorn.pid"

stderr_path "#{root}/log/unicorn.err"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.sock"
worker_processes 2
timeout 30
