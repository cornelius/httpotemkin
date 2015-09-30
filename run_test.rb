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

run("docker run --link rubygems:api.rubygems.org client curl --cacert /certificates/rubygems.crt https://api.rubygems.org -s")
run("docker run --link obs:api.opensuse.org client curl --cacert /certificates/obs.crt https://api.opensuse.org -s")

run("docker rm -f rubygems")
run("docker rm -f obs")

puts "Success."
