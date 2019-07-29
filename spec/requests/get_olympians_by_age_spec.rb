require 'rails_helper'

describe "GET api/v1/olympians" do
    it 'should return all the athletes in the specified format' do
        create(:athlete, age: 3)
        create(:athlete, age: 4)
        create(:athlete, age: 96)

        create_list(:event, 4)

        winner = Athlete.where(age: 3).first
        winner.events << Event.first
        winner.events << Event.second

        AthleteEvent.first.update(medal: 1)

        get '/api/v1/olympians?age=youngest'

        expect(response.status).to eq(200)

        olympian = JSON.parse(response.body)
        
        expect(olympian).to be_a(Hash)
        expect(olypmian['olympian'].first['id']).to eq(winner.id)
        expect(olympian['olympian'].first['age']).to eq(3)
        expect(olympian['olympian'].first['sport']).to eq('Underwater Basket Weaving')
    end

    #sad path
    
    it 'should return 404 with proper error with no athletes' do
        get '/api/v1/olympians'
        
        error = JSON.parse(response.body)

        expect(error['error']).to eq("No Olympians found.")
    end
end