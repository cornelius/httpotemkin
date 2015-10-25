require "cli_tester"

ENV["RUN_BY_RSPEC"] = "1"

def with_stubbed_binary(bin_path)
  saved_path = ENV["PATH"]

  full_path = File.expand_path("../", __FILE__)
  full_path = File.join(full_path, bin_path)
  if !File.exist?(full_path)
    STDERR.puts "Error: stubbing binary #{full_path} does not exist"
  else
    path = File.dirname(full_path)
    ENV["PATH"] = path + ":" + ENV["PATH"]
  end

  yield

  ENV["PATH"] = saved_path
end
