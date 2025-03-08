require './spec/spec_helper'

RSpec.describe Driver do
  let(:attrs) {
    {
      id: 'D1',
      location: build(:location)
    }
  }
  subject {described_class.new(attrs)}

  describe '#post_initialize' do
    it 'create new location' do
      expect(subject).to be_a(described_class)
    end
    
    it 'set the attributes' do
      expect(subject.id).to be(attrs[:id])
      expect(subject.location).to be(attrs[:location])
    end
  end

  describe '#driving?' do
    it 'returns value is false' do
      expect(subject.driving?).to be false
    end
  end

  describe '#start_driving' do
    it 'sets driving to true' do
      subject.start_driving
      expect(subject.driving?).to be true
    end
  end

  describe '#stop_driving' do
    it 'sets driving to true' do
      subject.start_driving
      subject.stop_driving
      expect(subject.driving?).to be false
    end
  end
end