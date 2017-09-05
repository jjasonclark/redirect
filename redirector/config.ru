require 'bundler/setup'
require 'rack'
require 'net/http'
require 'json'
require 'prometheus/middleware/collector'
require 'prometheus/middleware/exporter'
require_relative 'lib/redirector'

# Fetch redirect data from admin API
# TODO: Add robust error handling
source_url = ENV.fetch('REDIRECT_SOURCE') { Process::abort('Missing datasource') }
response = Net::HTTP.get(URI(source_url))
redirects = JSON.parse(response).map do |json|
  { regex: json['regex'], code: json['code'], result: json['result'] }
end

use Rack::Deflater, if: ->(_, _, _, body) { body.any? && body[0].length > 512 }
use Prometheus::Middleware::Collector, metrics_prefix: 'redirector'
use Prometheus::Middleware::Exporter
use Redirector, redirects: redirects

# All URLs default to 404 not found
run proc { [404, {'Content-Type' => 'text/plain'}, ['Not Found']] }
puts "Redirector started up successfully"
