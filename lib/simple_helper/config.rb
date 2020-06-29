# frozen_string_literal: true

require 'net/https'
module SimpleHelper
  module Config
    class << self
      def supported_methods
        {
          'get'    => Net::HTTP::Get,
          'post'   => Net::HTTP::Post,
          'patch'  => Net::HTTP::Patch,
          'put'    => Net::HTTP::Put,
          'delete' => Net::HTTP::Delete
        }
      end

      def supported_schemes
        %w[http https]
      end

      def reference
        %w[scheme host port request_uri path query]
      end

      def supported_format
        %w[json plain]
      end
    end
  end
end
