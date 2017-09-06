require './lib/models/dish.rb'

describe Dish do
  it{is_expected.to have_property :name}
  it{is_expected.to have_property :id}
end
