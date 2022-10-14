require 'open-uri'

# GAMES CONTROLLER
class GamesController < ApplicationController
  def home; end

  def new
    # @letters = (0...9).map { ('A'..'Z').to_a[rand(26)] }
    @letters = []
    (1..9).to_a.each { @letters << ('A'..'Z').to_a[rand(26)] }
    @start_time = Time.current
  end

  def score
    # raise
    @time_taken = params[:time_taken].to_i
    @letters = params[:letters].split(' ')
    @attempt = params[:word]
    @attempt_chars = @attempt.upcase.chars
    @unused_letters = @letters.size - @attempt_chars.size
    @used_correct_instances = @attempt_chars.none? { |char| @attempt_chars.count(char) > @letters.count(char) }
    @included_in_letters = @attempt_chars.all? { |char| @letters.include? char }
    @included_in_letters & @used_correct_instances ? @in_grid = true : @game_lost = true
    @dict_return_hash = JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{@attempt}").read)
    @game_lost = true unless @dict_return_hash['found']
    @score = @game_lost ? 0 : @attempt.size - (@time_taken.to_i * 0.05)
    @lost_message = @in_grid ? 'Not an English word' : 'Not in the grid'
    @results = { time: @time_taken, score: @score, message: @game_lost ? @lost_message : 'Well Done!' }
  end
end
