class CreateECircles < ActiveRecord::Migration
  def change
    create_table :e_circles do |t|
      t.integer :circle_genre_id
      t.string :campus
      t.string :name
      t.string :name_kana
      t.string :email
      t.string :phone, limit: 13
      t.boolean :phone_possible, null: false, default: false
      t.string :chief
      t.string :chief_kana
      t.string :sub_chief
      t.integer :member_male, null: false, default: 0
      t.integer :member_female, null: false, default: 0
      t.integer :since
      t.string :entrance_fee
      t.string :annual_fee
      t.string :active_weeks
      t.string :active_times
      t.string :hangout
      t.string :location
      t.string :camp
      t.integer :join_grades
      t.string :appeal
      t.text :pr
      t.string :hp
      t.string :twitter
      t.boolean :facebook, null: false, default: false
      t.timestamps
    end
  end
end
