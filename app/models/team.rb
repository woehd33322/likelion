class Team < ActiveRecord::Base
  has_many :UserTeams
end
