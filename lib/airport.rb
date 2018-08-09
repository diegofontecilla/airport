require_relative 'plane'
require_relative 'storm_generator'

class Airport

  attr_reader :landed_planes

  def initialize(capacity = 2, storm_g = StormGenerator.new)
    @landed_planes = []
    @planes_cleared_for_landing = []
    @capacity = capacity
    @storm_g = storm_g
  end

  def cheking_landing_conditions(plane)
    return airport_full if !capacity_available?
    return land_denied_for_storm if stormy?
    return plane_has_landed if plane.land
    true
  end

  def cleared_for_landing?(plane)
    return false if !cheking_landing_conditions(plane)
    @planes_cleared_for_landing << plane
    true
  end

  def instruct_landing(plane)
    return not_cleared_for_landing if !@planes_cleared_for_landing.include?(plane)
    @landed_planes << @planes_cleared_for_landing.delete(plane)
  end

  private

  attr_reader :capacity

  def capacity_available?
    # WHY IF I CHANGE TO CAPACITY(NO @) STILL WORKS?
    @landed_planes.count < @capacity ? true : false
  end

  def stormy?
    @storm_g.is_stormy?
  end

  def plane_has_landed
    "Plane cannot land because is already landed!"
  end

  def not_cleared_for_landing
    "Plane not cleared for landing!"
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

  def confirm_take_off
    "A plane has taken off"
  end

  def airport_is_empty
    "The airport is currently empty"
  end
end
