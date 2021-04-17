class Flashcards::Set
  attr_reader :name, :raw_content

  def initialize(name, raw_content = nil)
    @name = name
    @raw_content = raw_content
  end

  def content
    @raw_content.split("\n").drop(1).map{ |line| line.split(";") }
  end

  def headers
    @raw_content.split("\n").first.split(";")
  end
end
