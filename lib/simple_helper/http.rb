# frozen_string_literal: true

require 'uri'
require 'net/http'
require_relative 'const'
require_relative 'string/string_colorize'

module SimpleHelper
  module Http
    class << self
      SimpleHelper::Const.supported_methods.each do |key, http_method|
        define_method key.to_s do |uri, params, headers|
          http = Net::HTTP.new(uri.host, uri.port)
          req = http_method.new(uri, headers)
          req.body = params.to_json
          http.request(req)
        rescue Timeout::Error || Net::OpenTimeout
          puts 'Time out'.bold.red.gray
        rescue Net::HTTPBadResponse || SocketError
          puts 'Request Failed!'.bold.red.gray
        rescue StandardError
          puts 'An unknown error occurred!'.bold.red.gray
        end
      end
    end
  end
end
