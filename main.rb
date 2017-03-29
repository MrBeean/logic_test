require_relative 'lib/answer'
require_relative 'lib/question'
require_relative 'lib/quiz'

require 'rexml/document'

username = ARGV[0] == nil ? 'Анонимус' : ARGV[0]
puts "Привет, #{username.encode('UTF-8')}"

quiz = Quiz.read_from_xml(File.dirname(__FILE__) + '/data/quiz.xml')

puts "Тест на логику вашего мышления. У вас есть #{quiz.max_minutes} минут на 12 вопросов!\n"
puts "В качестве ответа пишите номер варианта, можно несколько, через запятую\n\r"

quiz.start_quiz

puts "Вы потратили на тест: #{quiz.waste_time} мин."
puts "Ваш результат:\n#{quiz.user_result}"
