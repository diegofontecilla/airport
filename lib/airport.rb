class Airport
  attr_reader :planes

  def initialize
    @planes = []
  end

  def land(plane)
    @planes << plane
  end

  def take_off(plane)
    @planes.delete(plane)
    confirm_take_off
  end

private

  def confirm_take_off
    "British 304 is not longer at airport"
  end
end
