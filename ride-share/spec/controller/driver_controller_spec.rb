require './spec/spec_helper'

RSpec.describe DriverController do
  let(:driver_id) { Faker::Internet.uuid}
  let(:x_coordinate) {2}
  let(:y_coordinate) {2}
  let(:params){
    {
      driver_id: ,
      x_coordinate: ,
      y_coordinate: 
    }
  }

describe '#add_driver' do
  it 'creates and save driver' do
    expect(DriverController.add_driver(params)).to be true
  end

  it 'store the data in db' do
    DriverController.add_driver(params)
    expect(Driver.get.count).to be(1)
    expect(Driver.get.first.id).to be(driver_id)
  end
end
end