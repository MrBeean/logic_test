require_relative 'questions_keys'

name = ARGV[0]

puts "Привет, #{name.encode('UTF-8')}" if name
puts 'Тест на логику вашего мышления. У вас есть 8 минут на 12 вопросов!'
sleep 1

user_answers = []

start_time = Time.now

QUESTIONS.each do |question|
  puts
  puts question[0]
  puts

  puts 'Варианты ответов (можно указать несколько через запятую)'
  question.each_with_index do |variant, i|
    puts "#{i}: #{variant}" unless i.zero?
  end

  user_input = ''
  user_input = STDIN.gets.chomp.delete(' ') if user_input.empty?
  user_answers << user_input
end

score = 0

user_answers.each_with_index do |answer, i|
  score += 1 if answer == KEYS[i]
end

minutes_spent = (Time.now - start_time) / 60
puts "Вы потратили на тест: #{minutes_spent} мин."
puts 'Не уложились! Идите учиться!!!' if minutes_spent > 8

result = case score
         when 0..2 then 'с логикой у вас очень слабо'
         when 3..6 then 'логика не отсутствует, но, наверное, имеет смысл ее ' \
           'потренировать.'
         when 7..10 then 'вполне приемлемый результат, говорящий о нормально ' \
           'развитых логических способностях'
         when 11..12 then 'говорят о хорошо развитых логических ' \
           'способностях. Вас трудно убедить речами, в которых есть ' \
           'логические неувязки. Вы видите многие ситуации «насквозь» ' \
           'и можете «предсказывать» поведение людей из вашего окружения'
         end

puts "Ваш результат: #{score}, #{result}"
