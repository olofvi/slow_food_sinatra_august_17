require 'dm-validations'
require 'pry'

class User
  include DataMapper::Resource

  property :id, Serial, key: true
  property :username, String, length: 128
  property :firstname, String, length: 128
  property :lastname, String, length: 128
  property :password, BCryptHash
  property :email, String, format: :email_address
  property :phone_number, String
  property :address, String


  def authenticate(attempted_password)
    if self.password == attempted_password
      true
    else
      false
    end
  end
end
