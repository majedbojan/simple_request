# frozen_string_literal: true

module SimpleHelper
  module Utils
    def self.stringify_keys(hash)
      return hash.transform_keys(&:to_s) if hash.respond_to?(:transform_keys)

      hash.each_with_object({}) do |(key, value), new_hash|
        new_hash[key.to_s] = value
      end
    end

    def self.symbolize_keys(obj)
      case obj
      when Array
        obj.inject([]){|res, val|
          res << case val
          when Hash, Array
            symbolize_keys(val)
          else
            val
          end
          res
        }
      when Hash
        obj.inject({}){|res, (key, val)|
          nkey = case key
          when String
            key.to_sym
          else
            key
          end
          nval = case val
          when Hash, Array
            symbolize_keys(val)
          else
            val
          end
          res[nkey] = nval
          res
        }
      else
        obj
      end
    end

  end
end
