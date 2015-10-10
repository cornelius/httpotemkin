#!/usr/bin/ruby

def run(cmd)
  puts cmd
  if !system(cmd)
    STDERR.puts "Command failed. Exiting."
    exit 1
  end
end

servers = {
  "rubygems" => "rubygems.org",
  "api.rubygems" => "api.rubygems.org",
  "obs" => "api.opensuse.org"
}

servers.keys.each do |name|
  run("docker run --name=#{name} -d #{name}")
end
sleep 3

links = servers.map { |name, server| "--link #{name}:#{server}" }.join(" ")
run("docker run #{links} client")

servers.keys.each do |name|
  run("docker kill #{name}")
  run("docker rm #{name}")
end

puts "Success."
