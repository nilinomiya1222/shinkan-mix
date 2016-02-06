class ChangeColumnToCircle < ActiveRecord::Migration
  def up
    change_column :circles, :member_male, :string, null: false, default: 0
    change_column :circles, :member_female, :string, null: false, default: 0
  end

  # 変更前の状態
  def down
    change_column :circles, :member_male, :string
    change_column :circles, :member_female, :string
  end
end
