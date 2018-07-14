require 'airport'
require 'plane'

describe Airport do
  it 'can instrtuct a plane to land' do
    airport = Airport.new
    plane = Plane.new
    airport.land(plane)
    expect(airport.planes).not_to be_empty
  end
end
