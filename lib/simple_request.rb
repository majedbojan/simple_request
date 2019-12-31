# frozen_string_literal: true

require 'uri'
require 'json'
require 'net/http'
require 'net/https'

require 'helpers/const'
require 'helpers/exceptions'
require 'helpers/response_parser'
# require 'simple_request/https'
# require 'simple_request/version'

class SimpleRequest
  # Exceptions raised by SimpleRequest inherit from Error
  # Your code goes here...
  attr_reader :options

  def initialize(**options)
    @options = options.symbolize_keys!
    validate
    # @uri     = URI(options[:url])
    # @body = options[:body]
    # @headers = options[:headers] || {}
    # @options = options[:body]
  end

  def self.get(*args)
    new(*args).get
  end

  def get
    # open_ssl
    # debugger
    # https = Net::HTTP.new(uri.host, uri.port)
    # https.use_ssl = true
    # https.verify_mode = OpenSSL::SSL::VERIFY_NONE
    req = Net::HTTP::Get.new(uri, headers_processor)
    req.body = body.to_json
    https.request(req)
  end

  def data; end

  SimpleRequest::Const.reference.each do |key|
    define_method key.to_s do
      uri.instance_eval(key)
    end
  end

  private

  def body
    options[:body]
  end

  def headers
    options[:headers] || {}
  end

  def headers_processor
    return headers unless content_type_passed?

    { 'Content-Type' => 'application/json' }.merge(headers)
  end

  def content_type_passed?
    headers['Content-Type'].present?
  end

  def validate
    # raise HTTParty::RedirectionTooDeep.new(last_response), 'HTTP redirects too deep' if options[:limit].to_i <= 0

    # unless SimpleRequest::Const.supported_methods.include?(http_method)
    #   raise ArgumentError, 'only get, post, patch, put, and delete methods are supported'
    # end

    raise ArgumentError, ':headers must be a hash' if headers && !headers.respond_to?(:to_hash)

    raise ArgumentError, ':headers must be a hash' if headers && !headers.respond_to?(:to_hash)

    unless SimpleRequest::Const.supported_schemes.include? scheme
      raise UnsupportedURIScheme, "'#{scheme}' Must be HTTP or HTTPS"
    end
    # if options[:basic_auth] && options[:digest_auth]
    #   raise ArgumentError, 'only one authentication method, :basic_auth or :digest_auth may be used at a time'
    # end

      # if options[:basic_auth] && !options[:basic_auth].respond_to?(:to_hash)
      # raise ArgumentError, ':basic_auth must be a hash'
      # end

      # if options[:digest_auth] && !options[:digest_auth].respond_to?(:to_hash)
      # raise ArgumentError, ':digest_auth must be a hash'
      # end

    # if post? && !options[:query].nil? && !options[:query].respond_to?(:to_hash)
    #   raise ArgumentError, ':query must be hash if using HTTP Post'
    #   end
  end

  def open_ssl
    return if has_no_ssl?

    @https = Net::HTTP.new(uri.host, uri.port)
    @https.use_ssl = true
    @https.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end

  def has_no_ssl?; end

  def http_method
    # "#{Net::HTTP::}"
  end

  def parser
    options[:parser] || 'json'
  end

  def uri
    URI(options[:url])
  end

  def response_processor; end

  # def parse_response(req)
  #   https.request(req)
  # rescue Timeout::Error || Net::OpenTimeout
  #   puts "\e[31mTime out!\e[0m"
  # rescue Net::HTTPBadResponse || SocketError
  #   puts "\e[31mRequest Failed!\e[0m"
  # rescue StandardError
  #   puts "\e[31mAn unknown error occurred!\e[0m"
  # end
end
require 'simple_request/exceptions'
