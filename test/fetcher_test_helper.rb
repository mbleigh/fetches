class FetchTestModel
  def self.find(some_integer)
    puts "Testing #{some_integer}"
    case some_integer.to_i
    when 1
      "one worked"
    when 2
      "two worked"
    else
      raise "Couldn't find FetchTestModel with ID=#{some_integer.to_i}"
    end
  end
  
  def self.other_finder(some_parameter)
    case some_parameter
    when "cool"
      return "cool worked"
    when "awesome"
      return "awesome worked"
    else
      nil
    end
  end
end

class FakeController
  @@helper_methods = []
  
  def self.helper_methods
    @@helper_methods
  end
  
  def self.helper_method(*args)
    @@helper_methods += args
  end
  
  attr_accessor :params
end