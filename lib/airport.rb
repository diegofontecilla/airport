require_relative 'storm_generator'

class Airport

  attr_reader :planes

  def initialize(capacity = 2, storm_g = StormGenerator.new)
    @planes = []
    @capacity = capacity
    @storm_g = storm_g
  end

  def land(plane)
    return land_denied_for_storm if stormy?
    return airport_full if !capacity_available?
    return plane_at_airport_error if plane_is_at_airport?(plane)
    @planes << plane
  end

  def take_off
    return airport_is_empty if @planes.empty?
    return take_off_denied_for_storm if stormy?
    @planes.pop
    confirm_take_off
  end

private

  attr_reader :capacity

  def plane_at_airport_error
    "Error, this plane is already landed"
  end

  def plane_is_at_airport?(plane)
    !@planes.empty? && @planes.last.object_id == plane.object_id
  end

  def airport_full
    "Unauthorized landing, airport is currently full"
  end

  def land_denied_for_storm
    "Landing denied due to stormy weather"
  end

  def take_off_denied_for_storm
    "Take off not allowed due to stormy weather"
  end

  def stormy?
    @storm_g.is_stormy?
  end

  def capacity_available?
    # WHY IF I CHANGE TO CAPACITY(NO @) STILL WORKS?
    @planes.count < @capacity ? true : false
  end

  def confirm_take_off
    "A plane has taken off"
  end

  def airport_is_empty
    "The airport is currently empty"
  end
end
