class A0Struct < OpenStruct
  delegate :as_json, :keys, to: :@table

  class << self
    def recursive_new(object)
      case object
      when Hash
        A0Struct.new(object.transform_values do |val|
          recursive_new(val)
        end)
      when Array
        object.map! do |item|
          recursive_new(item)
        end
      else
        object
      end
    end
  end
end
