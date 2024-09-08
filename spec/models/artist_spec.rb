require 'rails_helper'

RSpec.describe Artist, type: :model do
  let(:artist) { Artist.new(name: "Metallica", description: "Metal band") }
  let(:created_artist) { Artist.create!(name: "Metallica", description: "Metal band") }
  let!(:lp1) { created_artist.lps.create!(name: "Black Album", description: "Famous album") }
  let!(:lp2) { created_artist.lps.create!(name: "Ride the Lightning", description: "Another album") }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(artist).to be_valid
    end

    it "is not valid without a name" do
      artist.name = nil
      expect(artist).not_to be_valid
    end
  end

  describe "associations" do
    it "has many LPs" do
      expect(created_artist.lps).to include(lp1, lp2)
    end

    it "destroys associated LPs when destroyed" do
      expect { created_artist.destroy }.to change { Lp.count }.by(-2)
    end
  end
end
