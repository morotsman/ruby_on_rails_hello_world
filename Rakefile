# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks


def server_ready? _url
  begin
    url = URI.parse(_url)
    req = Net::HTTP.new(url.host, url.port)
    res = req.request_head(url.path)
    res.code == "200" || res.code == "500"
  rescue Errno::ECONNREFUSED
    false
  end
end

def get_pid port
  output = `netstat -a -o -n`
  lines = output.lines.grep(/127.0.0.1:#{port} /)
  lines.each { |line| 
	puts line
  }
  lines.first.split[4]
end

task :start_server do
  puts "Starting server"

  system("rake db:migrate")
  Thread.new { system("rails server") }
  
  until server_ready?("http://localhost:3000/") do
    sleep 1
  end
  
  puts "Server started"
end

task :execute_selenium do
  puts "Running selenium"
  result = system("rspec selenium_test.rb")
  puts "Result from selenium"  + result.to_s
  puts $?
  puts $?.exitstatus
end

task :stop_server do
  pid = get_pid "3000"
  puts pid
  system("taskkill /PID #{pid} -f")
end


task :run_selenium => [:start_server, :execute_selenium, :stop_server] do

end
