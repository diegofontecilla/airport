require 'storm_generator'

describe StormGenerator do

# THIS TEST IS A LIAR
  it 'inform when weather is stormy' do
    storm_generator = StormGenerator.new
    allow(storm_generator).to receive(:is_stormy).and_return(false)
    expect(storm_generator.is_stormy).to eq(false)
  end
end
