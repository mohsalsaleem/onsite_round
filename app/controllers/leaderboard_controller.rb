

class LeaderboardController < ApplicationController
  before_action :authenticate_admin!

  def index
	@leaderboard = Leaderboard.order("score DESC")
  end
end
