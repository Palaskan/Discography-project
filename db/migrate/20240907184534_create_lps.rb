class CreateLps < ActiveRecord::Migration[7.1]
  def change
    create_table :lps do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
