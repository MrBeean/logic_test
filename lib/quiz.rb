class Quiz

  MAX_MINUTES = 8

  attr_reader :score, :quiz, :waste_time

  def initialize(quiz)
    @waste_time = 0
    @quiz = quiz
    @score = 0
  end

  def self.create
    quiz = {}
    QUESTIONS.each do |question|
      quiz[question.shift] = question
    end

    new(quiz)
  end

  def start_quiz
    reset_quiz!

    start_time = Time.now.min
    user_answers = []

    @quiz.each do |question, answers|
      puts question
      answers.each_with_index { |answer, i| puts "#{i + 1}. #{answer}" }

      user_answers << ask_user
    end

    if waste?(start_time)
      abort 'Не уложились! Идите учиться!!!'
    else
      @waste_time = start_time - Time.now.min
    end

    check_result(user_answers)
  end

  def ask_user
    user_input = ''
    user_input = STDIN.gets.chomp.delete(' ') if user_input.empty?
  end

  def check_result(user_answers)
    user_answers.each_with_index do |answer, i|
      @score += 1 if answer == CORRECT_ANSWERS[i]
    end
  end

  def waste?(start_time)
    start_time - Time.now.min > MAX_MINUTES
  end

  def reset_quiz!
    @score = 0
    @waste_time = 0
  end
end
