require_relative 'lib/logic_test'
require_relative 'lib/printer'
require_relative 'lib/data'

# Инициализируем модуль вывода на экран
include Printer

username = ARGV[0] == nil ? 'Анонимус' : ARGV[0]
hello(username)

# Запускаем сам тест
testing = LogicTest.new

# Выводим результаты теста
minutes_spent(testing.start_time)
result(testing.score)