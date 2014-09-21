class Event

  PROMOTED_TYPES = 
  {
    running:  5,
    swimming: 3
  }

  attr_reader :type

  def initialize(event_type)
    @type = set(event_type)
  end

  def promoted?(event_type)
    PROMOTED_TYPES.include?(event_type)
  end

  def gift_aid_supplement
    PROMOTED_TYPES.fetch(type, 0)
  end

  private

  def set(event_type)
    promoted?(event_type) ? set_as(event_type): set_as_default
  end

  def set_as(event_type)
    @type = event_type 
  end

  def set_as_default
    @type = :default
  end

end