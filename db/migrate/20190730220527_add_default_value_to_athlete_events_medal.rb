class AddDefaultValueToAthleteEventsMedal < ActiveRecord::Migration[5.2]
  def change
    change_column :athlete_events, :medal, :integer, :default => "na"
  end
end
