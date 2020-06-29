# frozen_string_literal: true

require_relative 'array/wrap'
require_relative 'array/to_csv'
require_relative 'string/string_colorize'

module SimpleHelper
  class ResponseParser
    attr_reader :body, :format, :path

    def initialize(body, format, path)
      @body = body
      @format = format
      @path = path
    end

    def self.perform(body, format, path)
      new(body, format, path).parse
    end

    def parse
      return nil if body.nil?
      return nil if body == 'null'
      return nil if body.valid_encoding? && body.strip.empty?

      @body = body.gsub(/\A#{UTF8_BOM}/, '') if body.valid_encoding? && body.encoding == Encoding::UTF_8
      send(format)
    end

    protected

    # TODO: Support other formats like xml

    UTF8_BOM = "\xEF\xBB\xBF"

    def json
      JSON.parse(body, quirks_mode: true, allow_nan: true)
    rescue JSON::ParserError
      puts "Response cannot be parsed because it's not a string nor valid JSON. please use .plain to get the the plain response".bold.brown.gray
    end

    def plain
      body
    end

    def csv
      data = path.nil? ? json : json.dig(*path.split(','))
      raise ArgumentError, 'Cannot export nil or empty hash please pass proper path'.bold.brown.gray if data.nil?

      Array.wrap(data).to_csv('file_name.csv')
    end

    # def xml
    #   MultiXml.parse(body)
    # end

    # def parse_supported_format
    #   send(format)
    # rescue NoMethodError => e
    #   raise NotImplementedError, "#{self.class.name} has not implemented a parsing method for the #{format.inspect} format.", e.backtrace
    # end
  end
end
