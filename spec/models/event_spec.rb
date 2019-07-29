require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Relationships' do
    it { should have_many(:athletes).through(:athlete_events)}
  end
end
