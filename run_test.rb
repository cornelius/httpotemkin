#!/usr/bin/ruby

def run(cmd)
  puts cmd
  if !system(cmd)
    STDERR.puts "Command failed. Exiting."
    exit 1
  end
end

run("docker run --name=rubygems -d rubygems")
sleep 3
run("docker run --link rubygems:api.rubygems.org client curl --cacert /certificates/rubygems.crt https://api.rubygems.org -s")
run("docker rm -f rubygems")

puts "Success."
