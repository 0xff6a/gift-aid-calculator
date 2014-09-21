require 'event'

describe Event do
  
  let(:event)       { Event.new(:running) }
  let(:other_event) { Event.new(:bowling) }

  context 'initialisation' do
    
    it 'should have a type' do
      expect(event.type).to eq :running
    end

    it 'should be of default type if not running or swimming' do
      expect(other_event.type).to eq :default
    end
    
  end

  context '#gift_aid_supplement' do

    it 'should return 5 for running events' do
      expect(event.gift_aid_supplement).to eq 5
    end

    it 'should return 3 for swimming events' do
      swim_event = Event.new(:swimming)
      expect(swim_event.gift_aid_supplement).to eq 3
    end

    it 'should return 0 for other events' do
      expect(other_event.gift_aid_supplement).to eq 0
    end
  
  end

end