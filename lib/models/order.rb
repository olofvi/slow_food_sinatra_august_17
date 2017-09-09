class Order
  include DataMapper::Resource

  property :id, Serial, key: true, required: true
  property :pick_up_time, Time

  has n, :order_items
  belongs_to :user

  validates_presence_of :user

  before :save do
    set_pick_up_time
  end
end
