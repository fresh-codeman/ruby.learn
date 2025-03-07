require './spec/spec_helper'

RSpec.describe Ride do
  let(:ride_id) {'R1'}
  subject { described_class.new(ride_id) }

  describe '#initialize' do
    it 'creates instance' do
      expect(subject).to be_a(described_class)
    end

    it 'sets the id and status' do
      expect(subject.id).to be(ride_id)
      expect(subject.status).to be(RideStatus::ACCEPTED)
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
      expect(subject.instance_variable_get(:@rider_source_location)).to be(rider.location)
      expect(subject.instance_variable_get(:@driver_source_location)).to be(driver.location)
      expect(subject.status).to be(RideStatus::ONGOING)
    end
  end

  describe '#stop_ride' do
    let(:location) { build(:location) }
    let(:time_taken) { Faker::Number.number }
    subject { create_ongoing_ride }
    it 'stops the ride' do
      subject.stop_ride(location, time_taken)
      expect(subject.destination_location).to be(location)
      expect(subject.time_taken).to be(time_taken)
      expect(subject.status).to be(RideStatus::COMPLETED)
    end
  end

  describe '#ongoing?' do
    context 'when ride in not ongoing' do
      it 'returns false' do
        expect(subject.ongoing?).to be false
      end
    end

    context 'when ride is ongoing' do
      subject {create_ongoing_ride}
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
      subject {create_completed_ride}
      it 'returns true' do
        expect(subject.completed?).to be true
      end
    end
  end
end