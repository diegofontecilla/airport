require 'airport'
require 'plane'

describe Airport do
  it 'can instrtuct a plane to land' do
    airport = Airport.new
    plane = Plane.new
    airport.land(plane)
    # fix when airport can land many planes
    expect(airport.planes).not_to be_empty
  end

  it 'can instruct a plane to take off' do
    airport = Airport.new
    plane = Plane.new
    airport.land(plane)
    airport.take_off
    # fix when airport can land many planes
    expect(airport.planes).to be_empty
  end

  it 'confirm that a plane is not longer at airport after take_off' do
    airport = Airport.new
    plane = Plane.new
    airport.land(plane)
    expect(airport.take_off).to eq("British 304 is not longer at airport")
  end

  it 'prevent landing when is full' do
    airport = Airport.new
    plane_1 = Plane.new
    plane_2 = Plane.new
    plane_3 = Plane.new
    airport.land(plane_1)
    airport.land(plane_2)
    airport.land(plane_3)
    # why I need to put line 36 to make it pass??????
    expect(airport.land(plane_3)).to eq("Unauthorized landing, airport is currently full")
  end

  it 'capacity can be overriden as appropriate' do
    # why the test passed with capacity = 4
    airport = Airport.new(capacity = 4)
    plane = Plane.new
    plane_1 = Plane.new
    plane_2 = Plane.new
    plane_3 = Plane.new
    plane_4 = Plane.new
    airport.land(plane_1)
    airport.land(plane_2)
    airport.land(plane_3)
    airport.land(plane_4)
    expect(airport.planes.count).to eq(4)
  end

  it 'can not take_off when airport is emprty' do
    airport = Airport.new
    plane = Plane.new
    expect(airport.take_off).to eq("The airport is currently empty")
  end
end
