class Animal
  def initialize(age)
    @age = age
  end
end

animal = Animal.new(5)
puts animal.age # ===> syntax error, unexpected instance variable
puts animal.instance_variable_get("@age") # ===> 5
