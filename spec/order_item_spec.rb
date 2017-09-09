require './lib/models/order_item.rb'

describe OrderItem do
  it{is_expected.to have_property :id}
  it{is_expected.to validates_presence_of :user}
end
