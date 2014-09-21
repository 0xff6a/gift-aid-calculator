require 'gift_aid_calculator'

describe GiftAidCalculator do

  let(:tax_rate)      { GiftAidCalculator::DEFAULT_TAX_RATE                 }
  let(:new_tax_rate)  { 30                                                  }
  let(:donation)      { 7.294                                               }
  let(:admin)         { double Admin, administrator?: true                  }
  let(:user)          { double User, administrator?: false                  }

  before(:each)       { GiftAidCalculator.update_tax_rate(tax_rate, admin)  }

  context 'initialisation' do

    it 'should have a default tax rate of 20' do
      expect(GiftAidCalculator.tax_rate).to eq 20
    end

  end

  context '#gift_aid_for' do

    it 'should return gift aid amount based on tax rate and donation' do
      expected_amount = _gift_aid(donation, tax_rate)
      expect(GiftAidCalculator.gift_aid_for(donation)).to eq expected_amount 
    end

    it 'gift aid amount should be rounded to 2 decimal places' do
      amount, rounded_amount = 1.23456, 1.23
      expect(GiftAidCalculator).to receive(:raw_gift_aid_calculation).and_return(amount)
      expect(GiftAidCalculator.gift_aid_for(donation)).to eq rounded_amount 
    end

  end

  context '#update_tax_rate' do

    it 'an adminstrator can update the tax rate' do
      GiftAidCalculator.update_tax_rate(new_tax_rate, admin)
      expect(GiftAidCalculator.tax_rate).to eq new_tax_rate
    end

    it 'a user cannot update the tax rate' do
      GiftAidCalculator.update_tax_rate(new_tax_rate, user)
      expect(GiftAidCalculator.tax_rate).to eq tax_rate
    end

    it 'gift aid amount is calculated based on current tax rate in data store' do
      expected_amount = _gift_aid(donation, new_tax_rate)
      GiftAidCalculator.update_tax_rate(new_tax_rate, admin)
      expect(GiftAidCalculator.gift_aid_for(donation)).to eq expected_amount 
    end

  end

  context 'event type modifier' do

    it 'should add appropriate supplement to gift aid for donations for promoted events' do
      event = double Event, gift_aid_supplement: 5.0, promoted?: true
      default_gift_aid = GiftAidCalculator.gift_aid_for(donation)
      expect(GiftAidCalculator.gift_aid_for(donation, event)).to eq (default_gift_aid * 1.05).round(2)
    end

    it 'should add not add a supplement for events not promoted' do
      event = double Event, gift_aid_supplement: 5.0, promoted?: false
      default_gift_aid = GiftAidCalculator.gift_aid_for(donation)
      expect(GiftAidCalculator.gift_aid_for(donation, event)).to eq default_gift_aid
    end

  end

  def _gift_aid(donation, tax_rate)
    (donation * ( tax_rate / (100 - tax_rate) )).round(2)
  end
  
end