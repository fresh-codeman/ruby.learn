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
end