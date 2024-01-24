class Animal
  def initialize(age)
    @age = age
  end

  def age
    @age
  end
end

animal = Animal.new(10)
puts animal.age # ===> 10
animal.age = 15 # ===> undefined method 'age='

animal.instance_variable_set("@age", 15)
puts animal.age # ===> 15

animal.instance_variable_set(:@age, 20)
puts animal.age # ===> 20