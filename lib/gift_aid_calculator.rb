class GiftAidCalculator

  DEFAULT_TAX_RATE = 20.0
  DEFAULT_ROUNDING = 2

  @@tax_rate = DEFAULT_TAX_RATE

  def self.tax_rate
    @@tax_rate
  end

  def self.gift_aid_for(donation_amount)
    simple_gift_aid_calculation(donation_amount).round(2)
  end

  def self.update_tax_rate(new_tax_rate, user)
    set_tax_rate_to(new_tax_rate) if user.administrator?
  end

  def self.simple_gift_aid_calculation(donation_amount)
    donation_amount * gift_aid_multiplier
  end

  def self.gift_aid_multiplier
    tax_rate / (100 - tax_rate)
  end

  def self.set_tax_rate_to(new_tax_rate)
    @@tax_rate = new_tax_rate 
  end

  private_class_method  :simple_gift_aid_calculation,
                        :gift_aid_multiplier,
                        :set_tax_rate_to

end