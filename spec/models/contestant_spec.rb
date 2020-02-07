require 'rails_helper'


RSpec.describe Contestant, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
    it {should validate_presence_of :hometown}
    it {should validate_presence_of :years_of_experience}
  end

  describe "relationships" do
    it {should have_many :contestant_projects}
    it {should have_many(:projects).through(:contestant_projects)}
  end

  describe "methods" do
    it "contestant_count" do
      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
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
      boardfit = contestant_1.projects.create!(name: "Boardfit", material: "Cardboard Boxes", challenge_id: recycled_material_challenge.id)
      boardfit.contestants << contestant_2
      boardfit.contestants << contestant_3
      
      expect(Contestant.contestant_count).to eq(3)
    end
  end
end
