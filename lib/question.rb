class Question
  attr_reader :question, :answers

  def initialize(question, answers)
    @question = question
    @answers = answers
  end

  def to_s
    "#{@question}"
  end
end
