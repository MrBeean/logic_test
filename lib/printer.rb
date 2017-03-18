# require_relative 'data'

class Printer
  def hello(name)
    cls
    puts "Привет, #{name.encode('UTF-8')}"
    puts "Тест на логику вашего мышления. У вас есть 8 минут на 12 вопросов!\n"
  end

  def minutes_spent(start_time)
    cls
    waste = Time.now.min - start_time
    puts "Вы потратили на тест: #{waste} мин."
    puts 'Не уложились! Идите учиться!!!' if waste > MAXMINUTES
  end

  def result(score)
    result = case score
             when 0..2
               'с логикой у вас очень слабо'
             when 3..6
               'логика не отсутствует, но, наверное, имеет смысл ее ' \
               'потренировать.'
             when 7..10
               'вполне приемлемый результат, говорящий о нормально ' \
               'развитых логических способностях'
             when 11..12
               'говорят о хорошо развитых логических ' \
               'способностях. Вас трудно убедить речами, в которых есть ' \
               'логические неувязки. Вы видите многие ситуации «насквозь» ' \
               'и можете «предсказывать» поведение людей из вашего окружения'
             end

    puts "Ваш результат: #{score}, #{result}"
  end

  def cls
    system("clear") || system("cls")
  end
end