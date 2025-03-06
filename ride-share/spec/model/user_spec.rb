require_relative '../../model/user'

RSpec.describe User do
  let(:attrs) {
    {
      id: 'R1',
      location: build(:location)
    }
  }
  subject {described_class.new(attrs)}
  describe '#initialize' do
    it 'create new location' do
      expect(subject).to be_a(described_class)
    end
    
    it 'set the attributes' do
      expect(subject.id).to be(attrs[:id])
      expect(subject.location).to be(attrs[:location])
    end
  end

  context 'when update location' do
    let(:new_location)  {build(:location, x_coordinate: 10) }

    it 'sets the new location' do
      subject.location = new_location
      subject.save
      expect(subject.location).to be(new_location)
    end
  end
end