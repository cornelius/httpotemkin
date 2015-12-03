#!/usr/bin/ruby

require "sinatra"

require_relative "../server/server_base.rb"

CERT_DIR = File.dirname(__FILE__)

configure_sinatra

get '/' do
  "I'm the secure api.rubygems server\n"
end

get '/latest_specs.4.8.gz' do
  File.read(File.expand_path("../latest_specs.4.8.gz", __FILE__))
end

get '/quick/Marshal.4.8/rubygems-update-2.5.0.gemspec.rz' do
  File.read(File.expand_path("../rubygems-update-2.5.0.gemspec.rz", __FILE__))
end
