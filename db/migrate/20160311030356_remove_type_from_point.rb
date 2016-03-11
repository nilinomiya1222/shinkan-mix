class RemoveTypeFromPoint < ActiveRecord::Migration
  def change
    remove_column :points, :type, :string
  end
end
