class User

  attr_reader :privilege

  def initialize(privilege = nil)
    @privilege = privilege
  end

  def administrator?
    privilege == :admin
  end

end