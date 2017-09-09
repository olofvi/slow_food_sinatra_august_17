require './lib/models/order_item.rb'

describe Dish do
  it{is_expected.to have_property :id}
  it{is_expected.to have_many :order_items}
  it{is_expected.to belongs_to :user}
  it{is_expected.to validates_presence_of :user}
end 
