require 'airport'

describe 'user stories' do
  let(:fake_plane_1) { double(:plane) }
  let(:fake_plane_2) { double(:plane) }
  let(:fake_plane_3) { double(:plane) }
  let(:fake_plane_4) { double(:plane) }
  let(:fake_storm_g) { double(:storm_generator) }

  it 'airport can instruct a plane for landing' do
    airport = Airport.new(1, fake_storm_g)
    allow(fake_storm_g).to receive(:is_stormy?).and_return(false)
    airport.land(fake_plane_1)
    expect(airport.planes.count).to eq(1)
  end

  it 'airport can instruct a plane for take off' do
    airport = Airport.new(1, fake_storm_g)
    allow(fake_storm_g).to receive(:is_stormy?).and_return(false)
    airport.land(fake_plane_1)
    airport.take_off
    expect(airport.planes.count).to eq(0)
  end

  it 'airport can instruct a number planes for landing and take off' do
    airport = Airport.new(4, fake_storm_g)
    allow(fake_storm_g).to receive(:is_stormy?).and_return(false)
    airport.land(fake_plane_1)
    airport.land(fake_plane_2)
    airport.land(fake_plane_3)
    airport.land(fake_plane_4)
    airport.take_off
    airport.take_off
    expect(airport.planes.count).to eq(2)
  end
end
