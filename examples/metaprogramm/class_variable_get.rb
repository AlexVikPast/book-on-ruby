class Animal

  @@count_animal = 0

  def initialize(age)
    @@count_animal += 1
    @age = age
  end

  def age=(age)
    @age = age
  end

  def age
    @age
  end

  def population
    @@count_animal
  end
end

cat = Animal.new(5)
puts cat.population # ===> 1

dog = Animal.new(10)
puts dog.population # ===> 2

puts cat.population # ===> 2