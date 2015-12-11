#!/usr/bin/ruby

require "sinatra"

require_relative "../server/server_base.rb"

CERT_DIR = File.dirname(__FILE__)

configure_sinatra

get '/' do
  "I'm the secure OBS server\n"
end

get '/source/home:cschum:go/red_herring' do
  "xx"
end

put '/source/home:cschum:go/red_herring/red_herring-0.0.2.tar.gz' do
  "xx"
end
