class Answer
  attr_reader :text

  def initialize(answer, right)
    @text = answer
    @right = right
  end

  def to_s
    @text
  end

  def right?
    @right
  end
end
