class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a[rand(1..10)] }
  end

  def score
  end
end
