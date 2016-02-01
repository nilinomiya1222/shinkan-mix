class CreateEventTerms < ActiveRecord::Migration
  def change
    create_table :event_terms do |t|
      t.date :start_date
      t.date :finish_date
      t.integer :status
      t.timestamps
    end
  end
end
