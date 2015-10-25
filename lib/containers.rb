module Httpotemkin
  class Containers
    attr_accessor :out
    attr_accessor :log_dir

    def initialize
      @servers = []
      @host_names = {
        "rubygems" => "rubygems.org",
        "api.rubygems" => "api.rubygems.org",
        "obs" => "api.opensuse.org",
        "server" => "server"
      }
      @out = $stdout
      @err = $stderr
      @log_dir = ENV["HTTPOTEMKIN_LOGS_DIR"] || "logs"
    end

    def run_docker(args, options = {})
      cmd = ["docker"] + args
      @out.puts cmd.join(" ")
      out = Cheetah.run(cmd, options.merge({stdout: :capture}))
      @out.puts out if out && !out.empty?
    end

    def host_name(name)
      @host_names[name]
    end

    def add_server(name)
      @servers.push(name)
    end

    def print_status
      running = `docker ps --format="{{.Names}}"`.split("\n")
      @servers.each do |server|
        @out.puts "  #{server}: #{running.include?(server) ? "up" : "down"}"
      end
    end

    def up
      @servers.each do |server|
        run_docker(["run", "--name=#{server}", "-d", server])
      end
    end

    def down(save_logs: false)
      @servers.each do |server|
        if (save_logs)
          log_file = File.open(File.join(@log_dir,"#{server}.log"), "w")
          run_docker(["logs", server], stderr: log_file)
        end
        run_docker(["rm", "-f", server])
      end
    end

    def start_client
      run_docker(["run", links, "--name=client", "-d", "client"])
    end

    def stop_client
      run_docker(["rm", "-f", "client"])
    end

    def exec_client(client_cmd)
      cmd = ["docker", "exec", "client"] + client_cmd
      @out.puts cmd.join(" ")
      Cheetah.run(cmd, stdout: :capture)
    end

    def links
      @servers.map { |name| "--link=#{name}:#{host_name(name)}" }.join(" ")
    end

    def run_client
      cmd = "docker run #{links} client"
      @out.puts cmd
      `#{cmd}`
    end
  end
end