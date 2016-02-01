class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.integer :lg_genre_id
      t.string :name
      t.string :type
      t.timestamps
    end
  end
end
