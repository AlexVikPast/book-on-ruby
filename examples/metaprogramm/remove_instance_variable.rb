class Animal
  def initialize(age)
    @age = age
  end

  def age=(age)
    @age = age
  end

  def age
    @age
  end

  def remove_age
    remove_instance_variable(:@age)
  end
end

animal = Animal.new(5) 
puts animal.age # ===> 5

animal.age = 10
puts animal.age # ===> 10

puts animal.remove_instance_variable(:@age) # ===> 10
puts animal.age # ===> nil

animal.age = 15
puts animal.remove_age # ===> 15

