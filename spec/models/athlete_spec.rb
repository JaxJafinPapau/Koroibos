require 'rails_helper'

RSpec.describe Athlete, type: :model do
  describe 'Relationships' do
    it { should have_many(:events).through(:athlete_events)}
  end
end
