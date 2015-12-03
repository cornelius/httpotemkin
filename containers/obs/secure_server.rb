#!/usr/bin/ruby

require "sinatra"

require_relative "../server/server_base.rb"

CERT_DIR = File.dirname(__FILE__)

configure_sinatra

get '/' do
  "I'm the secure OBS server\n"
end
