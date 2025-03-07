require './spec/spec_helper'

RSpec.describe Database do
  let(:dummyClass) {Struct.new(:id,:status)}

  before do
    _ = dummyClass
    dummyClass.include(described_class)
  end

  describe '#included' do
    it 'set class variable' do
      expect(dummyClass.instance_variables).to include(:@data)
    end
    it 'extend class methods to base class' do
      expect(dummyClass.singleton_class.included_modules  ).to include(described_class::ClassMethods)
    end
  end

  describe '#save' do
    let(:driver_1) {dummyClass.new('df1') }
    it 'set the data for instances of base class' do
      expect(driver_1.save).to be true
      expect(dummyClass.get(driver_1.id)).to eq(driver_1)
    end
  end

  describe '#get' do
    let(:driver_1) {dummyClass.new('df1') }
    let(:driver_2) {dummyClass.new('df1') }
    before {driver_1.save; driver_2.save}
    it 'set the data for instances of base class' do
      expect(dummyClass.get(driver_1.id)).to eq(driver_1)
    end
  end

  describe '#count' do
    let(:driver_1) {dummyClass.new('df1') }
    let(:driver_2) {dummyClass.new('df2') }
    before {driver_1.save; driver_2.save}
    it 'set the data for instances of base class' do
      expect(dummyClass.count).to eq(2)
    end
  end

  describe '#create' do
    let(:id) { 'id' }
    let(:status) { 'gone' }
    it 'returns new object of dummy class' do
      expect(dummyClass.create(id,status)).to be_a(dummyClass)
    end

    it 'save the object' do
      dummyClass.create(id,status)
      expect(dummyClass.get.first.id).to be(id)
    end
  end

  describe '#reset_database' do
    let(:driver_1) {dummyClass.new('df1') }
    let(:driver_2) {dummyClass.new('df2') }
    before {driver_1.save; driver_2.save}
    it 'resets the to empty array' do
      dummyClass.reset_database
      expect(dummyClass.get).to eq([])
    end
  end
end