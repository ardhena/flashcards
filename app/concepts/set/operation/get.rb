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
    set = Set::Set.new(options[:file])
    set.read_file
    options[:data] = set
  end

  private

  def filter_repository_files(node)
    return [node] if node.file
    node.nodes.flat_map do |sub_node|
      filter_repository_files(sub_node)
    end
  end
end
