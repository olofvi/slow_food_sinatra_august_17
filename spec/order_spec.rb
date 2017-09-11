require './lib/models/order.rb'

describe Order do
  let(:item_1) { Dish.create(name: 'Test 1',
                             price: 50) }
  let(:item_2) { Dish.create(name: 'Test 2', price: 10) }

  let!(:buyer) { User.create!(username: 'Buyer',
                             password: 'password',
                             password_confirmation: 'password',
                             phone_number: '123456',
                             email: 'buyer@test.com') }

  subject do
    described_class.create!(user: buyer)
  end
  it { is_expected.to have_property :id }
  it { is_expected.to have_many :order_items }
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of :user }


  it 'adds dish to order as order_item' do
    subject.add_item(item_1, item_1.price, 2)
    expect(subject.order_items.count).to eql 1
  end

  it 'it displays total sum of the order with 1 in quantity' do
    subject.add_item(item_1, item_1.price, 1)
    expect(subject.total).to eql item_1.price
  end

  it 'it displays total sum of the order with 2 in quantity' do
    subject.add_item(item_1, item_1.price, 2)
    expect(subject.total).to eql item_1.price * 2
  end

  it 'it displays total sum of the order with 2 items' do
    subject.add_item(item_1, item_1.price, 1)
    subject.add_item(item_2, item_2.price, 1)
    expect(subject.total).to eql item_1.price + item_2.price
  end

  it 'it displays estimated pick up time' do
    expect(subject.set_pick_up_time).to eql Time.now.round + 1800
  end

  it 'removes item from order' do
    #we add two items to the order. We count unique items, not the total quantity
    subject.add_item(item_1, item_1.price, 2)
    subject.add_item(item_2, item_2.price, 2)
    expect(subject.order_items.count).to eql 2
    subject.remove_item(item_1)
    expect(subject.order_items.count).to eql 1
  end

  it 'cancels order' do
    subject.add_item(item_1, item_1.price, 2)
    subject.cancel_order
    expect(subject.order_items.count).to eql 0
  end

  it '#order_include?' do
    subject.add_item(item_1, item_1.price, 2)
    expect(subject.order_include?(item_1)).to eql true
  end
end
