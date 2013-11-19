# encoding: utf-8
require 'sinatra/base'

class MyApplication < Sinatra::Base
  get '/' do
    "Merhaba Dünya!"
  end
end