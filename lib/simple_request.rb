# frozen_string_literal: true

require_relative 'simple_helper/hash/keys'
%w[config request version exceptions response_parser headers_processor].each do |file_name|
  require_relative "simple_helper/#{file_name}"
end

class SimpleRequest
  attr_reader :options, :response

  def initialize(**options)
    @options = options.symbolize_keys!
    validate
  end

  # This define method should create ["get", "post", "patch", "put", "delete"] class methods
  class << self
    SimpleHelper::Config.supported_methods.keys.each do |method_name|
      define_method method_name do |*args|
        new(*args).send(method_name)
      end
    end
  end

  # This define method should create ["get", "post", "patch", "put", "delete"] instance methods
  SimpleHelper::Config.supported_methods.keys.each do |method_name|
    define_method method_name do
      @response = requested_class.send(method_name, uri, body, headers_processor)
      self
    end
  end

  # This define method should create ["scheme", "host", "port", "request_uri", "path", "query"] instance methods
  SimpleHelper::Config.reference.each do |key|
    define_method key do
      uri.instance_eval(key)
    end
  end

  SimpleHelper::Config.supported_format.each do |key|
    define_method key do
      SimpleHelper::ResponseParser.perform(body_response, key, nil)
    end
  end

  def csv(path = nil)
    SimpleHelper::ResponseParser.perform(body_response, 'csv', path)
  end

  def code
    response&.code
  end

  private

  def requested_class
    Object.const_get("SimpleHelper::#{scheme.capitalize}")
  end

  def body
    options[:body]
  end

  def body_response
    response&.body
  end

  def headers_processor
    SimpleHelper::HeadersProcessor.perform(headers)
  end

  def http_method
    # "#{Net::HTTP::}"
  end

  def headers
    options[:headers] || {}
  end

  def uri
    URI(options[:url])
  end

  def validate
    # raise SimpleHelper::RedirectionTooDeep.new(last_response), 'HTTP redirects too deep' if options[:limit].to_i <= 0

    # unless SimpleHelper::Config.supported_methods.include?(http_method)
    #   raise ArgumentError, 'only get, post, patch, put, and delete methods are supported'
    # end

    raise ArgumentError, ':headers must be a hash' unless headers.respond_to?(:to_hash)

    unless SimpleHelper::Config.supported_schemes.include? scheme
      raise SimpleHelper::UnsupportedURIScheme, ' URL Must start with http:// or https://'
    end

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
end
