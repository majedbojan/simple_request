# frozen_string_literal: true

require 'uri'
require 'net/https'
module SimpleHelper
  module Https
    class << self
      SimpleHelper::Const.supported_methods.each do |key, http_method|
        define_method key.to_s do |uri, params, headers|
          https = Net::HTTP.new(uri.host, uri.port)
          https.use_ssl = true
          https.verify_mode = OpenSSL::SSL::VERIFY_NONE

          req = http_method.new(uri, headers)
          req.body = params.to_json
          http.request(req)
        rescue Timeout::Error || Net::OpenTimeout
          puts "\e[31mTime out!\e[0m"
        rescue Net::HTTPBadResponse || SocketError
          puts "\e[31mRequest Failed!\e[0m"
        rescue StandardError
          puts "\e[31mAn unknown error occurred!\e[0m"
        end
      end
    end
  end
end
