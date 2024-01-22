class Animal
  def initialize(age)
    @age = age
  end

  def age
    @age
  end
end

obj = Animal.new(10)
puts obj.age # ===> 10
obj.age = 15 # ===> undefined method 'age='

obj.instance_variable_set("@age", 15)
puts obj.age # ===> 15

obj.instance_variable_set(:@age, 20)
puts obj.age # ===> 20