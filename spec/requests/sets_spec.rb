require "rails_helper"

RSpec.describe "Sets", type: :request do
  it "shows flashcard set" do
    get("/sets/csv")
    expect(response).to render_template(:show)
    expect(response.body).to include("pl")
    expect(response.body).to include("en")
    expect(response.body).to include("kot")
    expect(response.body).to include("a cat")

    get("/sets/directory%2Fsub_directory%2Fcsv")
    expect(response).to render_template(:show)
    expect(response.body).to include("de")
    expect(response.body).to include("en")
    expect(response.body).to include("die Katze")
    expect(response.body).to include("a cat")
  end
end
