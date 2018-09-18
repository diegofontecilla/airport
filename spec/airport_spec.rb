require 'airport'

describe Airport do
  let(:fake_plane_1) { double(:plane, :landed => false) }
  let(:fake_plane_2) { double(:plane, :landed => false) }
  let(:fake_plane_3) { double(:plane, :landed => false) }
  let(:fake_plane_4) { double(:plane, :landed => false) }
  let(:fake_storm_g) { double(:storm_generator, :is_stormy? => false) }
  subject(:airport) { Airport.new(2, fake_storm_g) }

  describe '#instruct_take_off' do

    context 'without stormy weather' do

      it 'a plane from the airport' do
        airport.cleared_for_landing?(fake_plane_1)
        airport.instruct_landing(fake_plane_1)
        airport.instruct_take_off(fake_plane_1)
        expect(airport.landed_planes.include?(fake_plane_1)).to eq(false)
      end

      it 'one plane at the time' do
        airport.cleared_for_landing?(fake_plane_1)
        airport.instruct_landing(fake_plane_1)
        airport.cleared_for_landing?(fake_plane_2)
        airport.instruct_landing(fake_plane_2)
        airport.instruct_take_off(fake_plane_1)
        expect(airport.landed_planes.include?(fake_plane_2)).to eq(true)
      end

      it 'confirm that a plane is not longer at the airport' do
        airport.cleared_for_landing?(fake_plane_1)
        airport.instruct_landing(fake_plane_1)
        expect(airport.instruct_take_off(fake_plane_1)).to eq("A plane has taken off")
      end

      it 'prevents when plane is not at airport' do
        message = "Can not take off because plane is not at the airport"
        expect(airport.instruct_take_off(fake_plane_1)).to eq(message)
      end
    end

    context 'with stormy weather' do

      it 'take off is prevented' do
        airport.cleared_for_landing?(fake_plane_1)
        airport.instruct_landing(fake_plane_1)
        allow(fake_storm_g).to receive(:is_stormy?).and_return(true)
        message = "Take off not allowed due to stormy weather"
        expect(airport.instruct_take_off(fake_plane_1)).to eq(message)
      end
    end
  end

  describe '#instruct_landing' do

    context 'without stormy weather' do

      it 'can instrtuct a plane to land' do
        airport.cleared_for_landing?(fake_plane_1)
        airport.instruct_landing(fake_plane_1)
        expect(airport.landed_planes.count).to eq(1)
      end

      it 'can instrtuct two planes to land' do
        airport.cleared_for_landing?(fake_plane_1)
        airport.instruct_landing(fake_plane_1)
        airport.cleared_for_landing?(fake_plane_2)
        airport.instruct_landing(fake_plane_2)
        expect(airport.landed_planes.count).to eq(2)
      end

      it 'prevent landing when is full' do
        airport.cleared_for_landing?(fake_plane_1)
        airport.instruct_landing(fake_plane_1)
        airport.cleared_for_landing?(fake_plane_2)
        airport.instruct_landing(fake_plane_2)
        airport.cleared_for_landing?(fake_plane_3)
        expect(airport.instruct_landing(fake_plane_3)).to eq("Plane not cleared for landing!")
      end

      it 'prevent from landing same plane twice' do
        allow(fake_plane_1).to receive(:landed).and_return(true)
        airport.cleared_for_landing?(fake_plane_1)
        expect(airport.instruct_landing(fake_plane_1)).to eq("Plane not cleared for landing!")
      end

      it 'capacity can be overriden as appropriate' do
        airport = Airport.new(4, fake_storm_g)
        airport.cleared_for_landing?(fake_plane_1)
        airport.instruct_landing(fake_plane_1)
        airport.cleared_for_landing?(fake_plane_2)
        airport.instruct_landing(fake_plane_2)
        airport.cleared_for_landing?(fake_plane_3)
        airport.instruct_landing(fake_plane_3)
        airport.cleared_for_landing?(fake_plane_4)
        airport.instruct_landing(fake_plane_4)
        expect(airport.landed_planes.count).to eq(4)
      end
    end

    context 'with stormy weather' do

      it 'is not allowed' do
        allow(fake_storm_g).to receive(:is_stormy?).and_return(true)
        airport.cleared_for_landing?(fake_plane_1)
        expect(airport.instruct_landing(fake_plane_1)).to eq("Plane not cleared for landing!")
      end
    end
  end
end
