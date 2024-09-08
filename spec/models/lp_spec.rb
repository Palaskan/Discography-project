require 'rails_helper'

RSpec.describe Lp, type: :model do
  let(:artist) { Artist.create!(name: "Metallica", description: "Metal band") }
  let(:lp) { artist.lps.create!(name: "Black Album", description: "Famous album") }
  let!(:song1) { lp.songs.create!(name: "Enter Sandman", description: "Famous song") }
  let!(:song2) { lp.songs.create!(name: "Unforgiven", description: "Another famous song") }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(lp).to be_valid
    end

    it "is not valid without a name" do
      invalid_lp = Lp.new(description: "Famous album", artist: artist)
      expect(invalid_lp).not_to be_valid
    end
  end

  describe "associations" do
    it "belongs to an artist" do
      expect(lp.artist).to eq(artist)
    end

    it "has many songs" do
      expect(lp.songs).to include(song1, song2)
    end

    it "destroys associated songs when destroyed" do
      expect { lp.destroy }.to change { Song.count }.by(-2)
    end
  end
end
