require './spec/spec_helper'

RSpec.describe BillController do
  let(:driver) {build(:driver, location: build(:location, :origin))}
  let(:rider_location) {build(:location, x_coordinate:3, y_coordinate: 5)}
  let(:rider) {build(:rider, location: rider_location)}
  let(:location) { build(:location, x_coordinate: 10, y_coordinate: 2) }
  let(:ride) {create_ongoing_ride(rider,driver)}
  let(:time_taken) { 48 }
  let(:ride_id) {ride.id}
  let(:not_completed_ride) { create(:ride) }
  let(:params) {{ride_id: }}
  let(:call) { described_class.bill(params) }
  before do 
    create_completed_ride(ride, location, time_taken)
    not_completed_ride.save
  end

  describe '#bill' do
    context 'when invalid ride is provided' do
      let(:ride_id) {'invalid'}
      it 'returns error object' do
        response = call

        expect(response[:data]).to be nil 
        expect(response[:error]).to be_a(InvalidRideError)         
        expect(response[:error].code).to eq('INVALID_RIDE')         
        expect(response[:error].message).to eq("Ride not exists/available for ride_id: #{ride_id}")         
      end
    end

    context 'when ride not completed' do
      let(:ride_id) {not_completed_ride.id}
      it 'returns error object' do
        response = call

        expect(response[:data]).to be nil 
        expect(response[:error]).to be_a(InvalidRideError)         
        expect(response[:error].code).to eq('INVALID_RIDE')         
        expect(response[:error].message).to eq("Ride not exists/available for ride_id: #{ride_id}")         
      end
    end

    context 'when params are valid' do
      it 'returns the ride_id driver_id amount' do
        response = call

        expect(response[:error]).to be nil
        expect(response[:data][:ride_id]).to eq(ride_id) 
        expect(response[:data][:driver_id]).to eq(driver.id) 
        expect(response[:data][:amount]).to eq(234.64)
      end
    end
  end
end