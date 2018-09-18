require 'plane'

describe Plane do

  let(:plane) { Plane.new }
  let(:fake_airport) { double(:airport, :cleared_for_landing? => true)}

  context '#land' do
    it 'when airport confirm clearance for landing and instruct landing ' do
      allow(fake_airport).to receive(:instruct_landing).with(plane)
      plane.request_landing_clearance(fake_airport)
      plane.land(fake_airport)
      expect(plane.landed).to eq(true)
    end

    it 'not allowed when clearance for landing is false' do
      allow(fake_airport).to receive(:cleared_for_landing?).and_return(false)
      plane.request_landing_clearance(fake_airport)
      expect(plane.land(fake_airport)).to eq(nil)
    end
  end
end
