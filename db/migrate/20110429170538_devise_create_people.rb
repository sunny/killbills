class DeviseCreatePeople < ActiveRecord::Migration
  def self.up
    change_table(:people) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable

      t.index :email
      t.index :reset_password_token, :unique => true
      # t.index :confirmation_token,   :unique => true
      # t.index :unlock_token,         :unique => true
      # t.index :authentication_token, :unique => true
    end

  end

  def self.down
    change_table(:people) do |t|
      t.remove :email
      t.remove :encrypted_password
      t.remove :reset_password_token
      t.remove :reset_password_sent_at
      t.remove :remember_created_at
      t.remove :sign_in_count
      t.remove :current_sign_in_at
      t.remove :last_sign_in_at
      t.remove :current_sign_in_ip
      t.remove :last_sign_in_ip

      t.remove_index :email
      t.remove_index :reset_password_token
    end
  end
end
