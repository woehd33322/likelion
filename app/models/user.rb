class User < ActiveRecord::Base
  has_many :UserTeams
end
