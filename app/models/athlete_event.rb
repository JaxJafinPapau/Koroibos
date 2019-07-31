class AthleteEvent < ApplicationRecord
  belongs_to :athlete
  belongs_to :event

  enum medal: [ :na, :bronze, :silver, :gold ]

  def self.event_medalists(event_id)
    if event_id.integer?
      find_by_sql("SELECT athletes.name, athletes.team, athletes.age, athlete_events.medal FROM athlete_events INNER JOIN athletes ON athletes.id = athlete_events.athlete_id WHERE athlete_events.event_id = #{event_id} AND athlete_events.medal != 0;")
    else
      nil
    end
  end
end
