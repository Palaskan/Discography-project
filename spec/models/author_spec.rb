require 'rails_helper'

RSpec.describe Author, type: :model do
  let(:author) { Author.new(name: "Hetfield", description: "Description") }
  let(:created_author) { Author.create!(name: "Hetfield", description: "Description") }
  let(:artist) { Artist.create!(name: "Metallica", description: "Metal band") }
  let(:lp) { artist.lps.create!(name: "Black Album", description: "Famous album") }
  let(:song1) { Song.create!(name: "Enter Sandman", description: "Famous song", lp: lp) }
  let(:song2) { Song.create!(name: "Unforgiven", description: "Another famous song", lp: lp) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(author).to be_valid
    end

    it "is not valid without a name" do
      author.name = nil
      expect(author).not_to be_valid
    end
  end

  describe "associations" do
    it "can have many songs" do
      created_author.songs << [song1, song2]
      expect(created_author.songs).to include(song1, song2)
    end
  end
end
