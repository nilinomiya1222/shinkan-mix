class AddRuleConfirmedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rule_confirmed, :boolean
  end
end
