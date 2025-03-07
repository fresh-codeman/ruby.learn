require './spec/spec_helper'

RSpec.describe View do
  describe '#add_driver' do
    it 'prints nothing' do
      expect { described_class.add_driver(nil) }.to output("").to_stdout
    end
  end

  describe '#add_rider' do
    it 'prints nothing' do
      expect { described_class.add_driver(nil) }.to output("").to_stdout
    end
  end

  describe '#match_drivers_to_rider' do
    let(:data) { {driver_ids: ['DA', 'D2', 'D3'] } }
    it 'prints data' do
      expect { described_class.match_drivers_to_rider(data) }.to output("DRIVERS_MATCHED DA D2 D3\n").to_stdout
    end

    context 'when invalid data provided' do
      let(:data) { nil }
      it 'prints message if code not present' do
        expect{described_class.match_drivers_to_rider(data)}.to output("undefined method '[]' for nil\n").to_stdout
      end 
    end

    context 'when error propagated' do
      before { allow(data).to receive(:[]).and_raise(NoDriverAvailableError.new())}
      it 'prints message if code not present' do
        expect { described_class.match_drivers_to_rider(data) }.to output("NO_DRIVERS_AVAILABLE\n").to_stdout
      end 
    end
  end

  describe '#start_ride' do
    let(:data) { {ride_id: 'R34' } }
    it 'prints data' do
      expect { described_class.start_ride(data) }.to output("RIDE_STARTED R34\n").to_stdout
    end

    context 'when invalid data provided' do
      let(:data) { nil }
      it 'prints message if code not present' do
        expect{described_class.start_ride(data)}.to output("undefined method '[]' for nil\n").to_stdout
      end 
    end

    context 'when error propagated' do
      before { allow(data).to receive(:[]).and_raise(InvalidRideError.new())}
      it 'prints message if code not present' do
        expect { described_class.start_ride(data) }.to output("INVALID_RIDE\n").to_stdout
      end 
    end
  end

  describe '#stop_ride' do
    let(:data) { {ride_id: 'R34' } }
    it 'prints data' do
      expect { described_class.stop_ride(data) }.to output("RIDE_STOPPED R34\n").to_stdout
    end

    context 'when invalid data provided' do
      let(:data) { nil }
      it 'prints message if code not present' do
        expect{described_class.stop_ride(data)}.to output("undefined method '[]' for nil\n").to_stdout
      end 
    end

    context 'when error propagated' do
      before { allow(data).to receive(:[]).and_raise(InvalidRideError.new())}
      it 'prints message if code not present' do
        expect { described_class.stop_ride(data) }.to output("INVALID_RIDE\n").to_stdout
      end 
    end
  end

  describe '#bill' do
    let(:data) { {ride_id: 'R34', driver_id: 'D1', amount: 234.34 } }
    it 'prints data' do
      expect { described_class.bill(data) }.to output("BILL R34 D1 234.34\n").to_stdout
    end

    context 'when invalid data provided' do
      let(:data) { nil }
      it 'prints message if code not present' do
        expect{described_class.bill(data)}.to output("undefined method 'values_at' for nil\n").to_stdout
      end 
    end

    context 'when error propagated' do
      before { allow(data).to receive(:values_at).and_raise(InvalidRideError.new())}
      it 'prints message if code not present' do
        expect { described_class.bill(data) }.to output("INVALID_RIDE\n").to_stdout
      end 
    end
  end
end