class Animal
  def initialize(age)
    @age = age
  end
end

obj = Animal.new(5)
puts obj.age # ===> syntax error, unexpected instance variable
puts obj.instance_variable_get("@age") # ===> 5
