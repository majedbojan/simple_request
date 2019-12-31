# frozen_string_literal: true

require_relative 'constant_data'

module SimpleRequest
  class Const
    def self.supported_methods
      ConstantData::SupportedHTTPMethods
    end

    def self.supported_schemes
      ConstantData::SupportedURISchemes
    end
    def self.reference
      ConstantData::REFERENCES
    end
  end
end
