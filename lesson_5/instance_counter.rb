module InstanceCounter
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    attr_writer :instances

    def instances
      @instances ||= 0
    end

    def increment_instances
      self.instances += 1
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.send :increment_instances
    end
  end
end