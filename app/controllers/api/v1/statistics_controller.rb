class Api::V1::StatisticsController < ApplicationController
    def index
        olympian_count = Athlete.total_olympians
        mean_weight_males = Athlete.mean_weight_males
        mean_weight_females = Athlete.mean_weight_females
        mean_age = Athlete.mean_age
        serialized_response = OlympianStatsSerializer.new(
            olympian_count,
            mean_weight_males,
            mean_weight_females,
            mean_age
        )
        render status: 200, json: serialized_response.serialize
    end
end