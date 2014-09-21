require 'sinatra/base'
Dir[File.join(__dir__, 'lib', '*.rb')].each {|file| require file }

class GiftAidCalculatorApplication < Sinatra::Base
  
  VALID_AUTHORISATION_STRING = 'JGHackers'
  CALCULATOR = GiftAidCalculator

  get '/' do
    @tax_rate = CALCULATOR.tax_rate.round(2)
    erb :index
  end

  post '/calculate' do
    event = Event.new(params[:event_type].to_sym)
    amount = params[:donation].to_f
    @gift_aid_amount = CALCULATOR.gift_aid_for(amount, event)
    erb :show
  end

  get '/tax_rate/update' do
    @tax_rate = CALCULATOR.tax_rate.round(2)
    erb :update
  end

  post '/tax_rate/update' do
    if params[:credentials] == VALID_AUTHORISATION_STRING
      admin = Admin.new
      CALCULATOR.update_tax_rate(params[:new_tax_rate].to_i, admin)
      redirect '/'
    else
      'ERROR'
    end
    
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
  
end