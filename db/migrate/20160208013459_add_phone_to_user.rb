class AddPhoneToUser < ActiveRecord::Migration
  def change
    add_column :circles, :phone, :string, null: false, limit: 13
    add_column :circles, :phone_possible, :boolean, null: false, default: false
    add_column :circles, :show_email, :string
  end
end
