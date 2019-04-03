class Repository::Repository

  attr_reader :name, :absolute_path, :relative_path, :file, :level, :nodes
  attr_writer :nodes

  def initialize(file_path, nested_level)
    @name = File.basename(file_path)
    @absolute_path = file_path == directory ? "" : file_path.gsub(directory, "").split("/")[1..-1].join("/")
    @relative_path = file_path == directory ? "" : file_path.gsub(directory, "").split("/")[1..-2].join("/")
    @file = File.file?(file_path)
    @level = nested_level
    @nodes = []
  end

  private

  def directory
    Rails.application.credentials[Rails.env.to_sym][:storage_directory]
  end
end
