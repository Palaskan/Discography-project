class AddArtistToLp < ActiveRecord::Migration[7.1]
  def change
    add_reference :lps, :artist, foreign_key: true
  end
end
