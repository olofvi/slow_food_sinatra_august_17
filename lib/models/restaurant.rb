class Restaurant
  include DataMapper::Resource
  property :id, Serial
  property :name, String, length: 255
  property :description, Text, length: 255
end
