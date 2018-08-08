# WHY I CAN'T RUN THE PROGRAM ON IRB WITH TGIS REQUIRE???
# require 'storm_generator'

class Airport
  attr_reader :planes, :capacity

  def initialize(capacity = 2, storm_g = StormGenerator.new)
    @planes = []
    @capacity = capacity
    @storm_g = storm_g
  end

  def land(plane)
    return "Landing not allowed due to stormy weather" if stormy?

    if capacity_available?
      message = "Error, this plane is already landed"
      return message if !@planes.empty? && @planes.last.object_id == plane.object_id
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
