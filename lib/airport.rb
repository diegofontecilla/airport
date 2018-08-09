require_relative 'storm_generator'

class Airport

  # attr_reader :planes

  ############################################################################

  def initialize(capacity = 2, storm_g = StormGenerator.new)
    @landed_planes = []
    @planes_cleared_for_landing = []
    @capacity = capacity
    @storm_g = storm_g
  end

  def landing_conditions_ok?(plane)
    (@planes.length < @capacity) &&
    (!is_stormy?) &&
    (!plane.landed)
  end

  def cleared_for_landing?(plane)
    return false unless landing_conditions_ok?(plane)
    @planes_cleared_for_landing << plane
    true
  end

  def land(plane)
    return unless @planes_cleared_for_landing.include?(plane)
    @landed_planes << @planes_cleared_for_landing.delete(plane)
  end

  ############################################################################

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
