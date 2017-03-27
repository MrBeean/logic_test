require_relative 'lib/quiz'
require_relative 'lib/data'

username = ARGV[0] == nil ? 'Анонимус' : ARGV[0]
puts "Привет, #{username.encode('UTF-8')}"
puts "Тест на логику вашего мышления. У вас есть 8 минут на 12 вопросов!\n"

quiz = Quiz.create

quiz.start_quiz

# # puts "Вы потратили на тест: #{quiz.waste_time} мин."
# # puts "Ваш результат:\n"
# # RESULT.each do |score_range, result|
# #   puts result if score_range.include?(quiz.score)
# end