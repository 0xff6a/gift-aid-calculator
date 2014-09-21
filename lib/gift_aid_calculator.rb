require_relative 'event'

class GiftAidCalculator

  DEFAULT_TAX_RATE = 20.0
  DEFAULT_ROUNDING = 2

  @@tax_rate = DEFAULT_TAX_RATE

  def self.tax_rate
    @@tax_rate
  end

  def self.gift_aid_for(donation_amount, event = default_event)
    rounded_gift_aid_calculation(donation_amount, event)
  end

  def self.update_tax_rate(new_tax_rate, user)
    set_tax_rate_to(new_tax_rate) if user.administrator?
  end

  def self.rounded_gift_aid_calculation(donation_amount, event)
    return simple_gift_aid_calculation(donation_amount).round(DEFAULT_ROUNDING) unless event.promoted?
    supplemented_gift_aid_calculation(donation_amount, event).round(DEFAULT_ROUNDING)
  end

  def self.simple_gift_aid_calculation(donation_amount)
    (donation_amount * gift_aid_multiplier)
  end

  def self.supplemented_gift_aid_calculation(donation_amount, event)
    simple_gift_aid_calculation(donation_amount) * ( 1 + event.gift_aid_supplement / 100 )
  end

  def self.gift_aid_multiplier
    tax_rate / (100 - tax_rate)
  end

  def self.set_tax_rate_to(new_tax_rate)
    @@tax_rate = new_tax_rate 
  end

  def self.default_event
    Event.new(:default)
  end 

  private_class_method  :supplemented_gift_aid_calculation,
                        :rounded_gift_aid_calculation,
                        :simple_gift_aid_calculation,
                        :gift_aid_multiplier,
                        :set_tax_rate_to,
                        :default_event

end