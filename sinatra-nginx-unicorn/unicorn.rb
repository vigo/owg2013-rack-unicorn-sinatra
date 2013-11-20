@dir = "/home/vagrant/owg2013-rack-unicorn-sinatra/sinatra-nginx-unicorn/tmp/"
worker_processes 2
working_directory @dir
timeout 30

listen "#{@dir}sockets/unicorn.sock", :backlog => 64

pid_file = "#{@dir}pids/unicorn.pid"
old_pid = "#{pid_file}.oldbin"

pid pid_file

stderr_path "#{@dir}log/unicorn.stderr.log"
stdout_path "#{@dir}log/unicorn.stdout.log"

preload_app true

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = File.expand_path('../Gemfile', File.dirname(__FILE__))
end

before_fork do |server, worker|
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # pass
    end
  end
end