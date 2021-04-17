class Flashcards::Sets
  class << self
    def create(name, content)
      File.open("#{repo_path}/#{name}", 'w'){ |f| f.write(content) }
    end

    def update(name, content)
      File.open("#{repo_path}/#{name}", 'w'){ |f| f.write(content) }
    end

    def delete(name)
      File.delete("#{repo_path}/#{name}")
    end

    def find(name)
      Flashcards::Set.new(name, File.open("#{repo_path}/#{name}", 'r').read)
    end

    def all
      Dir.entries(repo_path)
         .reject{ |name| name == "." || name == ".." }
         .sort
         .map{ |name| Flashcards::Set.new(name) }
    end

    private

    def repo_path = Settings.flashcards_repository_path
  end
end
