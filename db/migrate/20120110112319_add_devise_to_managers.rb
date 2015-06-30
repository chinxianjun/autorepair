class AddDeviseToManagers < ActiveRecord::Migration
  def self.up
    create_table(:managers) do |t|
      #t.database_authenticatable :null => false
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""
      #t.recoverable
      #t.rememberable
      #t.trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      #t.lockable
      t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at
      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable
      t.string :username, :unique => true
      t.string :fullname
      t.string :phone
      t.date :birthday
      t.string :address
      t.string :gender

      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps
    end

    add_index :managers, :email,                :unique => true
    #add_index :managers, :reset_password_token, :unique => true
    # add_index :managers, :confirmation_token,   :unique => true
    # add_index :managers, :unlock_token,         :unique => true
    # add_index :managers, :authentication_token, :unique => true
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration   
  end
end
