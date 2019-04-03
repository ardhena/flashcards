require 'rails_helper'

RSpec.describe Set::Get do
  it 'returns a set' do
    set = Set::Get.(id: "csv")[:data]

    expect(set.name).to eq('csv')
    expect(set.absolute_path).to eq('csv')
    expect(set.languages).to eq([:pl, :en])
    expect(set.words).to eq([{en: "a house", pl: "dom"}, {en: "a cat", pl: "kot"}])

    set = Set::Get.(id: "directory/sub_directory/csv")[:data]

    expect(set.name).to eq('csv')
    expect(set.absolute_path).to eq('directory/sub_directory/csv')
    expect(set.languages).to eq([:en, :de])
    expect(set.words).to eq([{en: "a house", de: "das Hause"}, {en: "a cat", de: "die Katze"}])
  end
end
