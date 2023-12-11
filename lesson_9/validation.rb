# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validations
      @validations ||= []
    end

    def validate (name, validation_type, *options)
      validations.push({ attr: name, type: validation_type, mask: options })
    end
  end

  module InstanceMethods

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def validate!(options = nil)
      source = self.class.superclass == Object ? self.class : self.class.superclass
      checks = source.instance_variable_get("@validations")

      checks.each do |hash|
        val = instance_variable_get("@#{hash[:attr]}")
        option = hash[:mask] ? hash[:mask].first : options
        validation_method = "validate_#{hash[:type]}"

        raise "Validation method #{validation_method} not defined in #{self.class}" unless respond_to?(validation_method, true)

        send(validation_method, hash[:attr], val, option)
      end
    end

    # station
    # train
    def validate_format(name, value, regexp_mask)
      error_message = "Error: #{name} value #{value} does not fit regexp: #{regexp_mask.to_s}"
      raise error_message if value.to_s !~ regexp_mask
    end

    #route
    # wagon
    def validate_type(name, value, type)
      #puts "Validating #{name} with type #{type}, value: #{value}"
      raise "=== Error: #{name} value #{value} has different class #{value.class} than #{type} ===" unless value.is_a?(type)
    end
  end
end
