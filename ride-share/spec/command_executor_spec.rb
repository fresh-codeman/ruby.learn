require './spec/spec_helper'

RSpec.describe CommandExecutor do
  describe '#execute' do
    context 'when command is add driver' do
      let(:command) {{action: :add_driver, params: {driver_id: "D1", x_coordinate: 0, y_coordinate: 1}}}
      it 'print nothing' do
        expect{described_class.execute(command)}.to output('').to_stdout
      end
    end
    context 'when command is add rider' do
      let(:command) {{action: :add_rider, params: {rider_id: "D1", x_coordinate: 0, y_coordinate: 1}}}
      it 'print nothing' do
        expect{described_class.execute(command)}.to output('').to_stdout
      end
    end
    context 'when command is match' do
      let(:command) {{action: :match_drivers_to_rider, params: {rider_id: "R1"}}}
      let(:location) {build(:location, :origin)}
      let(:rider) {build(:rider, id: 'R1', location:)}
      let(:driver1) {build(:driver, id: 'D1', location:)}
      let(:driver) {build(:driver, id: 'D2', location:)}
      before do
        rider.save
        driver.save
        driver1.save
      end
      it 'print nothing' do
        expect{described_class.execute(command)}.to output("DRIVERS_MATCHED D1 D2\n").to_stdout
      end
    end
  end
end