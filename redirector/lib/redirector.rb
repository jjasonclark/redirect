require 'rack'
require_relative './redirected_url'

class Redirector
  def initialize(app, opts={})
    options = opts || {}
    @redirects = options[:redirects].map { |opts| RedirectedUrl.new(opts) }
    @app = app
  end

  def call(env)
    puts "Redirector call"
    req = Rack::Request.new(env)
    redirect_result = find_url(req.url)
    if redirect_result.nil?
      @app.call env
    else
      message = "Redirecting #{req.url} to #{redirect_result.result_url}"
      puts message
      [redirect_result.code, { "Location" => redirect_result.result_url }, [message]]
    end
  end

  def find_url(url)
    @redirects.detect { |redirect| redirect.match?(url) }
  end
end
