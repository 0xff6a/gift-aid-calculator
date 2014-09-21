require_relative 'event'

class GiftAidCalculator

  DEFAULT_TAX_RATE = 20.0
  DEFAULT_ROUNDING = 2

  @@tax_rate = DEFAULT_TAX_RATE

  def self.tax_rate
    @@tax_rate
  end

  def self.update_tax_rate(new_tax_rate, user)
    set_tax_rate_to(new_tax_rate) if user.administrator?
  end

  def self.gift_aid_for(donation_amount, event = default_event)
    rounded_gift_aid_calculation(donation_amount, event)
  end

  def self.rounded_gift_aid_calculation(donation_amount, event)
    raw_gift_aid_calculation(donation_amount, event).round(DEFAULT_ROUNDING)
  end

  def self.raw_gift_aid_calculation(donation_amount, event)
    (gift_aid_factor(event) * donation_amount)
  end

  def self.gift_aid_factor(event)
    return simple_gift_aid_factor unless event.promoted?
    supplemented_gift_aid_factor(event)
  end

  def self.simple_gift_aid_factor
    tax_rate / (100 - tax_rate)
  end

  def self.supplemented_gift_aid_factor(event)
    simple_gift_aid_factor * supplement_factor_for(event)
  end

  def self.supplement_factor_for(event)
    ( 1 + event.gift_aid_supplement / 100 )
  end

  def self.set_tax_rate_to(new_tax_rate)
    @@tax_rate = new_tax_rate 
  end

  def self.default_event
    Event.new(:default)
  end 

  private_class_method  :rounded_gift_aid_calculation,
                        :raw_gift_aid_calculation,
                        :gift_aid_factor,
                        :simple_gift_aid_factor,
                        :supplemented_gift_aid_factor,
                        :supplement_factor_for,
                        :set_tax_rate_to,
                        :default_event

end