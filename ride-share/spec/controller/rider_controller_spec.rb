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
  let(:call) { described_class.add_rider(params) }

  describe '#add_rider' do
    it 'creates and save rider' do
      response = call

      expect(response[:data]).to be nil
      expect(response[:error]).to be nil
    end

    it 'store the data in db' do
      call
      
      expect(Rider.get.count).to be(1)
      expect(Rider.get.first.id).to be(rider_id)
    end
  end
end