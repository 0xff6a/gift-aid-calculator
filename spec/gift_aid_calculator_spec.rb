require 'gift_aid_calculator'

describe GiftAidCalculator do

  let(:tax_rate)  { GiftAidCalculator::DEFAULT_TAX_RATE                 }
  let(:admin)     { double Admin, administrator?: true                  }
  let(:user)      { double User, administrator?: false                  }

  before(:each)   { GiftAidCalculator.update_tax_rate(tax_rate, admin)  }

  context 'intialisation' do

    it 'should have a default tax rate of 20%' do
      expect(GiftAidCalculator.tax_rate).to eq 20
    end

  end

  context '#gift_aid_for' do

    it 'should return gift aid assuming for the default tax rate' do
      donation = 10
      expected_amount = donation * ( tax_rate / (100 - tax_rate) ) 

      expect(GiftAidCalculator.gift_aid_for(donation)).to eq expected_amount 
    end

  end

  context '#update_tax_rate' do

    it 'an adminstrator can update the tax rate' do
      new_tax_rate = 30
      GiftAidCalculator.update_tax_rate(new_tax_rate, admin)
      expect(GiftAidCalculator.tax_rate).to eq new_tax_rate
    end

    it 'a user cannot update the tax rate' do
      new_tax_rate = 30
      GiftAidCalculator.update_tax_rate(new_tax_rate, user)
      expect(GiftAidCalculator.tax_rate).not_to eq new_tax_rate
    end

  end
  
end