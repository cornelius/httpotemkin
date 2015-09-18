#!/usr/bin/ruby

require "sinatra"

get '/' do
  "Jups"
end

get "/hello" do
  "world"
end

get "/*" do
  "all the rest"
end
