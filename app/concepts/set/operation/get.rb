require 'csv'

class Set::Get < Trailblazer::Operation
  step :fetch_repository
  step :fetch_repository_files
  step :find_file
  step :get

  def fetch_repository(options)
    options[:repository] = Repository::Get.(id: nil)[:data]
  end

  def fetch_repository_files(options)
    options[:repository_files] = filter_repository_files(options[:repository])
  end

  def find_file(options)
    absolute_path = options["params"][:id]
    options[:file] = options[:repository_files].find{ |node| node.absolute_path == absolute_path }
  end

  def get(options)
    file = options[:file]
    absolute_path = file.absolute_path
    languages = fetch_languages(absolute_path)
    set = {name: file.name, absolute_path: absolute_path, languages: languages, words: fetch_words(absolute_path, languages)}
    options[:data] = OpenStruct.new(set)
  end

  private

  def filter_repository_files(node)
    return [node] if node.file
    node.nodes.flat_map do |sub_node|
      filter_repository_files(sub_node)
    end
  end

  def directory
    Rails.application.credentials[Rails.env.to_sym][:storage_directory]
  end

  def fetch_languages(path)
    headers = ::CSV.open("#{directory}/#{path}", 'r', col_sep: col_sep) { |rows| rows.first }
    return [] if headers.blank?
    headers.compact.map(&:to_sym)
  end

  def fetch_words(path, languages)
    return [] if languages.blank?
    ::CSV.read("#{directory}/#{path}", col_sep: col_sep, headers: true).map{ |row| { languages[0] => row[0], languages[1] => row[1] } }
  end

  def col_sep
    ";"
  end
end
