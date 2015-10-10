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

expected_output = File.read("expected_output")

servers.keys.each do |name|
  run("docker run --name=#{name} -d #{name}")
end
sleep 3

links = servers.map { |name, server| "--link #{name}:#{server}" }.join(" ")
cmd = "docker run #{links} client"
puts cmd

puts "--- Start Test ---"
actual_output = `#{cmd}`
puts actual_output
puts "---- End Test ----"

servers.keys.each do |name|
  run("docker rm -f #{name}")
end

puts
if actual_output == expected_output
  puts "Success."
else
  puts "Failed."
  puts
  puts "Expected output:"
  puts expected_output
  puts
  puts "Actual output:"
  puts actual_output
  exit 1
end
