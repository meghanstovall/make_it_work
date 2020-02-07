require "rails_helper"

RSpec.describe "projects show page", type: :feature do
  context "as a visitor" do
    it "can see average years of experience for contestants" do
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
      tuxedo = contestant_2.projects.create!(name: "Upholstery Tuxedo", material: "Couch", challenge_id: furniture_challenge.id)
  

      visit "/projects/#{tuxedo.id}"

      expect(page).to have_content("New Contestant")

      fill_in 'name', with: "Shauna"
      fill_in 'age', with: "38"
      fill_in 'hometown', with: "Westminster"
      fill_in 'years_of_experience', with: "10"
      click_button "Add Contestant To Project"

      expect(current_path).to eq("/projects/#{tuxedo.id}")
      expect(page).to have_content("Number of Contestants: 3")
    end
  end
end
