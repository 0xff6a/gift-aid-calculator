require 'admin'

describe Admin do

  let(:admin) { Admin.new }

  it 'should be an administrator by default' do
    expect(admin).to be_administrator
  end

end