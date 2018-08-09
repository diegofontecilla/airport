class Plane
  attr_reader :landed

  def initialize
    @landed = false
    @cleared_for_landing = false
    @cleared_at_airport = nil
  end

  def request_landing_clearance(airport)
    if airport.cleared_for_landing?(self)
      @cleared_for_landing = true
      @cleared_at_airport = airport
    end
  end

  def land
    if @cleared_for_landing
      airport.land(self)
      @landed = true
    end
  end
end
