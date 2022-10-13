# GAMES CONTROLLER
class GamesController < ApplicationController

  def home; end

  def new
    # @letters = [generate random]
    @letters = %w(W A L N M O R T A) # test
  end

  def score
    raise
  end
end
