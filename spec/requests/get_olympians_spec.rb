require 'rails_helper'

describe "GET api/v1/olympians" do
    it 'should return all the athletes in the specified format' do
        create_list(:athlete, 5)

        create_list(:event, 4)

        winner = Athlete.first
        winner.events << Event.first; winner.events << Event.second
        loser_1 = Athlete.second
        loser_1.events << Event.second; loser_1.events << Event.third
        loser_2 = Athlete.third
        loser_2.events << Event.second; loser_2.events << Event.third
        loser_3 = Athlete.fourth
        loser_3.events << Event.second; loser_3.events << Event.third
        loser_4 = Athlete.fifth
        loser_4.events << Event.second; loser_4.events << Event.third

        winner.athlete_events.first.update(medal: 1)

        get '/api/v1/olympians'

        expect(response.status).to eq(200)

        olympians = JSON.parse(response.body)
        medalist = olympians['olympians'].find do |o|
            o["total_medals"] == 1
        end

        expect(olympians).to be_a(Hash)
        expect(olympians['olympians'].count).to eq(5)
        expect(medalist['id']).to eq(winner.id)
        expect(olympians['olympians'].second['total_medals']).to be_a(Integer)
        expect(olympians['olympians'].third['total_medals']).to be_a(Integer)
        expect(olympians['olympians'].sample['sport']).to eq('Underwater Basket Weaving')
    end

    #sad path
    
    it 'should return 404 with proper error with no athletes' do
        get '/api/v1/olympians'
        
        error = JSON.parse(response.body)

        expect(error['error']).to eq("No Olympians found.")
    end
end