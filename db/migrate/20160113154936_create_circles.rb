class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.integer :user_id
      t.integer :circle_genre_id
      t.string :campus
      t.string :name
      t.string :name_kana
      t.string :email
      t.string :chief
      t.string :chief_kana
      t.string :sub_chief
      t.integer :member_male
      t.integer :member_female
      t.integer :since
      t.integer :entrance_fee
      t.integer :annual_fee
      t.string :active_weeks
      t.string :active_times
      t.string :hangout
      t.string :location
      t.integer :camp
      t.integer :join_grades
      t.string :appeal
      t.text :pr
      t.string :hp
      t.string :twitter
      t.string :facebook
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
