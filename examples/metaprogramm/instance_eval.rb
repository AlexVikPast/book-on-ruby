class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

person = Animal.new("Tom")
person.instance_eval do
  puts "Привет, меня зовут #{name}!" # ===> Привет, меня зовут Tom!
end
