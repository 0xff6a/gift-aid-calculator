require 'sinatra/base'
Dir[File.join(__dir__, 'lib', '*.rb')].each {|file| require file }

class GiftAidCalculatorApplication < Sinatra::Base
  
  VALID_AUTHORISATION_STRING = 'JGHackers'
  CALCULATOR = GiftAidCalculator

  get '/' do
    @tax_rate = get_tax_rate
    erb :index
  end

  post '/calculate' do
    @gift_aid_amount = calculate_gift_aid_from(params)
    erb :show
  end

  get '/tax_rate/update' do
    @tax_rate = get_tax_rate
    erb :update
  end

  post '/tax_rate/update' do
    authenticated?(params[:credentials]) ? authentication_success(params) : authentication_error
  end

  # start the server if ruby file executed directly
  run! if app_file == $0

  private

  def authenticated?(credentials)
     credentials == VALID_AUTHORISATION_STRING
  end

  def get_tax_rate
    CALCULATOR.tax_rate.round(2)
  end

  def calculate_gift_aid_from(params)
    CALCULATOR.gift_aid_for(donation_from(params), event_from(params))
  end

  def event_from(params)
    Event.new(params[:event_type].to_sym)
  end

  def donation_from(params)
    params[:donation].to_f
  end

  def update_tax_rate_from(params)
    CALCULATOR.update_tax_rate(tax_rate_from(params), new_admin)
  end

  def new_admin
    Admin.new
  end

  def tax_rate_from(params)
    params[:new_tax_rate].gsub('%','').to_f
  end

  def authentication_success(params)
    update_tax_rate_from(params)
    redirect '/'
  end

  def authentication_error
    erb "<h2 class='error'>ERROR: Invalid Authorisation String</h2>"
  end
  
end