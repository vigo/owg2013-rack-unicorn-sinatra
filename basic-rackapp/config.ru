require 'rack'

class MyApplication
  def call(env)
    h = {"Content-Type" => "text/html; charset=utf-8"}
    [200, h, ["Merhaba Dünya"]]
  end
end

run MyApplication.new