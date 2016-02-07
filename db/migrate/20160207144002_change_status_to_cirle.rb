class ChangeStatusToCirle < ActiveRecord::Migration
  def up
    change_column :circles, :status, :string, null: false, default: 1
  end

  # 変更前の状態
  def down
    change_column :circles, :status, :string, null: false, default: 0
  end
end
