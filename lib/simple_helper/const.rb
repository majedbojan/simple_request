# frozen_string_literal: true

require_relative 'constant_data'

module SimpleHelper
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

    def self.supported_format
      ConstantData::SUPPORTED_FORMAT
    end

    def self.colors
      ConstantData::COLORS
    end

    def self.bg_colors
      ConstantData::BG_COLORS
    end

    def self.fonts
      ConstantData::FONTS
   end
  end
end
