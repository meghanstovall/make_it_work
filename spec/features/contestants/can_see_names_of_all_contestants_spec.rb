require "rails_helper"

RSpec.describe "contestants index page", type: :feature do
  context "as a visitor" do
    it "can see list of all contestants along with each project theyve been in" do
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
      upholstery = contestant_1.projects.create!(name: "Upholstery Tuxedo", material: "Couch", challenge_id: furniture_challenge.id)
      tuxedo = contestant_2.projects.create!(name: "Upholstery Tuxedo", material: "Couch", challenge_id: furniture_challenge.id)

      visit "/contestants"

      expect(page).to have_content("#{contestant_1.name}")
      expect(page).to have_content("Projects: #{boardfit.name} #{upholstery.name}")

      expect(page).to have_content("#{contestant_2.name}")
      expect(page).to have_content("Projects: #{tuxedo.name}")
    end
  end
end
