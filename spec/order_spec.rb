require './lib/models/order.rb'

describe Order do
  it{is_expected.to have_property :id}
  it{is_expected.to have_many :order_items}
  it{is_expected.to belong_to :user}
  it{is_expected.to validate_presence_of :user}

   let(:buyer) { User.create!(username: 'Buyer',
                             password: 'password',
                             phone_number: '123456',
                             email: 'buyer@test.com') }

   let(:item_1) { Dish.create(name: 'Test 1',
                 price: 50) }
   let(:item_2) { Dish.create(name: 'Test 2', price: 10) }

   subject { described_class.create(user: buyer) }


   it 'adds dish to basket as basket_item' do
     subject.add_item(item_1, item_1.price, 2)
     expect(subject.order_items.count).to eql 1
   end
 end
