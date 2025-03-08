require './spec/spec_helper'

RSpec.describe Location do
  let(:attrs) {{x_coordinate: 0, y_coordinate: 0}}
  subject {described_class.new(attrs)}
  describe '#initialize' do
    it 'create new location' do
      expect(subject).to be_a(described_class)
    end

    it 'set the coordinates' do
      expect(subject.x_coordinate).to eq(0)
      expect(subject.y_coordinate).to eq(0)
    end

    context 'when incorrect coordinates provided' do
      let(:attrs) { { x_coordinate: 'invalid', y_coordinate: nil } }
      
      it 'raise error' do
        expect{ subject }.to raise_error(ArgumentError, 'Invalid Argument for Location')
      end
    end
  end
  
  describe '#distance' do
    let(:object){build(:location, :location_20_20)}
    it 'returns distance' do
      expect(subject.distance(object)).to eq(Math.sqrt(800).round(2))
    end
  end
end