require "rails_helper"

RSpec.describe "projects show page", type: :feature do
  context "as a visitor" do
    it "can see count of contestants in this project" do
      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

      contestant_1 = Contestant.create!(name: "Patrick",
                                      age: "24",
                                      hometown: "Broomfield",
                                      years_of_experience: "4")
      contestant_2 = Contestant.create!(name: "Sean",
                                      age: "32",
                                      hometown: "Denver",
                                      years_of_experience: "8")

      boardfit = contestant_1.projects.create!(name: "Boardfit", material: "Cardboard Boxes", challenge_id: recycled_material_challenge.id)
      tuxedo = contestant_2.projects.create!(name: "Upholstery Tuxedo", material: "Couch", challenge_id: furniture_challenge.id)
      tuxedo.contestants << contestant_1

      visit "projects/#{tuxedo.id}"

      expect(page).to have_content("#{tuxedo.name}")
      expect(page).to have_content("Material: #{tuxedo.material}")
      expect(page).to have_content("Challenge Theme: #{furniture_challenge.theme}")
      expect(page).to have_content("Number of Contestants: 2")
    end
  end
end
