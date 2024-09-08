class CreateJoinTableAuthorSong < ActiveRecord::Migration[7.1]
  def change
    create_join_table :authors, :songs do |t|
      t.index [:author_id, :song_id]
      t.index [:song_id, :author_id]
    end
  end
end
