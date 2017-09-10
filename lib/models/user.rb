require 'dm-validations'
require 'pry'

class User
  include DataMapper::Resource
  attr_accessor :password_confirmation

  property :id, Serial, key: true
  property :username, String, length: 128
  property :firstname, String, length: 128
  property :lastname, String, length: 128
  property :password, BCryptHash
  property :email, String, format: :email_address
  property :phone_number, String
  property :address, String

  validates_presence_of :username, message: 'Please add username'
  validates_presence_of :email, message: 'Please add email address'
  validates_presence_of :phone_number, message: 'Please provide phone number'
  validates_presence_of :address, message: 'Please provide a valid address'

  validates_uniqueness_of :email
  validates_uniqueness_of :username

  validates_confirmation_of :password, message: 'Password is not matching confirmation'


  def authenticate(attempted_password)
    if self.password == attempted_password
      true
    else
      false
    end
  end
end
