#!/usr/bin/ruby

require "thin"

class SecureServer < ::Thin::Backends::TcpServer
  def initialize(host, port, options)
    super(host, port)
    @ssl = true
    @ssl_options = options
  end
end

def configure_sinatra
  configure do
    set :environment, :production
    set :bind, '0.0.0.0'
    set :port, 443
    set :server, "thin"
    class << settings
      def server_settings
        {
          :backend          => SecureServer,
          :private_key_file => CERT_DIR + "/server.key",
          :cert_chain_file  => CERT_DIR + "/server.crt",
          :verify_peer      => false
        }
      end
    end
  end
end
