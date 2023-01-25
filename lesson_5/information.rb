module Information
  module InstanceMethods
    def get_name_manufacturer
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
