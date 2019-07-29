require 'rails_helper'

RSpec.describe Athlete, type: :model do
  describe 'Relationships' do
    it { should have_many(:events).through(:athlete_events)}
  end

  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_uniqueness_of :name}
  end

  describe 'Instance Methods' do
    it '.medal_count' do
      create_list(:athlete, 2)
      create_list(:event, 3)

      winner = Athlete.first
      loser = Athlete.second
      winner.events << Event.first
      winner.events << Event.second
      loser.events << Event.third
      winner.athlete_events.first.update(medal: 1)

      expect(winner.medal_count).to eq(1)
      expect(loser.medal_count).to eq(0)
    end
  end
end
