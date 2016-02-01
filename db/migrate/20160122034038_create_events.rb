class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :date
      t.integer :event_type_id
      t.string :meeting_place
      t.datetime :meeting_time
      t.integer :join_grade
      t.integer :fee
      t.string :place
      t.text :appeal
      t.integer :circle_id
      t.integer :event_term_id
      t.timestamps
    end
  end
end
