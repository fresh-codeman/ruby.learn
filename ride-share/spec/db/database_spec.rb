require_relative '../../db/database'

RSpec.describe Database do
  let(:dummyClass) {Struct.new(:id)}

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
      driver_1.save
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
end