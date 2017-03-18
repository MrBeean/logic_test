require_relative 'lib/logic_test'
require_relative 'lib/printer'
require_relative 'lib/data'

# Инициализируем класс вывода на экран
printer = Printer.new

username = ARGV[0] == nil ? 'Анонимус' : ARGV[0]
printer.hello(username)

# Запускаем сам тест
testing = LogicTest.new

# Выводим результаты теста
printer.minutes_spent(testing.start_time)
printer.result(testing.score)