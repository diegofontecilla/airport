require 'airport'

describe Airport do
  subject(:airport) { described_class.new }
  let(:fake_plane_1) { double(:plane) }
  let(:fake_plane_2) { double(:plane) }
  let(:fake_plane_3) { double(:plane) }
  let(:fake_plane_4) { double(:plane) }
  let(:fake_storm_g) { double(:storm_generator) }

  describe '#take_off' do
    context 'when there is good weather' do

      it 'a plane from the airport' do
        airport = Airport.new(capacity = 2, fake_storm_g)
        allow(fake_storm_g).to receive(:is_stormy?).and_return(false)
        airport.land(fake_plane_1)
        airport.take_off
        expect(airport.planes).to be_empty
      end

      it 'one plane at the time' do
        airport = Airport.new(capacity = 2, fake_storm_g)
        allow(fake_storm_g).to receive(:is_stormy?).and_return(false)
        airport.land(fake_plane_1)
        airport.land(fake_plane_2)
        airport.take_off
        expect(airport.planes.length).to eq(1)
      end

      it 'confirm that a plane is not longer at the airport' do
        airport = Airport.new(capacity = 2, fake_storm_g)
        allow(fake_storm_g).to receive(:is_stormy?).and_return(false)
        airport.land(fake_plane_1)
        expect(airport.take_off).to eq("A plane has taken off")
      end
    end

    it 'is prevent when airport is empty' do
      expect(airport.take_off).to eq("The airport is currently empty")
    end

    context 'when weather is stormy' do
      it 'is prevented' do
        airport = Airport.new(capacity = 2, fake_storm_g)
        allow(fake_storm_g).to receive(:is_stormy?).and_return(false)
        airport.land(fake_plane_1)
        allow(fake_storm_g).to receive(:is_stormy?).and_return(true)
        expect(airport.take_off).to eq("Take off not allowed due to stormy weather")
      end
    end
  end

  describe '#land' do
    context 'one plane' do

      it 'can instrtuct a plane to land' do
        airport = Airport.new(2, fake_storm_g)
        allow(fake_storm_g).to receive(:is_stormy?).and_return(false)
        airport.land(fake_plane_1)
        expect(airport.planes.count).to eq(1)
      end
    end

    context 'more than one plane' do

      it 'prevent landing when is full' do
        airport = Airport.new(capacity = 2, fake_storm_g)
        allow(fake_storm_g).to receive(:is_stormy?).and_return(false)
        airport.land(fake_plane_1)
        airport.land(fake_plane_2)
        # WHY IF I LAND ANOTHER PLANE HERE THE TEST STILL PASS?
        expect(airport.land(fake_plane_3)).to eq("Unauthorized landing, airport is currently full")
      end

      it 'capacity can be overriden as appropriate' do
        airport = Airport.new(4, fake_storm_g)
        allow(fake_storm_g).to receive(:is_stormy?).and_return(false)
        airport.land(fake_plane_1)
        airport.land(fake_plane_2)
        airport.land(fake_plane_3)
        airport.land(fake_plane_4)
        expect(airport.planes.count).to eq(4)
      end

      it 'prevent from landing same plane twice' do
        airport = Airport.new(2, fake_storm_g)
        allow(fake_storm_g).to receive(:is_stormy?).and_return(false)
        airport.land(fake_plane_1)
        expect(airport.land(fake_plane_1)).to eq("Error, this plane is already landed")
      end
    end

    context 'with stormy weather' do

      it 'is not allowed' do
        airport = Airport.new(capacity = 2, fake_storm_g)
        allow(fake_storm_g).to receive(:is_stormy?).and_return(true)
        expect(airport.land(fake_plane_1)).to eq("Landing not allowed due to stormy weather")
      end
    end
  end
end
