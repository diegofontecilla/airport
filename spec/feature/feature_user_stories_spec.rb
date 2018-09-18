require 'airport'

describe 'user stories' do
  let(:fake_plane_1) { double(:plane, :landed => false) }
  let(:fake_plane_2) { double(:plane, :landed => false) }
  let(:fake_plane_3) { double(:plane, :landed => false) }
  let(:fake_plane_4) { double(:plane, :landed => false) }
  let(:fake_storm_g) { double(:storm_generator, :is_stormy? => false) }

  it 'airport can instruct a plane for landing' do
    airport = Airport.new(1, fake_storm_g)
    airport.cleared_for_landing?(fake_plane_1)
    airport.instruct_landing(fake_plane_1)
    expect(airport.landed_planes.count).to eq(1)
  end

  it 'airport can instruct a plane for take off' do
    airport = Airport.new(1, fake_storm_g)
    airport.cleared_for_landing?(fake_plane_1)
    airport.instruct_landing(fake_plane_1)
    airport.instruct_take_off(fake_plane_1)
    expect(airport.landed_planes.count).to eq(0)
  end

  it 'airport can instruct a number planes for landing and take off' do
    airport = Airport.new(4, fake_storm_g)
    airport.cleared_for_landing?(fake_plane_1)
    airport.instruct_landing(fake_plane_1)
    airport.cleared_for_landing?(fake_plane_2)
    airport.instruct_landing(fake_plane_2)
    airport.cleared_for_landing?(fake_plane_3)
    airport.instruct_landing(fake_plane_3)
    airport.cleared_for_landing?(fake_plane_4)
    airport.instruct_landing(fake_plane_4)
    airport.instruct_take_off(fake_plane_1)
    airport.instruct_take_off(fake_plane_2)
    expect(airport.landed_planes.count).to eq(2)
  end
end
