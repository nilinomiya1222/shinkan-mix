class ChangeColumnToCircles < ActiveRecord::Migration
  def up
    change_column :circles, :entrance_fee, :string
    change_column :circles, :annual_fee, :string
    change_column :circles, :camp, :string
  end
  def down
    change_column :circles, :entrance_fee, :integer
    change_column :circles, :annual_fee, :integer
    change_column :circles, :camp, :integer
  end
end
