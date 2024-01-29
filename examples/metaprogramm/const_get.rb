class Animal
  def initialize(age)
    @age = age
  end
end

klass_name = "animal"
Klass = Object.const_get(klass_name.capitalize.to_sym)
animal = Klass.new(5)
puts animal.inspect # ===> #<Animal:0x000000014c107ed8 @age=5>

Dog = Object.const_get(:Dog) # ===> `const_get': uninitialized constant Dog (NameError)