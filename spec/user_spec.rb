require 'user'

describe User do
  
  let(:user) { User.new }

  it 'should not be an administrator by default' do
    expect(user).not_to be_administrator
  end

end
