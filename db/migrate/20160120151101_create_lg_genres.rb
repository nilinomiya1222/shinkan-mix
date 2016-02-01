class CreateLgGenres < ActiveRecord::Migration
  def change
    create_table :lg_genres do |t|
      t.string :name
      t.timestamps
    end
  end
end
