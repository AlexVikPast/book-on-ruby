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

> Возвращает значение заданной переменной экземпляра или nil, если переменная экземпляра не установлена

Тут стоит добавить что значение мы получаем непосредственно по имени переменной, это может быть либо строка либо символ.
Данный метод удобно подходит для создания "getter method".

```ruby
class A
  def initialize(a)
    @a = a
  end
end

obj = A.new("1")
puts obj.@a ===> syntax error, unexpected instance variable
puts obj.instance_variable_get("@a") ===> "1"
```

Как мы видим из [примера](https://github.com/AlexVikPast/book-on-ruby/blob/main/examples/instance_variable_get.rb) класс без "getter method" вызывает ошибку при обращении к инстанс переменной, но "instance_variable_get" легко с данной задачей справляется.

### instance_variable_set
### remove_instance_variable
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

