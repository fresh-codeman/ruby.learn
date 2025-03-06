require_relative '../lib/command_parser'

RSpec.describe CommandParser do
  describe '#parse' do
    context 'when action is add_driver' do
      let(:command) { "ADD_DRIVER D1 1 1"}
      let(:executed_command) {described_class.parse(command)}
      let(:expected_command){
        {
          action: :add_driver,
          params: {
            driver_id: 'D1',
            x_coordinate: 1,
            y_coordinate: 1
          }
        }
      }
      it 'return hash command with action and params key' do
        expect(executed_command).to be_a(Hash)
        expect(executed_command.keys).to contain_exactly(*expected_command.keys) 
      end
  
      it 'returns correct action' do
        expect(executed_command[:action]).to be(expected_command[:action])
      end
  
      it 'returns correct params keys' do
        expect(executed_command[:params].keys).to contain_exactly(*expected_command[:params].keys)
      end
      
      it 'returns correct params values' do
        expect(executed_command[:params][:driver_id]).to eq(expected_command[:params][:driver_id])
        expect(executed_command[:params][:x_coordinate]).to be(expected_command[:params][:x_coordinate])
        expect(executed_command[:params][:y_coordinate]).to be(expected_command[:params][:y_coordinate])
      end
    end

    context 'when action is add_rider' do
      let(:command) { "ADD_RIDER R1 0 0"}
      let(:executed_command) {described_class.parse(command)}
      let(:expected_command){
        {
          action: :add_rider,
          params: {
            rider_id: 'R1',
            x_coordinate: 0,
            y_coordinate: 0
          }
        }
      }
      it 'return hash command with action and params key' do
        expect(executed_command).to be_a(Hash)
        expect(executed_command.keys).to contain_exactly(*expected_command.keys) 
      end
  
      it 'returns correct action' do
        expect(executed_command[:action]).to be(expected_command[:action])
      end
  
      it 'returns correct params keys' do
        expect(executed_command[:params].keys).to contain_exactly(*expected_command[:params].keys)
      end
      
      it 'returns correct params values' do
        expect(executed_command[:params][:driver_id]).to eq(expected_command[:params][:driver_id])
        expect(executed_command[:params][:x_coordinate]).to be(expected_command[:params][:x_coordinate])
        expect(executed_command[:params][:y_coordinate]).to be(expected_command[:params][:y_coordinate])
      end
    end

    context 'when action is match' do
      let(:command) { "MATCH R1"}
      let(:executed_command) {described_class.parse(command)}
      let(:expected_command){
        {
          action: :match,
          params: {
            rider_id: 'R1'
          }
        }
      }
  
      it 'returns correct action' do
        expect(executed_command[:action]).to be(expected_command[:action])
      end

      it 'returns correct params values' do
        expect(executed_command[:params][:rider_id]).to eq(expected_command[:params][:rider_id])
      end
    end

    context 'when action is start_ride' do
      let(:command) { "START_RIDE R1 1 R"}
      let(:executed_command) {described_class.parse(command)}
      let(:expected_command){
        {
          action: :start_ride,
          params: {
            ride_id: 'R1',
            matched_driver_index: 1,
            rider_id: 'R'
          }
        }
      }
  
      it 'returns correct action' do
        expect(executed_command[:action]).to be(expected_command[:action])
      end
  
      it 'returns correct params values' do
        expect(executed_command[:params][:ride_id]).to eq(expected_command[:params][:ride_id])
        expect(executed_command[:params][:matched_driver_index]).to be(expected_command[:params][:matched_driver_index])
        expect(executed_command[:params][:rider_id]).to eq(expected_command[:params][:rider_id])
      end
    end

    context 'when action is stop_ride' do
      let(:command) { "STOP_RIDE R1 1 4 5"}
      let(:executed_command) {described_class.parse(command)}
      let(:expected_command){
        {
          action: :stop_ride,
          params: {
            ride_id: 'R1',
            destination_x_coordinate: 1,
            destination_y_coordinate: 4,
            time_taken_in_min: 5
          }
        }
      }
  
      it 'returns correct action' do
        expect(executed_command[:action]).to be(expected_command[:action])
      end
  
      it 'returns correct params values' do
        expect(executed_command[:params][:ride_id]).to eq(expected_command[:params][:ride_id])
        expect(executed_command[:params][:destination_x_coordinate]).to eq(expected_command[:params][:destination_x_coordinate])
        expect(executed_command[:params][:destination_y_coordinate]).to eq(expected_command[:params][:destination_y_coordinate])
        expect(executed_command[:params][:time_taken_in_min]).to eq(expected_command[:params][:time_taken_in_min])
      end
    end

    context 'when action is bill' do
      let(:command) { "BILL R1"}
      let(:executed_command) {described_class.parse(command)}
      let(:expected_command){
        {
          action: :bill,
          params: {
            ride_id: 'R1',
          }
        }
      }
  
      it 'returns correct action' do
        expect(executed_command[:action]).to be(expected_command[:action])
      end
  
      it 'returns correct params values' do
        expect(executed_command[:params][:ride_id]).to eq(expected_command[:params][:ride_id])
      end
    end

    context 'when action is invalid' do
      let(:command) { 'INVALID rk 5 5 RL'}
      it 'raise error' do
        expect{ described_class.parse(command)}.to raise_error(ArgumentError)
      end
    end
  end
end