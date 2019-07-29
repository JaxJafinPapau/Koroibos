require 'csv'

namespace :import_from_csv do
  desc "TODO"
  task all_data: :environment do
    CSV.foreach('./db/data/olympic_games.csv', headers: true) do |row|
      raw_athlete = row.to_h
      #import athlete
      begin
        saved_athlete = Athlete.find_by(name: raw_athlete['Name'])
        if !saved_athlete
          saved_athlete = Athlete.create(
          name: raw_athlete['Name'],
          sex: raw_athlete['Sex'],
          age: raw_athlete['Age'],
          height: raw_athlete['Height'],
          weight: raw_athlete['Weight'],
          team: raw_athlete['Team'],
          games: raw_athlete['Games'],
          sport: raw_athlete['Sport'],
          )
        end
      rescue
        puts "Athlete find or creation failed!"
      end

      #import event
      begin
        event = Event.find_by(name: raw_athlete['Event'])
        if event
          saved_athlete.events << event
        else
          event = saved_athlete.events.create(name: raw_athlete['Event'])
        end
      rescue
        puts "Event saving failed!"
      end

      # add medals to athlete_events joins table
      athlete_event = AthleteEvent.find_by(athlete_id: saved_athlete.id, event_id: event.id)
      enum_hash = {
        na: 0,
        bronze: 1,
        silver: 2,
        gold: 3
      }
      medal_value = enum_hash[raw_athlete['Medal'].downcase.to_sym]
      athlete_event.update(medal: medal_value)
    end
  end

end
