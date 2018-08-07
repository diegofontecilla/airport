class Airport
  attr_reader :planes, :capacity, :plane_number

  def initialize(capacity = 2)
    @planes = []
    @capacity = capacity
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

  def capacity_available?
    @planes.count <= @capacity - 1 ? true : false
  end

  def confirm_take_off
    "A plane has taken off"
  end

  def airport_is_empty
    "The airport is currently empty"
  end
end
