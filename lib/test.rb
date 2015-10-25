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
  end
end
