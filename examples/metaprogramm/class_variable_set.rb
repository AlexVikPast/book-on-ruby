class Animal

  @@count_animal = 0

  def initialize(age)
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
Animal.class_variable_set(:@@count_animal, cat.population + 1)
puts cat.population # ===> 1

dog = Animal.new(10)
dog.class.class_variable_set(:@@count_animal, dog.population + 1)
puts dog.population # ===> 2
