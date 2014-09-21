require_relative 'event'

class GiftAidCalculator

  DEFAULT_TAX_RATE = 20.0
  DEFAULT_ROUNDING = 2

  @tax_rate = DEFAULT_TAX_RATE.to_f

  class << self

    attr_accessor :tax_rate

    def update_tax_rate(new_tax_rate, user)
      set_tax_rate_to(new_tax_rate) if user.administrator?
    end

    def gift_aid_for(donation_amount, event = default_event)
      rounded_gift_aid_calculation(donation_amount, event)
    end

    private

    def set_tax_rate_to(new_tax_rate)
      @tax_rate = new_tax_rate.to_f 
    end

    def rounded_gift_aid_calculation(donation_amount, event)
      raw_gift_aid_calculation(donation_amount, event).round(DEFAULT_ROUNDING)
    end

    def raw_gift_aid_calculation(donation_amount, event)
      donation_amount * gift_aid_factor(event)
    end

    def gift_aid_factor(event)
      return simple_gift_aid_factor unless event.promoted?
      supplemented_gift_aid_factor(event)
    end

    def simple_gift_aid_factor
      tax_rate / (100 - tax_rate)
    end

    def supplemented_gift_aid_factor(event)
      simple_gift_aid_factor * supplement_factor_for(event)
    end

    def supplement_factor_for(event)
      ( 1 + event.gift_aid_supplement / 100 )
    end

    def default_event
      Event.new(:default)
    end 

  end

end