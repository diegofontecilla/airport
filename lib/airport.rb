require 'storm_generator'

class Airport
  attr_reader :planes, :capacity, :plane_number

  def initialize(capacity = 2, storm_g = StormGenerator.new)
    @planes = []
    @capacity = capacity
    @storm_g = storm_g
  end

  def land(plane)
    if capacity_available?
      @planes << plane
    else
      "Unauthorized landing, airport is currently full"
    end
  end

  def take_off
    return airport_is_empty if @planes.empty?
    return "Take off not allowed due to stormy weather" if stormy?
    @planes.pop
    confirm_take_off
  end

private

  def stormy?
    @storm_g.is_stormy?
  end

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
