class Flashcards::Sets
  class << self

    REPO_PATH = "./tmp/flashcards_repository".freeze

    def create(name, content)
      File.open("#{REPO_PATH}/#{name}", 'w') { |file| file.write(content) }
    end

    def find(name)
      content = File.open("#{REPO_PATH}/#{name}", 'r').read
      Flashcards::Set.new(name, content)
    end

    def all
      Dir.entries(REPO_PATH).reject{ |name| name == "." || name == ".." }
                            .sort
                            .map{ |name| Flashcards::Set.new(name) }
    end
  end
end
