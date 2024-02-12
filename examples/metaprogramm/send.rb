class Animal
  attr_accessor :age

  def initialize(age)
    @age = age
  end
end

animal = Animal.new(5)
p animal.send("age") # ===> 5
animal.send("age=", 4) 

p animal.send("age") # ===> 4