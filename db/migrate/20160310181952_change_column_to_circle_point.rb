class ChangeColumnToCirclePoint < ActiveRecord::Migration
  def change
    remove_column :circle_points, :rule_id, :integer
    remove_column :circle_points, :appeal_id, :integer
    add_column :circle_points, :rule1, :string
    add_column :circle_points, :rule2, :string
    add_column :circle_points, :appeal1, :string
    add_column :circle_points, :appeal2, :string
    add_column :circle_points, :appeal3, :string
  end
end
