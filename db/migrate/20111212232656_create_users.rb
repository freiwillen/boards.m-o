class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :login,               :null => false                # optional, you can use email instead, or both
      t.string  :role, :default => 'customer'
      t.string    :email,               :null => false                # optional, you can use login instead, or both
      t.string    :crypted_password,    :null => false                # optional, see below
      t.string    :password_salt,       :null => false                # optional, but highly recommended
      t.string    :persistence_token,   :null => false                # required
      t.string    :single_access_token, :null => false                # optional, see Authlogic::Session::Params
      t.string    :perishable_token,    :null => false                # optional, see Authlogic::Session::Perishability

      t.timestamps
    end

    User.create :login => 'admin', :role => 'admin', :email => 'admin@m-o.com.ua', :password => 'admin_password', :password_confirmation => 'admin_password'
    User.create :login => 'customer', :role => 'customer', :email => 'customer@m-o.com.ua', :password => 'advert1sement', :password_confirmation => 'advert1sement'

  end

  def self.down
    drop_table :users
  end
end
