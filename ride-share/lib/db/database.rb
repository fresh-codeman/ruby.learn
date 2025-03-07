module Database
  def self.included(base)
    base.instance_variable_set(:@data, {})
    base.extend(ClassMethods)
  end

  def save
    self.class.data[self.id] = self
  end

  module ClassMethods
    def get(id=nil)
      return data.values if id.nil?
      data[id]
    end

    def reset_database
      @data = {}
    end

    def data
      @data ||={}
    end
  end
end
