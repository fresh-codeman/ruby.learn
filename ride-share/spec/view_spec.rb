require './spec/spec_helper'

RSpec.describe View do
  let(:data) { nil }
  let(:error) { nil }
  let(:result_wrapper) { { data:, error: }}

  describe '#add_driver' do
    it 'prints nothing' do
      expect { described_class.add_driver(result_wrapper) }.to output("").to_stdout
    end
  end

  describe '#add_rider' do
    it 'prints nothing' do
      expect { described_class.add_driver(result_wrapper) }.to output("").to_stdout
    end
  end

  describe '#match_drivers_to_rider' do
    context 'when only data provided' do
      let(:data) { {driver_ids: ['DA', 'D2', 'D3']} }
  
      it 'prints data' do
        expect { described_class.match_drivers_to_rider(result_wrapper) }.to output("DRIVERS_MATCHED DA D2 D3\n").to_stdout
      end
    end

    context 'when result_wrapper has error' do
      let(:error) { NoDriverAvailableError.new()}

      it 'prints message' do
        expect { described_class.match_drivers_to_rider(result_wrapper) }.to output("NO_DRIVERS_AVAILABLE\n").to_stdout
      end 
    end
  end

  describe '#start_ride' do
    context 'when only data provided' do
      let(:data) { {ride_id: 'R34' } }
  
      it 'prints data' do
        expect { described_class.start_ride(result_wrapper) }.to output("RIDE_STARTED R34\n").to_stdout
      end
    end

    context 'when error propagated' do
      let(:error) { InvalidRideError.new() }

      it 'prints message' do
        expect { described_class.start_ride(result_wrapper) }.to output("INVALID_RIDE\n").to_stdout
      end 
    end
  end

  describe '#stop_ride' do
    context 'when only data provided' do
      let(:data) { {ride_id: 'R34' } }
      it 'prints data' do
        expect { described_class.stop_ride(result_wrapper) }.to output("RIDE_STOPPED R34\n").to_stdout
      end
    end

    context 'when error provided' do
      let(:error) { InvalidRideError.new() }

      it 'prints message' do
        expect { described_class.stop_ride(result_wrapper) }.to output("INVALID_RIDE\n").to_stdout
      end 
    end
  end

  describe '#bill' do
    context 'when only data provided' do
      let(:data) { {ride_id: 'R34', driver_id: 'D1', amount: 234.34 } }

      it 'prints data' do
        expect { described_class.bill(result_wrapper) }.to output("BILL R34 D1 234.34\n").to_stdout
      end
    end

    context 'when error provided' do
      let(:error) { InvalidRideError.new() }

      it 'prints message' do
        expect { described_class.bill(result_wrapper) }.to output("INVALID_RIDE\n").to_stdout
      end 
    end
  end
end