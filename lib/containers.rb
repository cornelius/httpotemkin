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
      table = Terminal::Table.new(headings: ["Container", "Status"]) do |t|
        status.each do |container, status|
          t.add_row([container, status ? "up" : "down"])
        end
      end

      @out.puts table
    end

    def status
      @status ||= {}
      if @status.empty?
        running = `docker ps --format="{{.Names}}"`.split("\n")
        @servers.each do |server|
          @status[server] = running.include?(server)
        end
      end
      @status
    end

    def up
      @servers.each do |server|
        if status[server]
          @out.puts "'#{server}' already up"
        else
          run_docker(["run", "--name=#{server}", "-d", server])
        end
      end
    end

    def down(save_logs: false)
      @servers.each do |server|
        if (save_logs)
          log_file = File.open(File.join(@log_dir,"#{server}.log"), "w")
          run_docker(["logs", server], stderr: log_file)
        end
        if status[server]
          run_docker(["rm", "-f", server])
        else
          @out.puts "'#{server}' already down"
        end
      end
    end

    def start_client
      if links.empty?
        run_docker(["run", "--name=client", "-d", "client", "sleep", "infinity"])
      else
        run_docker(["run"] + links + ["--name=client", "-d", "client", "sleep", "infinity"])
      end
    end

    def stop_client
      run_docker(["rm", "-f", "client"])
    end

    def exec_client(client_cmd, working_directory: nil)
      cmd = ["docker", "exec", "client"]
      if working_directory
        cmd += ["sh", "-c", "cd #{working_directory}; #{client_cmd.join(' ')}"]
      else
        cmd += client_cmd
      end
      @out.puts cmd.join(" ")
      begin
        out, err = Cheetah.run(cmd, stdout: :capture, stderr: :capture)
        exit_code = 0
      rescue Cheetah::ExecutionFailed => e
        out = e.stdout
        err = e.stderr
        exit_code = e.status.exitstatus
      end
      return out, err, exit_code
    end

    def links
      @servers.map { |name| "--link=#{name}:#{host_name(name)}" }
    end

    def run_client
      cmd = "docker run #{links.join(" ")} client"
      @out.puts cmd
      `#{cmd}`
    end
  end
end
