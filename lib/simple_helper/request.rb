# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'net/https'
require 'json'
require_relative 'string/string_colorize'

module SimpleHelper
  module Https

    class << self
      SimpleHelper::Config.supported_methods.each do |key, http_method|
        define_method key do |uri, params, headers|
          https = Net::HTTP.new(uri.host, uri.port)
          https.use_ssl = true
          https.verify_mode = OpenSSL::SSL::VERIFY_NONE

          req = http_method.new(uri, headers)
          req.body = params.to_json
          https.request(req)
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

  module Http
    class << self
      SimpleHelper::Config.supported_methods.each do |key, http_method|
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
