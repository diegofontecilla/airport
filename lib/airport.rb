class Airport
  attr_reader :planes, :capacity

  def initialize(capacity = 2)
    @planes = []
    @capacity = capacity
  end

  def capacity_available?
    if @planes.count <= @capacity - 1
      true
    else
      false
    end
  end

  def land(plane)
    if capacity_available?
      @planes << plane
    else
      "Unauthorized landing, airport is currently full"
    end
  end

  def take_off
    if !@planes.empty?
      @planes.pop
      confirm_take_off
    else
      airport_is_empty
    end
  end

private

  def confirm_take_off
    "British 304 is not longer at airport"
  end

  def airport_is_empty
    "The airport is currently empty"
  end
end
