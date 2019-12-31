# frozen_string_literal: true

module SimpleRequest
  class ConstantData
    SupportedHTTPMethods = [
      Net::HTTP::Get,
      Net::HTTP::Post,
      Net::HTTP::Patch,
      Net::HTTP::Put,
      Net::HTTP::Delete
    ].freeze

    SupportedURISchemes = ['http', 'https'].freeze

    REFERENCES = %w[scheme host port request_uri path query]
  end
end