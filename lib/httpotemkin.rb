module Httpotemkin
  class Containers
    def initialize
      @servers = []
      @host_names = {
        "rubygems" => "rubygems.org",
        "api.rubygems" => "api.rubygems.org",
        "obs" => "api.opensuse.org"
      }
    end

    def run_docker(args)
      cmd = "docker #{args}"
      puts cmd
      if !system(cmd)
        STDERR.puts "Command failed. Exiting."
        exit 1
      end
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
        puts "  #{server}: #{running.include?(server) ? "up" : "down"}"
      end
    end

    def up
      @servers.each do |server|
        run_docker("run --name=#{server} -d #{server}")
      end
    end

    def down(save_logs: false)
      @servers.each do |server|
        if (save_logs)
          run_docker("logs #{server} 2>logs/#{server}.log")
        end
        run_docker("rm -f #{server}")
      end
    end

    def run_client
      links = @servers.map { |name| "--link #{name}:#{host_name(name)}" }.join(" ")
      cmd = "docker run #{links} client"
      puts cmd
      `#{cmd}`
    end
  end

  class Test
    def initialize
      @containers = Containers.new
    end

    def add_server(name)
      @containers.add_server(name)
    end

    def run
      @containers.up
      yield Client.new
      @containers.down
    end
  end

  class Client
    def execute(cmd)
    end

    def exit_code
      0
    end

    def out
      "world"
    end

    def err
      ""
    end
  end
end
