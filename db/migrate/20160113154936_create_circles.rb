class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.integer :user_id
      t.integer :circle_genre_id
      t.string :campus
      t.string :name
      t.string :name_kana
      t.string :email
      t.string :show_email
      t.string :phone, limit: 13
      t.boolean :phone_possible, null: false, default: false
      t.string :chief
      t.string :chief_kana
      t.string :sub_chief
      t.integer :member_male, null: false, default: 0
      t.integer :member_female, null: false, default: 0
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
      t.string :booth
      t.string :hp
      t.string :twitter
      t.boolean :facebook, null: false, default: false
      t.integer :status, null: false, default: 1
      t.timestamps
    end
  end
end
