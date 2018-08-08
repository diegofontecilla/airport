require 'storm_generator'

describe StormGenerator do
  subject(:storm_generator) { described_class.new}

  it 'inform when weather is stormy' do
    allow(storm_generator).to receive(:rand).and_return(1)
    expect(storm_generator.is_stormy?).to eq(true)
  end

  it 'inform when weather is not stormy' do
    allow(storm_generator).to receive(:rand).and_return(3)
    expect(storm_generator.is_stormy?).to eq(false)
  end
end
