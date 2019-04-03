require "rails_helper"

RSpec.describe "Repositories", type: :request do
  it "lists root tree of repositories" do
    get("/repositories")
    expect(response).to render_template(:index)
    expect(response.body).to include("Repositories")
    expect(response.body).to include("directory")
    expect(response.body).to include("sub_directory")
    expect(response.body).to include("csv")
  end

  it "lists subtree of repositories" do
    get("/repositories/directory%2Fsub_directory")
    expect(response).to render_template(:index)
    expect(response.body).to include("Repositories")
    expect(response.body).to include("sub_directory")
    expect(response.body).to include("csv")
  end
end
