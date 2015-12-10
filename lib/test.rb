module Httpotemkin
  class Test
    def initialize(out: $stdout)
      @containers = Containers.new
      @containers.out = out
    end

    def add_server(name)
      @containers.add_server(name)
    end

    def run
      @containers.up
      @containers.start_client
      begin
        yield Client.new(@containers)
      ensure
        @containers.stop_client
        @containers.down
      end
    end

    def up
      @containers.up
    end

    def down
      @containers.down
    end

    def start_client
      @containers.start_client
      Client.new(@containers)
    end

    def stop_client
      @containers.stop_client
    end
  end
end
