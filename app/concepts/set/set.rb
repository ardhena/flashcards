class Set::Set
  COLUMN_SEPARATOR = ";".freeze

  attr_reader :name, :absolute_path, :languages, :words

  def initialize(repository_node)
    @name = repository_node.name
    @absolute_path = repository_node.absolute_path
  end

  def read_file
    @languages = fetch_languages
    @words = fetch_words
  end

  private

  def directory
    Rails.application.credentials[Rails.env.to_sym][:storage_directory]
  end

  def fetch_languages
    headers = ::CSV.open("#{directory}/#{absolute_path}", 'r', col_sep: COLUMN_SEPARATOR) { |rows| rows.first }
    return [] if headers.blank?
    headers.compact.map(&:to_sym)
  end

  def fetch_words
    return [] if languages.blank?
    ::CSV
      .read("#{directory}/#{absolute_path}", col_sep: COLUMN_SEPARATOR, headers: true)
      .map{ |row| { languages[0] => row[0], languages[1] => row[1] } }
  end
end
