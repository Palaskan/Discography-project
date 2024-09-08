class AddLpToSongs < ActiveRecord::Migration[7.1]
  def change
    add_reference :songs, :lp, foreign_key: true
  end
end
