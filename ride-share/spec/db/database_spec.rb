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
    let(:driver_1) {dummyClass.new(Faker::Internet.uuid) }
    it 'set the data for instances of base class' do
      expect(driver_1.save).to be true
      expect(dummyClass.get(driver_1.id)).to eq(driver_1)
    end
  end

  describe '#get' do
    let(:driver_1) {dummyClass.new(Faker::Internet.uuid, 'created') }
    let(:driver_2) {dummyClass.new(Faker::Internet.uuid, 'dispatched') }
    let(:driver_3 ) { dummyClass.new(Faker::Internet.uuid) }

    before {driver_1.save; driver_2.save; driver_3.save}

    it 'get the all the instances of base class' do
      expect(dummyClass.get).to contain_exactly(driver_1,driver_2, driver_3)
    end

    context 'when only id is provided' do
      it 'get the instance with provided id' do
        expect(dummyClass.get(driver_1.id)).to be(driver_1)
      end

      it 'get the nil if id invalid' do
        expect(dummyClass.get('invalid')).to be_nil
      end
    end

    context 'when only block is provided' do
      it 'get all the instances those follow condition' do
        expect(dummyClass.get{ |obj| obj.status == 'created'}.count).to eq(1)
        expect(dummyClass.get{ |obj| obj.status != 'created'}.count).to eq(2)
      end
    end

    context 'when block and id both provided' do
      it 'get the instance of provided id if it follow condition' do
        expect(dummyClass.get(driver_1.id){|obj| obj.status =='created'}).to be(driver_1)
      end

      it 'returns nil for invalid id' do
        expect(dummyClass.get('invalid'){|obj| obj.status =='created'}).to be nil
      end

      it 'returns nil if block condition not met for valid id' do
        expect(dummyClass.get(driver_2.id){|obj| obj.status == 'created'}).to be nil
      end
    end
  end

  describe '#count' do
    let(:driver_1) {dummyClass.new(Faker::Internet.uuid) }
    let(:driver_2) {dummyClass.new(Faker::Internet.uuid) }
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
    let(:driver_1) {dummyClass.new(Faker::Internet.uuid) }
    let(:driver_2) {dummyClass.new(Faker::Internet.uuid) }
    before {driver_1.save; driver_2.save}
    it 'resets the to empty array' do
      dummyClass.reset_database
      expect(dummyClass.get).to eq([])
    end
  end
end