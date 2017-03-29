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

    start_time = Time.now.min

    @questions.each do |question|
      puts question.question
      question.answers.each_with_index do |answer, i|
        puts "#{i + 1}. #{answer}"
      end
      user_answer = ask_user.to_i
      check_score(user_answer, question)
    end

    if waste?(start_time)
      abort 'Не уложились! Идите учиться!!!'
    else
      @waste_time = Time.now.min - start_time
    end
  end

  def user_result
    @result.each do |score_range, result|
      return result.gsub(/\n +/, '') if change_to_range(score_range).include?(@score)
    end
  end

  private

  def ask_user
    user_input = ''
    STDIN.gets.chomp if user_input.empty?
  end

  def check_score(user_answer, question)
    @score += 1 if question.answers[user_answer - 1].right?
    p @score
  end

  def waste?(start_time)
    Time.now.min - start_time > @max_minutes
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
