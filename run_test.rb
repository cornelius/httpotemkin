#!/usr/bin/ruby

def run(cmd)
  puts cmd
  if !system(cmd)
    STDERR.puts "Command failed. Exiting."
    exit 1
  end
end

run("docker run --name=rubygems -d rubygems")
run("docker run --name=obs -d obs")
sleep 3

run("docker run --link rubygems:api.rubygems.org --link obs:api.opensuse.org client")

run("docker rm -f rubygems")
run("docker rm -f obs")

puts "Success."
