# frozen_string_literal: true

module Information
  def self.included(base)
    base.include(InstanceMethods)
  end

  module InstanceMethods
    def name_manufacturer
      name
    end

    def write_name_manufacturer(name)
      @name = name
    end

    private

    def name
      @name ||= []
    end
  end
end
