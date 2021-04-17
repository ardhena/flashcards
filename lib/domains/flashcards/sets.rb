class Flashcards::Sets
  class << self
    def create(name, content)
      File.open("#{repo_path}/#{name}", 'w') { |file| file.write(content) }
    end

    def find(name)
      content = File.open("#{repo_path}/#{name}", 'r').read
      Flashcards::Set.new(name, content)
    end

    def all
      Dir.entries(repo_path).reject{ |name| name == "." || name == ".." }
                            .sort
                            .map{ |name| Flashcards::Set.new(name) }
    end

    private

    def repo_path = Settings.flashcards_repository_path
  end
end
