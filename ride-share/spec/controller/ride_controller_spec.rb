require './spec/spec_helper'

RSpec.describe RideController do
  let(:ride_id) {Faker::Internet.uuid}
  let(:selected_driver_index) { 1 }
  let(:rider) {create(:rider)}
  let(:rider_id) {rider.id}
  let(:params) {{ride_id:, selected_driver_index:, rider_id:}}
  
  describe '#start_ride' do
    let(:call) { described_class.start_ride(params) }

    context 'when rider id is invalid' do
      let(:rider_id) {'invalid'}

      it 'returns error' do
        response = call

        expect(response[:data]).to be nil 
        expect(response[:error]).to be_a( InvalidRideError)
        expect(response[:error].code).to eq('INVALID_RIDE')
        expect(response[:error].message).to eq("Rider not exists for rider_id: #{rider_id}")       
      end
    end

    context 'when matched driver not found' do
      before { rider.matches = []}
      it 'returns error' do
        response = call

        expect(response[:data]).to be nil 
        expect(response[:error]).to be_a( InvalidRideError)
        expect(response[:error].code).to eq('INVALID_RIDE')
        expect(response[:error].message).to eq("#{selected_driver_index}th driver do not exist")       
      end
    end

    context 'when params are valid' do
      let(:driver){ create(:driver) }
      let(:selected_driver){ create(:driver) }
      let(:selected_driver_index) { 2 }

      before { rider.matches = [driver, selected_driver] }

      it 'create new ride' do
        expect{call}.to change(Ride, :count).by(1)
        ride = Ride.get(ride_id)
        expect(ride.status).to eq(RideStatus::ONGOING)
        expect(ride.driver).to be(selected_driver)
        expect(ride.rider).to be(rider)
      end

      it 'update driver status' do
        call

        expect(selected_driver.driving?).to be true
        expect(Driver.get(selected_driver.id).driving?).to be true
      end

      it 'update rider status' do
        call

        expect(rider.riding?).to be true
        expect(rider.matches).to be nil
        expect(Rider.get(rider.id).riding?).to be true
      end

      it 'returns ride_id' do
        response = call
        
        expect(response[:error]).to be nil
        expect(response[:data][:ride_id]). to eq(ride_id)
      end
    end
  end
  describe '#stop_ride' do
    let(:ride) { create_ongoing_ride }
    let(:driver) {ride.driver}
    let(:rider) {ride.rider}
    let(:ride_id) { ride.id }
    let(:destination_x_coordinate) { 2 }
    let(:destination_y_coordinate) { 3 }
    let(:time_taken_in_min) { 30 }
    let(:params) { {ride_id:, destination_x_coordinate: , destination_y_coordinate:, time_taken_in_min:}}
    let(:call) { described_class.stop_ride(params) }

    context 'when ride id is invalid' do
      let(:ride_id) {'invalid'}

      it 'returns error' do
        response = call

        expect(response[:data]).to be nil 
        expect(response[:error]).to be_a( InvalidRideError)
        expect(response[:error].code).to eq('INVALID_RIDE')
        expect(response[:error].message).to eq("Ride not exists/available for ride_id: #{ride_id}")       
      end
    end

    context 'when ride_id is valid but not available' do
      let(:ride) {create(:ride)}

      it 'returns error' do
        response = call

        expect(response[:data]).to be nil 
        expect(response[:error]).to be_a( InvalidRideError)
        expect(response[:error].code).to eq('INVALID_RIDE')
        expect(response[:error].message).to eq("Ride not exists/available for ride_id: #{ride_id}")       
      end
    end

    context 'when params are valid' do
      it 'updates ride' do
        call

        expect(ride.status).to eq(RideStatus::COMPLETED)
        expect(ride.driver).to be(driver)
        expect(ride.send(:destination_location).x_coordinate).to eq(destination_x_coordinate)
        expect(ride.send(:destination_location).y_coordinate).to eq(destination_y_coordinate)
        expect(ride.send(:time_taken)).to eq(time_taken_in_min)
      end

      it 'update driver status' do
        expect{call}.to change{driver.location}
        expect(driver.driving?).to be false
        expect(driver.location).to be ride.send(:destination_location)
      end

      it 'update rider status' do
        expect{call}.to change{rider.location}
        expect(rider.riding?).to be false
        expect(rider.location).to be ride.send(:destination_location)
      end

      it 'returns ride_id' do
        response = call
        
        expect(response[:error]).to be nil
        expect(response[:data][:ride_id]). to eq(ride_id)
      end
    end
  end
end