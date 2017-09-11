class OrderItem
  include DataMapper::Resource

  property :id, Serial, key: true
  property :price, Integer
  property :quantity, Integer

  has 1, :dish, through: Resource
  belongs_to :order

  validates_presence_of :dish

  def item
    Dish.get(self.dish.id)
  end
end