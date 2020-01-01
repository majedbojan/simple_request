# frozen_string_literal: true

require 'uri'
require 'net/http'
require_relative 'const'

module SimpleHelper
  module Http
    # def self.perform(uri, params, headers_processor)
    #   http = Net::HTTP.new(uri.host, uri.port)
    #   req = Net::HTTP::Get.new(uri, headers_processor)
    #   req.body = params.to_json
    #   http.request(req)
    # rescue Timeout::Error || Net::OpenTimeout
    #   puts "\e[31mTime out!\e[0m"
    # rescue Net::HTTPBadResponse || SocketError
    #   puts "\e[31mRequest Failed!\e[0m"
    # rescue StandardError
    #   puts "\e[31mAn unknown error occurred!\e[0m"
    # end

    SimpleHelper::Const.supported_format.each do |key, http_method|
      define_method self.key.to_s do
        http = Net::HTTP.new(uri.host, uri.port)
        req = http_method.new(uri, headers_processor)
        req.body = params.to_json
        http.request(req)
      end
    end
  end
end
