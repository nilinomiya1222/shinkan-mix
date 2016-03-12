class ChangeColumnToECircles < ActiveRecord::Migration
  def up
    change_column :e_circles, :entrance_fee, :string
    change_column :e_circles, :annual_fee, :string
  end
  def down
    change_column :e_circles, :entrance_fee, :integer
    change_column :e_circles, :annual_fee, :integer
  end
end
