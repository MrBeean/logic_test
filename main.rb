require_relative 'lib/quiz'
require_relative 'lib/data'

username = ARGV[0] == nil ? 'Анонимус' : ARGV[0]
puts "Привет, #{username.encode('UTF-8')}"
puts "Тест на логику вашего мышления. У вас есть #{MAX_MINUTES} минут на 12 вопросов!\n"

quiz = Quiz.create

puts "В качестве ответа пишите номер варианта, можно несколько, через запятую\n\r"
quiz.start_quiz

puts "Вы потратили на тест: #{quiz.waste_time} мин."
puts "Ваш результат:\n#{quiz.result}"
