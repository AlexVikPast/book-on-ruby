class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

Animal.define_method(:voice) { puts 'У меня появился голос' }
Animal.define_method(:my_name) { puts send(:name) }

a = Animal.new('Tom')
a.voice
puts a.name
a.my_name