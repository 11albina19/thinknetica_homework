# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*names)
    history_all = {}
    names.each do |name|
      history_all[name.to_sym] = []
      define_method(name) { instance_variable_get("@#{name}") }
      define_method("#{name}=") do |value|
        instance_variable_set("@#{name}", value)
        history_all[name.to_sym] << value
      end
      define_method("#{name}_history") { history_all[name.to_sym]}
    end
  end

  def strong_attr_accessor(name, type)
    define_method(name) { instance_variable_get("@#{name}") }
    define_method("#{name}=") do |value|
      raise "Entered value type is not correct, should be #{type}" unless value.is_a?(Object.const_get(type))
      instance_variable_set("@#{name}", value)
    end
  end
end

