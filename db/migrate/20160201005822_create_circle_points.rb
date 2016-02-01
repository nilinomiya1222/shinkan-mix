class CreateCirclePoints < ActiveRecord::Migration
  def change
    create_table :circle_points do |t|
      t.references :circle
      t.references :rule
      t.references :appeal
      t.timestamps
    end
  end
end
