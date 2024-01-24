# Metaprogramm Programming with Ruby by AlexVikPast

Данный документ расскажет о мощной части метапрограммирования языка Ruby

## Оглавление
* [Введение](#введение)
* [Теория](#теория)
* [Функциональное программирование в Ruby](#функциональное-программирование-в-Ruby)
* [Манипулирование значениями переменных, удаление переменных](#манипулирование-значениями-переменных-удаление-переменных)
  * [instance_variable_get](#instance_variable_get)
  * [instance_variable_set](#instance_variable_set)
  * [remove_instance_variable](#remove_instance_variable)
  * [class_variable_get](#class_variable_get)
  * [class_variable_set](#class_variable_set)
  * [remove_class_variable](#remove_class_variable)
* [Манипулирование значениями констант, удаление констант](#манипулирование-значениями-констант-удаление-констант)
  * [const_get](#const_get)
  * [const_set](#const_set)
  * [remove_const](#remove_const)
* [Добавление/удаление методов](#добавление/удаление-методов)  
  * [define_method](#define_method)
  * [remove_method](#remove_method)
* [Запуск динамически генерируемого кода](#Запуск-динамически-генерируемого-кода)
  * [send](#send)
  * [instance_eval](#instance_eval)
  * [module_eval](#module_eval)
  * [eval](#eval)
  * [method_missing](#method_missing)

## Введение
## Теория
## Функциональное программирование в Ruby
## Манипулирование значениями переменных, удаление переменных
### instance_variable_get

Как на говорит [документация](https://apidock.com/ruby/Object/instance_variable_get)

> Возвращает значение заданной переменной экземпляра или nil, если переменная экземпляра не установлена.

Тут стоит добавить что значение мы получаем непосредственно по имени переменной, это может быть либо строка либо символ.
Данный метод удобно подходит для создания "getter method".

```ruby
class Animal
  def initialize(age)
    @age = age
  end
end

animal = Animal.new(5)
puts animal.age # ===> syntax error, unexpected instance variable
puts animal.instance_variable_get("@age") # ===> 5
```

Как мы видим из [примера](https://github.com/AlexVikPast/book-on-ruby/blob/main/examples/instance_variable_get.rb) класс без "getter method" вызывает ошибку при обращении к инстанс переменной, но "instance_variable_get" легко с данной задачей справляется.

### instance_variable_set
Снова обратимся к [документации](https://apidock.com/ruby/Object/instance_variable_set)
> Устанавливает переменную экземпляра, через ее символьное обозначение, для данного объекта, хотя строка тоже подойдет.

Данный метод удобно подходит для создания "setter method".

```ruby
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
```

Как видно из [примера](https://github.com/AlexVikPast/book-on-ruby/blob/main/examples/instance_variable_set.rb) без явного метода устанавливающего значения для инстанс переменной или "instance_variable_set" получаем ошибку.

### remove_instance_variable
Что нам говорит [документация?](https://apidock.com/ruby/Object/remove_instance_variable)

> Удаляет именованную переменную экземпляра из объекта obj, возвращая значение этой переменной.

Добавим в наш базовый класс стандартные getter - setter методы.

```ruby
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
```

Как мы [видим](https://github.com/AlexVikPast/book-on-ruby/blob/main/examples/remove_instance_variable.rb) методы можно с легкостью вызывать с объекта класса или внутри класса.

### class_variable_get
### class_variable_set
### remove_class_variable
## Манипулирование значениями констант, удаление констант
### const_get
### const_set
### remove_const
## Добавление/удаление методов
### define_method
### remove_method
## Запуск динамически генерируемого кода 
### send
### instance_eval
### module_eval
### eval
### method_missing

