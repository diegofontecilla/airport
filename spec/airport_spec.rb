require 'airport'

describe Airport do
  subject(:airport) { described_class.new(capacity = 2, fake_storm_g) }
  let(:fake_plane_1) { double(:plane) }
  let(:fake_plane_2) { double(:plane) }
  let(:fake_plane_3) { double(:plane) }
  let(:fake_plane_4) { double(:plane) }
  let(:fake_storm_g) { double(:storm_generator) }

  # describe '#take_off' do
  #
  #   context 'without stormy weather' do
  #
  #     before do
  #       allow(fake_storm_g).to receive(:is_stormy?).and_return(false)
  #     end
  #
  #     it 'a plane from the airport' do
  #       airport.land(fake_plane_1)
  #       airport.take_off
  #       expect(airport.planes).to be_empty
  #     end
  #
  #     it 'one plane at the time' do
  #       airport.land(fake_plane_1)
  #       airport.land(fake_plane_2)
  #       airport.take_off
  #       expect(airport.planes.length).to eq(1)
  #     end
  #
  #     it 'confirm that a plane is not longer at the airport' do
  #       airport.land(fake_plane_1)
  #       expect(airport.take_off).to eq("A plane has taken off")
  #     end
  #   end
  #
  #   it 'is prevent when airport is empty' do
  #     expect(airport.take_off).to eq("The airport is currently empty")
  #   end
  #
  #   context 'with stormy weather' do
  #
  #     it 'is prevented' do
  #       allow(fake_storm_g).to receive(:is_stormy?).and_return(false)
  #       airport.land(fake_plane_1)
  #       allow(fake_storm_g).to receive(:is_stormy?).and_return(true)
  #       expect(airport.take_off).to eq("Take off not allowed due to stormy weather")
  #     end
  #   end
  # end

  describe '#instruct_landing' do

    context 'without stormy weather' do

      before do
        allow(airport).to receive(:cheking_landing_conditions).with(fake_plane_1).and_return(true)
        allow(airport).to receive(:cheking_landing_conditions).with(fake_plane_2).and_return(true)
      end

      it 'can instrtuct a plane to land' do
        airport.cleared_for_landing?(fake_plane_1)
        airport.instruct_landing(fake_plane_1)
        expect(airport.landed_planes.count).to eq(1)
      end

      it 'can instrtuct a two planes to land' do
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
        expect(airport.instruct_landing(fake_plane_3)).to eq("Unauthorized landing, airport is currently full")
      end

      # it 'prevent from landing same plane twice' do
      #   airport.land(fake_plane_1)
      #   expect(airport.land(fake_plane_1)).to eq("Error, this plane is already landed")
      # end
      #
      # it 'capacity can be overriden as appropriate' do
      #   airport = Airport.new(4, fake_storm_g)
      #   airport.land(fake_plane_1)
      #   airport.land(fake_plane_2)
      #   airport.land(fake_plane_3)
      #   airport.land(fake_plane_4)
      #   expect(airport.planes.count).to eq(4)
      # end
    end

    # context 'with stormy weather' do
    #
    #   it 'is not allowed' do
    #     allow(fake_storm_g).to receive(:is_stormy?).and_return(true)
    #     expect(airport.land(fake_plane_1)).to eq("Landing denied due to stormy weather")
    #   end
    # end
  end
end
