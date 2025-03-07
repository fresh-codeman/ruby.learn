require './spec/spec_helper'

RSpec.describe Rider do
  let(:attrs) {
    {
      id: 'R1',
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
      expect(subject.matches).to be(nil)
    end
  end

  context 'when update matches' do
    let(:matches)  { [build(:driver), build(:driver), build(:driver)] }

    it 'sets the new location' do
      subject.matches = matches
      expect(subject.matches).to be(matches)
    end
  end

  describe '#riding?' do
    it 'returns value is false' do
      expect(subject.riding?).to be false
    end
  end

  describe '#start_riding' do
    it 'sets riding to true' do
      subject.start_riding
      expect(subject.riding?).to be true
    end
  end

  describe '#stop_riding' do
    it 'sets riding to true' do
      subject.start_riding
      subject.stop_riding
      expect(subject.riding?).to be false
    end
  end
end