#!/usr/bin/ruby

def run(cmd)
  puts cmd
  if !system(cmd)
    STDERR.puts "Command failed. Exiting."
    exit 1
  end
end

run("docker run --name=rubygems -d rubygems")
run("docker run --name=api.rubygems -d api.rubygems")
run("docker run --name=obs -d obs")
sleep 3

run("docker run --link rubygems:rubygems.org --link api.rubygems:api.rubygems.org --link obs:api.opensuse.org client")

run("docker kill rubygems")
run("docker kill api.rubygems")
run("docker kill obs")

run("docker rm rubygems")
run("docker rm api.rubygems")
run("docker rm obs")

puts "Success."
