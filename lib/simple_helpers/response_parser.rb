# frozen_string_literal: true

module SimpleRequest
  class ResponseParser
    attr_reader :body, :format

    def self.call(body, format)
      new(body, format).parse
    end

    def parse
      return nil if body.nil?
      return nil if body == 'null'
      return nil if body.valid_encoding? && body.strip.empty?

      @body = body.gsub(/\A#{UTF8_BOM}/, '') if body.valid_encoding? && body.encoding == Encoding::UTF_8
      if supports_format?
        parse_supported_format
      else
        body
      end
    end

    protected

    def xml
      MultiXml.parse(body)
    end

    UTF8_BOM = "\xEF\xBB\xBF"

    def json
      JSON.parse(body, quirks_mode: true, allow_nan: true)
    end

    def csv
      CSV.parse(body)
    end

    def html
      body
    end

    def plain
      body
    end

    def supports_format?
      self.class.supports_format?(format)
    end

    def parse_supported_format
      send(format)
    rescue NoMethodError => e
      raise NotImplementedError, "#{self.class.name} has not implemented a parsing method for the #{format.inspect} format.", e.backtrace
      end
    end
  end
