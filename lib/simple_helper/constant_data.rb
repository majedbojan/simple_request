# frozen_string_literal: true

module SimpleHelper
  class ConstantData
    SupportedHTTPMethods = {
      'get'    => Net::HTTP::Get,
      'post'   => Net::HTTP::Post,
      'patch'  => Net::HTTP::Patch,
      'put'    => Net::HTTP::Put,
      'delete' => Net::HTTP::Delete
    }.freeze

    REFERENCES          = %w[scheme host port request_uri path query].freeze
    SUPPORTED_FORMAT    = %w[xml json csv plain].freeze
    SupportedURISchemes = ['http', 'https'].freeze
  end
end




