require_relative 'user'

class Admin < User

  def initialize
    super(:admin)
  end

end