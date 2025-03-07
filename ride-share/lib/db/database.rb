module Database
  def self.included(base)
    base.instance_variable_set(:@data, {})
    base.extend(ClassMethods)
  end

  def save
    self.class.data[self.id] = self
    true
  rescue
    false
  end

  def save!
    self.save
  end

  module ClassMethods
    def get(id=nil)
      if id.nil?
        return data.values unless block_given?
        data.values.select{ |_obj| yield(_obj)}
      else
        return data[id] unless data[id]
        return data[id] unless block_given?
        return yield(data[id]) ? data[id] : nil
      end
    end

    def count
      data&.values&.count
    end

    def create(*attrs, **kattrs)
      _obj = self.new(*attrs, **kattrs)
      _obj.save
      _obj
    end

    def reset_database
      @data = {}
    end

    def data
      @data ||={}
    end
  end
end
