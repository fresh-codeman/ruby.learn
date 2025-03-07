require './spec/spec_helper'

RSpec.describe RiderController do
  let(:rider_id) { Faker::Internet.uuid}
  let(:x_coordinate) {2}
  let(:y_coordinate) {2}
  let(:params){
    {
      rider_id: ,
      x_coordinate: ,
      y_coordinate: 
    }
  }

  describe '#add_rider' do
    it 'creates and save rider' do
      expect(described_class.add_rider(params)).to be true
    end

    it 'store the data in db' do
      described_class.add_rider(params)
      expect(Rider.get.count).to be(1)
      expect(Rider.get.first.id).to be(rider_id)
    end
  end
end