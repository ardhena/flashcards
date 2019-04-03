class Repository::Get < Trailblazer::Operation
  step :get

  def get(options)
    path = options["params"][:id]
    options[:data] = path.present? ? build_node_tree("#{directory}/#{path}") : build_node_tree("#{directory}")
  end

  private

  def directory
    Rails.application.credentials[Rails.env.to_sym][:storage_directory]
  end

  def build_node_tree(file_path, nested_level = 0)
    return unless File.exist?(file_path)
    node = Repository::Repository.new(file_path, nested_level)

    Dir.glob("#{file_path}/*").each do |file|
      node.nodes << build_node_tree(file, nested_level + 1)
    end
    node.nodes.sort_by!{ |node| node.absolute_path }

    node
  end
end
