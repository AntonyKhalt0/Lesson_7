module InstanceCounter

  def self.included(base_class)
    base_class.extend ClassMethods
    base_class.include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instance_count ||= 0
    end
  end

  module InstanceMethods
    protected
    def register_instance
      self.class.instances += 1
    end
  end
end
