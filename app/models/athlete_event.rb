class AthleteEvent < ApplicationRecord
  belongs_to :athlete
  belongs_to :event

  enum medal: [ :na, :bronze, :silver, :gold ]
end
