class Animal
  AGE = 5
  COUNT_ANIMAL = 10

  def self.remove_const_call
    remove_const(:AGE)
  end
end

puts Animal::COUNT_ANIMAL
Animal.send(:remove_const, :COUNT_ANIMAL)

puts Animal::COUNT_ANIMAL # ===> uninitialized constant Animal::COUNT_ANIMAL

puts Animal::AGE
Animal.remove_const_call
puts Animal::AGE # ===> uninitialized constant Animal::AGE