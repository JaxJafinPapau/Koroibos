class OlympianStatsSerializer
   def initialize(olympian_count, mean_weight_males, mean_weight_females, mean_age)
    @olympian_count = olympian_count
    @mean_weight_males = mean_weight_males
    @mean_weight_females = mean_weight_females
    @mean_age = mean_age
   end

   def serialize
    { olympian_stats: {
      total_competing_olympians: @olympian_count,
      average_weight: {
        unit: "kg",
        male_olympians: @mean_weight_males,
        female_olympians: @mean_weight_females
        },
        average_age: @mean_age
      }
    }
   end
end