class Quiz
  attr_reader :result, :max_minutes, :waste_time

  def initialize(questions, max_minutes, result)
    @max_minutes = max_minutes
    @questions = questions
    @result = result
    @waste_time = 0
    @score = 0
  end

  def self.read_from_xml(file_path)
    begin
      file = File.new(file_path)
    rescue Errno::ENOENT
      abort "Файл не найден"
    end
    data = REXML::Document.new(file)
    file.close

    questions = []
    max_minutes = data.elements["questions"].attributes["minutes"].to_i
    result_hash = {}

    data.elements.each('*/question') do |quiz_question|
      question = quiz_question.elements["text"].text.gsub(/\n +/, '')

      answers = []
      quiz_question.elements.each('*/variant') do |variant|
        answers << Answer.new(variant.text, variant.attributes["right"] == "true")
      end

      questions << Question.new(question, answers)
    end

    data.elements.each('*/results/result') do |result|
      result_hash[result.attributes["range"]] = result.text
    end

    self.new(questions, max_minutes, result_hash)
  end

  def start_quiz
    reset_quiz!

    start_time = Time.now

    @questions.each do |question|
      puts question.question
      question.answers.each_with_index do |answer, i|
        puts "#{i + 1}. #{answer}"
      end
      user_answer = ask_user(question)
      check_score(user_answer, question)
    end

    if waste?(start_time)
      abort 'Не уложились! Идите учиться!!!'
    else
      @waste_time = (Time.now - start_time) / 60
    end
  end

  def user_result
    @result.each do |score_range, result|
      return result.gsub(/\n +/, '') if change_to_range(score_range).include?(@score)
    end
  end

  private

  def ask_user(question)
    user_input = 'answers'
    user_input = STDIN.gets.chomp until correct?(user_input, question.answers.size)
    user_input
  end

  def correct?(user_input, max_size)
    answers_arr = user_input.split(',')

    if answers_arr.length > 1
      answers_arr.map! do |answer|
        answer.to_i.to_s == answer && answer.to_i - 1 < max_size
      end

      answers_arr.select { |answer| !answer }.empty?
    else
      number = answers_arr[0].to_i
      number.to_s == answers_arr[0] && number - 1 < max_size
    end
  end

  def check_score(user_answer, question)
    answers_arr = user_answer.split(',')

    if answers_arr.length > 1
      answers_arr.map! do |answer|
        question.answers[answer.to_i - 1].right?
      end

      @score += 1 if answers_arr.select { |answer| !answer }.empty?
    else
      @score += 1 if question.answers[answers_arr[0].to_i - 1].right?
    end
  end

  def waste?(start_time)
    (Time.now - start_time) / 60 > @max_minutes
  end


  def change_to_range(string_range)
    range = string_range.split('..').map { |element| Integer(element) }
    range[0]..range[1]
  end

  def reset_quiz!
    @score = 0
    @waste_time = 0
  end
end
