class Quiz
  attr_reader :result, :waste_time

  def initialize(quiz, correct_answers, max_minutes)
    @waste_time = 0
    @max_minutes = max_minutes
    @quiz = quiz
    @correct_answers = correct_answers
    @score = 0
    @result = ''
  end

  def self.create
    questions_answer = {}
    QUESTIONS.each do |question|
      questions_answer[question.shift] = question
    end

    quiz = []
    questions_answer.each do |question, answers|
      temp_arr = []
      answers.map { |answer| temp_arr << Answer.new(answer) }
      quiz << Question.new(question, temp_arr)
    end

    correct_answers = CORRECT_ANSWERS
    max_minutes = MAX_MINUTES

    new(quiz, correct_answers, max_minutes)
  end

  def start_quiz
    reset_quiz!

    start_time = Time.now.min
    user_answers = []

    @quiz.each do |quiz|
      puts quiz.question
      quiz.answers.each_with_index do |answer, i|
        puts "#{i + 1}. #{answer}"
      end
      user_answers << ask_user
    end

    if waste?(start_time)
      abort 'Не уложились! Идите учиться!!!'
    else
      @waste_time = Time.now.min - start_time
    end

    check_score(user_answers)
    user_result
  end

  private

  def ask_user
    user_input = ''
    STDIN.gets.chomp if user_input.empty?
  end

  def check_score(user_answers)
    user_answers.each_with_index do |answer, i|
      @score += 1 if answer == @correct_answers[i]
    end
  end

  def waste?(start_time)
    Time.now.min - start_time > @max_minutes
  end

  def user_result
    RESULT.each do |score_range, result|
      @result = result if score_range.include?(@score)
    end
  end

  def reset_quiz!
    @score = 0
    @waste_time = 0
    @result = ''
  end
end
