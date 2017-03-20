class LogicTest
  attr_reader :score, :start_time

  def initialize
    @start_time = Time.now.min
    @score = 0
    testing
  end

  def testing
    user_answers = []

    QUESTIONS.each do |question|
      display_question(question)

      question.each_with_index do |variant, i|
        display_variant(variant, i) unless i.zero?
      end

      user_input = ''
      user_input = STDIN.gets.chomp.delete(' ') if user_input.empty?
      user_answers << user_input
    end

    user_answers.each_with_index do |answer, i|
      @score += 1 if answer == KEYS[i]
    end
  end
end

