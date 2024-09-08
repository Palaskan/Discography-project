require 'rails_helper'

RSpec.describe Song, type: :model do
  let(:artist) { Artist.create!(name: "Metallica", description: "Metal band") }
  let(:lp) { artist.lps.create!(name: "Black Album", description: "Famous album") }
  let!(:song) { Song.new(name: "Enter Sandman", description: "Famous song", lp: lp) }
  let(:author1) { Author.create!(name: "Hetfield", description: "Author description") }
  let(:author2) { Author.create!(name: "Jason N", description: "Author description") }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(song).to be_valid
    end

    it "is not valid without a name" do
      invalid_song = Song.new(description: "Famous song", lp: lp)
      expect(invalid_song).not_to be_valid
    end

    it "is not valid without a lp" do
      invalid_song = Song.new(name: "My Friend of Misery", description: "Famous song", lp: nil)
      expect(invalid_song).not_to be_valid
    end
  end

  describe "associations" do
    it "belongs to an LP" do
      expect(song.lp).to eq(lp)
    end

    it "can have multiple authors" do
      song.authors << [author1, author2]

      expect(song.authors).to include(author1, author2)
    end
  end
end
