class AddBoothToCircles < ActiveRecord::Migration
  def change
    add_column :circles, :booth, :string
    remove_column :events, :join_grade, :integer
  end
end
