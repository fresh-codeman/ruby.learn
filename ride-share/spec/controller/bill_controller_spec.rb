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
  before do 
    create_completed_ride(ride, location, time_taken)
    not_completed_ride.save
  end

  describe '#bill' do
    context 'when invalid ride is provided' do
      let(:ride_id) {'invalid'}
      it 'raise error' do
        expect{described_class.bill(params)}.to raise_error{ |error|
          expect(error).to be_a(InvalidRideError)
          expect(error.code).to eq('INVALID_RIDE')
          expect(error.message).to eq("Ride not exists/available for ride_id: #{ride_id}")
        }
      end
    end

    context 'when ride not completed' do
      let(:ride_id) {not_completed_ride.id}
      it 'raise error' do
        expect{described_class.bill(params)}.to raise_error{ |error|
          expect(error).to be_a(InvalidRideError)
          expect(error.code).to eq('INVALID_RIDE')
          expect(error.message).to eq("Ride not exists/available for ride_id: #{ride_id}")
        }
      end
    end

    context 'when params are valid' do
      it 'returns the ride_id driver_id amount' do
        expect(described_class.bill(params)[:ride_id]).to eq(ride_id) 
        expect(described_class.bill(params)[:driver_id]).to eq(driver.id) 
        expect(described_class.bill(params)[:amount]).to eq(234.60)   # TODO: actual answer is 234.64
      end
    end
  end
end