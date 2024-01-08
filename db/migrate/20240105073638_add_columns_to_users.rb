class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :full_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :otp, :string
    add_column :users, :twilio_message_sid, :string
    add_column :users, :is_otp_verified, :boolean, default: false
  end
end
