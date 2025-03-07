require './spec/spec_helper'

RSpec.describe RideController do
  let(:ride_id) {Faker::Internet.uuid}
  let(:selected_driver_index) { 1 }
  let(:rider) {create(:rider)}
  let(:rider_id) {rider.id}
  let(:params) {{ride_id:, selected_driver_index:, rider_id:}}
  
  describe '#start_ride' do
    context 'when rider id is invalid' do
      let(:rider_id) {'invalid'}
      it 'raises error' do
        expect{described_class.start_ride(params)}.to raise_error(ArgumentError, "Rider not exists for rider_id: #{rider_id}")
      end
    end

    context 'when matched driver not found' do
      before { rider.matches = []}
      it 'raises error' do
        expect{described_class.start_ride(params)}.to raise_error do |error|
          expect(error).to be_a(NoDriverAvailable)
          expect(error.message).to eq("#{selected_driver_index}th driver do not exist")
          expect(error.code).to eq("NO_DRIVERS_AVAILABLE")
        end
      end
    end

    context 'when params are valid' do
      let(:driver){ create(:driver) }
      let(:selected_driver){ create(:driver) }
      let(:selected_driver_index) { 2 }
      before { rider.matches = [driver, selected_driver] }
      it 'create new ride' do
        expect{described_class.start_ride(params)}.to change(Ride, :count).by(1)
        ride = Ride.get(ride_id)
        expect(ride.status).to eq(RideStatus::ONGOING)
        expect(ride.driver).to be(selected_driver)
        expect(ride.rider).to be(rider)
      end

      it 'update driver status' do
        described_class.start_ride(params)
        expect(selected_driver.driving?).to be true
        expect(Driver.get(selected_driver.id).driving?).to be true
      end

      it 'update rider status' do
        described_class.start_ride(params)
        expect(rider.riding?).to be true
        expect(rider.matches).to be nil
        expect(Rider.get(rider.id).riding?).to be true
      end
    end
  end
  describe '#stop_ride' do
    xcontext 'when ride id is invalid' do
      let(:ride_id) {'invalid'}
      it 'raises error' do
        expect{described_class.stop_ride(params)}.to raise_error(ArgumentError, "Ride not exists for ride_id: #{ride_id}")
      end
    end

    xcontext 'when ride_id is valid but not available' do
      it 'raises error' do
        expect{described_class.stop_ride(params)}.to raise_error do |error|
        end
      end
    end

    xcontext 'when params are valid' do
      it 'updates ride' do
        expect(ride.status).to eq(RideStatus::ONGOING)
        expect(ride.driver).to be(selected_driver)
        expect(ride.rider).to be(rider)
      end

      it 'update driver status' do
        described_class.stop_ride(params)
        expect(selected_driver.driving?).to be true
        expect(Driver.get(selected_driver.id).driving?).to be true
      end

      it 'update rider status' do
        described_class.stop_ride(params)
        expect(rider.riding?).to be true
        expect(Rider.get(rider.id).riding?).to be true
      end
    end
  end
end