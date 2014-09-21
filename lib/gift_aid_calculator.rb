class GiftAidCalculator

  DEFAULT_TAX_RATE = 20

  @@tax_rate = DEFAULT_TAX_RATE

  def self.tax_rate
    @@tax_rate
  end

  def self.gift_aid_for(donation_amount)
    simple_gift_aid_calculation(donation_amount)
  end

  def self.update_tax_rate(new_tax_rate, user)
    @@tax_rate = new_tax_rate if user.administrator?
  end

  def self.simple_gift_aid_calculation(donation_amount)
    donation_amount * ( tax_rate / (100 - tax_rate) ) 
  end

  private_class_method :simple_gift_aid_calculation

end