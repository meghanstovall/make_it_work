require "rails_helper"

RSpec.describe "projects show page", type: :feature do
  context "as a visitor" do
    it "can see projects name, material and theme of the challenge" do
      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      project = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")

      visit "/projects/#{project.id}"

      expect(page).to have_content("#{project.name}")
      expect(page).to have_content("Material: #{project.material}")
      expect(page).to have_content("Challenge Theme: #{recycled_material_challenge.theme}")
    end
  end
end
