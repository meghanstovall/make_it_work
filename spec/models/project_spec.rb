require 'rails_helper'


RSpec.describe Project, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :material}
  end

  describe "relationships" do
    it {should belong_to :challenge}
    it {should have_many :contestant_projects}
    it {should have_many(:contestants).through(:contestant_projects)}
  end

  describe "methods" do
    it "average_contestant_experience" do
      furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

      contestant_1 = Contestant.create!(name: "Patrick",
                                      age: "24",
                                      hometown: "Broomfield",
                                      years_of_experience: "4")
      contestant_2 = Contestant.create!(name: "Sean",
                                      age: "32",
                                      hometown: "Denver",
                                      years_of_experience: "8")
      contestant_3 = Contestant.create!(name: "Kelly",
                                      age: "20",
                                      hometown: "Denver",
                                      years_of_experience: "3")
      tuxedo = contestant_1.projects.create!(name: "Upholstery Tuxedo", material: "Couch", challenge_id: furniture_challenge.id)
      tuxedo.contestants << contestant_2
      tuxedo.contestants << contestant_3

      expect(tuxedo.average_contestant_experience).to eq(5)
    end
  end
end
