# frozen_string_literal: true

class A0Struct < OpenStruct # rubocop:disable Style/OpenStructUse
  delegate :as_json, :keys, :present?, :blank?, to: :@table

  class << self
    ### Creation ###

    # Creates an A0Struct object recursively, converting Hashes to A0Struct and deeply their values
    def create(object)
      case object
      when Hash
        new(object.transform_values do |val|
          create(val)
        end)
      when Array
        object.map do |item|
          create(item)
        end
      else
        object
      end
    end

    # Creates an A0Struct object from a JSON String
    def from_json(string)
      create JSON.parse string if string.present?
    end

    ### API for getting/setting a path of A0Struct objects ###

    def get_object(obj, path, default_value = nil)
      get_path(obj, path) do |curr, key|
        curr[key] = cast_to_object curr[key], default_value
      end
    end

    def get_array(obj, path, default_value = nil)
      get_path(obj, path) do |curr, key|
        curr[key] = cast_to_array curr[key], default_value
      end
    end

    def set_object(obj, path, value)
      set_path obj, path, cast_to_object(value)
    end

    def set_array(obj, path, value)
      set_path obj, path, cast_to_array(value)
    end

    def get_path(obj, path)
      curr = obj
      keys = path_to_keys path
      last_index = keys.count - 1

      keys.each.with_index do |key, index|
        curr = curr[key] = begin
          if index == last_index
            if block_given?
              yield curr, key
            else
              curr[key]
            end
          else
            cast_to_object curr[key]
          end
        end
      end

      curr
    end

    def set_path(obj, path, value)
      curr = obj
      keys = path_to_keys path
      last_index = keys.count - 1

      keys.each.with_index do |key, index|
        curr = curr[key] = begin
          if index == last_index
            value
          else
            cast_to_object curr[key]
          end
        end
      end

      nil
    end

    def cast_to_object(value, default_value = nil)
      case value
      when A0Struct
        value
      when Hash
        A0Struct.new value
      when NilClass
        default_value || A0Struct.new
      else
        raise "cast_to_object: Invalid value.class: #{value.class}"
      end
    end

    def cast_to_array(value, default_value = nil)
      case value
      when Array
        value
      when NilClass
        default_value || []
      else
        raise "cast_to_array: Invalid value.class: #{value.class}"
      end
    end

    def path_to_keys(path)
      case path
      when Array
        path
      when String, Symbol, NilClass
        path.to_s.split('.')
      else
        raise "path should be an Array or a dotted-separated String, got path.class: #{path.class}"
      end
    end
  end
end
