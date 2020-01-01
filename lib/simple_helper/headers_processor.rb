# frozen_string_literal: true

module SimpleHelper
  module HeadersProcessor
    attr_reader :headers

    def self.perform(headers)
      return {} unless headers.nil? || !headers.respond_to?(:to_hash)

      @headers = SimpleHelper::Utils.stringify_keys(headers)

      headers_processor
    end

    def headers_processor
      return headers unless content_type_passed?

      { 'Content-Type' => 'application/json' }.merge(headers)
    end

    def content_type_passed?
      headers['Content-Type'].nil?
    end
  end
end
