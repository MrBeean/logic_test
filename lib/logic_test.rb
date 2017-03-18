class LogicTest

  attr_reader :score, :start_time

  def initialize
    @start_time = Time.now.min
    @user_answers = []
    @score = 0
    testing
  end

  def testing
    QUESTIONS.each do |question|
      puts "\n#{question[0]}\n"

      puts 'Варианты ответов (можно указать несколько через запятую)'
      question.each_with_index do |variant, i|
        puts "#{i}: #{variant}" unless i.zero?
      end

      user_input = ''
      user_input = STDIN.gets.chomp.delete(' ') if user_input.empty?
      @user_answers << user_input
    end

    @user_answers.each_with_index do |answer, i|
      @score += 1 if answer == KEYS[i]
    end
  end
end

