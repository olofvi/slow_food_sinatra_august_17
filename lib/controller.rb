require 'bundler'
Bundler.require
Dir[File.join(File.dirname(__FILE__), 'models', '*.rb')].each { |file| require file }
require_relative 'helpers/data_mapper'
require_relative 'helpers/warden'
require 'pry'

class SlowFood < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  register Sinatra::Warden
  set :session_secret, 'supersecret'

  #Create a test User
  if User.count == 0
    User.create!(username: 'admin', password: 'password', email: 'admin@admin.com', phone_number: '123456')
  end

  use Warden::Manager do |config|
    # Tell Warden how to save our User info into a session.
    # Sessions can only take strings, not Ruby code, we'll store
    # the User's `id`
    config.serialize_into_session { |user| user.id }
    # Now tell Warden how to take what we've stored in the session
    # and get a User from that information.
    config.serialize_from_session { |id| User.get(id) }

    config.scope_defaults :default,
                          # "strategies" is an array of named methods with which to
                          # attempt authentication. We have to define this later.
                          strategies: [:password],
                          # The action is a route to send the user to when
                          # warden.authenticate! returns a false answer. We'll show
                          # this route below.
                          action: 'auth/unauthenticated'
    # When a user tries to log in and cannot, this specifies the
    # app to send the user to.
    config.failure_app = self
  end

  Warden::Manager.before_failure do |env, opts|
    env['REQUEST_METHOD'] = 'POST'
  end

  get '/' do
    @dishes_by_category = Dish.all.group_by{ |h| h[:category] }
    if session[:order_id]
      order = Order.get(session[:order_id])
      @cost = order.total
    end
    erb :index
  end

  get '/auth/create' do
    erb :create
  end

  post '/auth/create' do
    user = User.new(params[:user])
    if user.valid?
      user.save
      env['warden'].authenticate!
      flash[:success] = "Successfully created account for #{current_user.username}"
      redirect '/'
    else
      flash[:error] = user.errors.full_messages.join(',')
    end
    redirect '/auth/create'
  end

  get '/auth/login' do
    erb :login
  end

  post '/auth/login' do
    env['warden'].authenticate!
    flash[:success] = "Successfully logged in #{current_user.username}"
    if session[:return_to].nil?
      redirect '/'
    else
      redirect session[:return_to]
    end
  end

  get '/auth/logout' do
    env['warden'].raw_session.inspect
    env['warden'].logout
    flash[:success] = 'Successfully logged out'
    redirect '/'
  end

  post '/auth/unauthenticated' do
    session[:return_to] = env['warden.options'][:attempted_path] if session[:return_to].nil?

    # Set the error and use a fallback if the message is not defined
    flash[:error] = env['warden.options'][:message] || 'You must log in'
    redirect '/auth/login'
  end

  get '/protected' do
    env['warden'].authenticate!

    erb :protected
  end

  post '/order/add/:dish_id' do
    env['warden'].authenticate!
    dish = Dish.get(params[:dish_id])
    if session[:order_id]
      order = Order.get(session[:order_id])
    else
      order = Order.create(user_id: current_user.id)
      session[:order_id] = order.id
    end
    order.add_item(dish, dish.price, params[:quantity])
    flash[:success] = "#{dish.name} was added to your order"
    redirect '/'
  end

  get '/order/remove/:dish_id' do
    env['warden'].authenticate!
    dish = Dish.get(params[:dish_id])
    if session[:order_id]
      order = Order.get(session[:order_id])
      order.remove_item(dish, params[:quantity])
      flash[:success] = "#{dish.name} was removed from your order"
    else
      flash[:alert] = "You dont have any #{dish.name} in your order"
      # order = Order.create(user: current_user)
      # session[:order_id] = order.id
    end

    redirect '/'
  end

  get '/order/clear' do
    env['warden'].authenticate!
    dish = Dish.get(params[:dish_id])
    if session[:order_id]
      order = Order.get(session[:order_id])
    else
      flash[:alert] = "You dont have any #{dish.name} in your order"
    end
    order.clear
    flash[:success] = "Your order was canceled"
    redirect '/'
  end
end
