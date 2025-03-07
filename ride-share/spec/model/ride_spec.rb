require './spec/spec_helper'

RSpec.describe Ride do
  let(:ride_id) {'R1'}
  let(:ride_attrs) {{id: ride_id}}
  subject { described_class.new(ride_attrs) }

  describe '#initialize' do
    it 'creates instance' do
      expect(subject).to be_a(described_class)
    end

    it 'sets the id and status' do
      expect(subject.id).to be(ride_id)
      expect(subject.status).to be(RideStatus::ACCEPTED)
    end
    it 'sets other instance variable as nil' do
      expect(subject.driver).to be nil
      expect(subject.rider).to be nil
      expect(subject.amount).to be nil
      expect(subject.send(:driver_source_location)).to be nil
      expect(subject.send(:rider_source_location)).to be nil
      expect(subject.send(:destination_location)).to be nil
      expect(subject.send(:time_taken)).to be nil
    end
  end

  describe '#start_ride' do
    let(:driver) { double('Driver',location: build(:location)) }
    let(:rider) { instance_double('Rider', location: build(:location)) }

    before { subject }

    it 'starts the ride' do
      subject.start_ride(driver, rider)
      expect(subject.rider).to be(rider)
      expect(subject.driver).to be(driver)
      expect(subject.send(:rider_source_location)).to be(rider.location)
      expect(subject.send(:driver_source_location)).to be(driver.location)
      expect(subject.status).to be(RideStatus::ONGOING)
    end
  end

  describe '#stop_ride' do
    let(:driver) {build(:driver, location: build(:location, :origin))}
    let(:rider) {build(:rider, location: build(:location, :origin))}
    let(:location) { build(:location, x_coordinate: 4, y_coordinate: 5) }
    let(:ride) {create_ongoing_ride(rider,driver)}
    let(:time_taken) { 32 }
    it 'stops the ride' do
      ride.stop_ride(location, time_taken)
      expect(ride.send(:destination_location)).to be(location)
      expect(ride.send(:time_taken)).to be(time_taken)
      expect(ride.send(:rider_distance).round(2)).to eq(6.40)
      expect(ride.amount.round(2)).to eq(186.74) # TODO: actual value is 186.72
      expect(ride.status).to be(RideStatus::COMPLETED)
    end
  end

  describe '#ongoing?' do
    context 'when ride in not ongoing' do
      it 'returns false' do
        expect(subject.ongoing?).to be false
      end
    end

    context 'when ride is ongoing' do
      subject {build_ongoing_ride}
      it 'returns true' do
        expect(subject.ongoing?).to be true
      end
    end
  end

  describe '#completed?' do
    context 'when ride in not completed' do
      it 'returns false' do
        expect(subject.completed?).to be false
      end
    end

    context 'when ride is completed' do
      subject {build_completed_ride}
      it 'returns true' do
        expect(subject.completed?).to be true
      end
    end
  end
end