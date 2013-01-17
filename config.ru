# config.ru
require 'rubygems'
require 'bundler'

Bundler.require

require './app.rb'
run Sinatra::Application