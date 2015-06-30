class AddDefaultUserToUsers < ActiveRecord::Migration
  def self.up
    user = User.create(:username => "admin",
                       :password => "ht4s.com",
                       :admin => true,
                       :fullname => "Administrator",
                       :email => "admin@ht4s.com")
    user.update_attribute :admin, true
  end

  def self.down
  end
end
