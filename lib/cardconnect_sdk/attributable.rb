module Attributable
  def self.included base
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
    def initialize(attrs={})
      attributes.each do |atr|
        instance_variable_set("@#{atr}", attrs.fetch(atr, nil).to_s.strip)
      end
    end

    def attributes
      self.class.attributes
    end

    def attributable?
      true
    end

    def to_json
      json_hash = {}
      attributes.each do |atr|
        iv = instance_variable_get("@#{atr}")
        json_hash[atr] = iv unless iv.nil? || iv.size == 0
      end
      json_hash.to_json
    end
  end

  module ClassMethods
    def attr_accessor(*vars)
      attributes.concat(vars)
      super(*vars)
    end

    def attr_reader(*vars)
      attributes.concat(vars)
      super(*vars)
    end

    def attributes
      @attributes ||= []
    end

    def from_json(json)
      self.new(JSON.parse(json).symbolize_keys)
    end
  end
end
