class Dish
  include DataMapper::Resource
  property :id, Serial, key: true
  property :name, String
  property :description, String
  property :price, Integer
  property :category, String
  property :user, String, key: false

  validates_presence_of :price
end
