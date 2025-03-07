require './spec/spec_helper'

RSpec.describe MatchController do
  let(:rider) { create(:rider, :rider_at_origin) }
  let(:rider_id) { rider.id }
  let(:away_driver) { create(:driver, :driver_at_20_20) }
  let(:door_driver) { create(:driver, :driver_at_20_20) }
  let(:far_driver) { create(:driver, :driver_at_20_20) }
  let(:params) { {rider_id: }}
  before do
    rider.save
    away_driver.save
    door_driver.save
    far_driver.save
  end
  describe '#match_drivers_to_rider' do
    context 'when rider id is invalid' do
      let(:rider_id) {'invalid'}
      it 'raises error' do
        expect{MatchController.match_drivers_to_rider(params)[:driver_ids]}.to raise_error do |error|
          expect(error).to be_a(NoDriverAvailableError)
          expect(error.code).to eq('NO_DRIVERS_AVAILABLE')
          expect(error.message).to eq("Invalid rider id : #{rider_id}")
        end
      end
    end

    context 'when all driver are away' do
      it 'raises error' do
        expect{MatchController.match_drivers_to_rider(params)[:driver_ids]}.to raise_error do |error|
          expect(error).to be_a(NoDriverAvailableError)
          expect(error.code).to eq('NO_DRIVERS_AVAILABLE')
          expect(error.message).to eq("No drivers Available for rider_id : #{rider_id}")
        end
      end
    end

    context 'when drivers are in the range' do
      let(:pass_driver) {create(:driver, :driver_at_3_2)}
      let(:origin_driver) {create(:driver, :driver_at_origin)}
      before do 
        pass_driver.save
        origin_driver.save
      end
      it 'returns array of driver ids' do
        expect(MatchController.match_drivers_to_rider(params)[:driver_ids].count).to eq(2) 
      end
      
      it 'return in ascending order of distance from rider' do
        drivers = MatchController.match_drivers_to_rider(params)[:driver_ids]
        expect(drivers[0]).to be(origin_driver.id)
        expect(drivers[1]).to be(pass_driver.id)
      end

      it 'sets matches to rider' do
        driver_ids = MatchController.match_drivers_to_rider(params)[:driver_ids]
        expect(rider.matches.map{|driver| driver.id}).to contain_exactly(*driver_ids)
      end
    end
    
    context 'when available drivers are same distant' do
      let(:driver_1) {create(:driver, :driver_at_3_2, id: '11')}
      let(:driver_b) {create(:driver, :driver_at_3_2, id: '1b')}
      let(:driver_3) {create(:driver, :driver_at_3_2, id: '13')}
      let(:driver_a) {create(:driver, :driver_at_origin, id: 'a')}
      let(:driver_2) {create(:driver, :driver_at_origin, id: '2')}
      let(:driver_c) {create(:driver, :driver_at_origin, id: 'c')}

      before do 
        driver_1.save
        driver_2.save
        driver_3.save
        driver_a.save
        driver_b.save
        driver_c.save
      end
      it 'returns array of 5 drivers max' do
        expect(MatchController.match_drivers_to_rider(params)[:driver_ids].count).to eq(5) 
      end
      
      it 'return in ascending order of distance from rider' do
        driver_ids = MatchController.match_drivers_to_rider(params)[:driver_ids]
        expect(driver_ids[0]).to be(driver_2.id)
        expect(driver_ids[1]).to be(driver_a.id)
        expect(driver_ids[2]).to be(driver_c.id)
        expect(driver_ids[3]).to be(driver_1.id)
        expect(driver_ids[4]).to be(driver_3.id)
      end 
    end
  end
end