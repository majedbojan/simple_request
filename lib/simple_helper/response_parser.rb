# frozen_string_literal: true

require 'pry'

module SimpleHelper
  class ResponseParser
    attr_reader :body, :format

    def initialize(body, format)
      @body = body
      @format = format
    end

    def self.perform(body, format)
      new(body, format).parse
    end

    def parse
      return nil if body.nil?
      return nil if body == 'null'
      return nil if body.valid_encoding? && body.strip.empty?

      @body = body.gsub(/\A#{UTF8_BOM}/, '') if body.valid_encoding? && body.encoding == Encoding::UTF_8
      send(format)
    end

    protected

    # TODO: Support other formats like xml, csv

    UTF8_BOM = "\xEF\xBB\xBF"

    def json
      JSON.parse(body, quirks_mode: true, allow_nan: true)
    rescue JSON::ParserError
      puts "Response cannot be parsed because it's not a string not valid JSON. please use .plain to get the the plain response"
    end

    def plain
      body
    end

    # def csv
    #   CSV.parse(body)
    # end
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
