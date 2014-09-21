require 'sinatra/base'
Dir[File.join(__dir__, 'lib', '*.rb')].each {|file| require file }

class GiftAidCalculatorApplication < Sinatra::Base
  
  get '/' do
    erb :index
  end

  post '/calculate' do
    event = Event.new(params[:event_type].to_sym)
    amount = params[:donation].to_f
    @gift_aid_amount = GiftAidCalculator.gift_aid_for(amount, event)
    erb :show
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
  
end