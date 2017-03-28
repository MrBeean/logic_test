class Answer
  attr_reader :answer

  def initialize(answer)
    @answer = answer
  end

  def to_s
    "#{@answer}"
  end
end
