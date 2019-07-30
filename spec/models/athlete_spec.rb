require 'rails_helper'

RSpec.describe Athlete, type: :model do
  describe 'Relationships' do
    it { should have_many(:events).through(:athlete_events)}
  end

  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_uniqueness_of :name}
  end
end
