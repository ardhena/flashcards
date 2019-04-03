require "rails_helper"

RSpec.describe "Repositories", type: :request do
  it "lists root tree of repositories" do
    get("/repositories")
    expect(response).to render_template(:index)
    expect(response.body).to include("Repositories")
    expect(response.body).to include("Gemfile")
    expect(response.body).to include("app")
  end

  it "lists subtree of repositories" do
    get("/repositories/app%2Fassets")
    expect(response).to render_template(:index)
    expect(response.body).to include("Repositories")
    expect(response.body).to include("config")
    expect(response.body).to include("stylesheets")
  end
end
