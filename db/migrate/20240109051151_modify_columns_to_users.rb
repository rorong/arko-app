class ModifyColumnsToUsers < ActiveRecord::Migration[7.0]
  def up
    remove_column :users, :is_otp_verified
    add_column :users, :otp_sent_at, :datetime
  end
  
  def down
    add_column :users, :is_otp_verified, :boolean, default: false
    remove_column :users, :otp_sent_at
  end
end
