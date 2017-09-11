class Order
  include DataMapper::Resource

  property :id, Serial, key: true, required: false
  property :pick_up_time, Time
  property :total_price, Float

  has n, :order_items
  belongs_to :user

  validates_presence_of :user

  before :save do
    set_pick_up_time
  end

  def order_include?(dish)
    item = self.order_items.find {|item| item.item.id == dish.id}
    item.dish.id == dish.id if item
  end

  def add_item(obj, price, qty)
    OrderItem.create!(dish: obj, price: price, quantity: qty, order: self)
  end

  def remove_item(obj)
    self.order_items.each do |item|
      if item.dish.id == obj.id
        item.destroy!
      end
    end if self.order_items.any?
  end

  def cancel_order
    self.order_items.each do |item|
      item.destroy!
    end if self.order_items.any?
  end

  def total
    total = 0
    self.order_items.each { |item| total += (item.price * item.quantity) }
    self.total_price = total
  end

  def set_pick_up_time
    t = Time.now
    self.pick_up_time = t.round + 1800
  end
end
