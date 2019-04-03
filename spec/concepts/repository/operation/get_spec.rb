require 'rails_helper'

RSpec.describe Repository::Get do
  it 'returns a root tree of nodes' do
    repository = Repository::Get.(id: nil)[:data]

    expect_object_to_match(repository, {
      name: "fixtures",
      absolute_path: "",
      relative_path: "",
      file: false,
      level: 0,
      nodes_size: 2,
    })

    expect_object_to_match(repository.nodes.first, {
      name: "csv",
      absolute_path: "csv",
      relative_path: "",
      file: true,
      level: 1,
      nodes_size: 0,
    })

    expect_object_to_match(repository.nodes.last, {
      name: "directory",
      absolute_path: "directory",
      relative_path: "",
      file: false,
      level: 1,
      nodes_size: 1,
    })

    expect_object_to_match(repository.nodes.last.nodes.first, {
      name: "sub_directory",
      absolute_path: "directory/sub_directory",
      relative_path: "directory",
      file: false,
      level: 2,
      nodes_size: 1,
    })

    expect_object_to_match(repository.nodes.last.nodes.first.nodes.first, {
      name: "csv",
      absolute_path: "directory/sub_directory/csv",
      relative_path: "directory/sub_directory",
      file: true,
      level: 3,
      nodes_size: 0,
    })
  end

  it 'returns a sub tree of nodes' do
    repository = Repository::Get.(id: "directory/sub_directory")[:data]

    expect_object_to_match(repository, {
      name: "sub_directory",
      absolute_path: "directory/sub_directory",
      relative_path: "directory",
      file: false,
      level: 0,
      nodes_size: 1,
    })

    expect_object_to_match(repository.nodes.first, {
      name: "csv",
      absolute_path: "directory/sub_directory/csv",
      relative_path: "directory/sub_directory",
      file: true,
      level: 1,
      nodes_size: 0,
    })
  end

  def expect_object_to_match(actual_value, expected_value)
    expect(actual_value.class).to eq(Repository::Repository)

    expect(actual_value.name).to eq(expected_value[:name])
    expect(actual_value.absolute_path).to eq(expected_value[:absolute_path])
    expect(actual_value.relative_path).to eq(expected_value[:relative_path])
    expect(actual_value.file).to eq(expected_value[:file])
    expect(actual_value.level).to eq(expected_value[:level])
    expect(actual_value.nodes.size).to eq(expected_value[:nodes_size])
  end
end
