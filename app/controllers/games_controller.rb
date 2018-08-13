require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
      10.times do
      @letters << ('A'..'Z').to_a.sample
      end
    @letters
  end

  def score
    @attempt = params[:word]
    @letters = params[:letters]
    if @attempt.upcase!.split('').all? { |l| @attempt.count(l) <= @letters.count(l) } == false
      @answer = "Sorry but #{@attempt} can't be made from #{@letters}"
    elsif
      JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@attempt}").read)["found"] == false
      @answer = "#{@attempt} is not a word"
    else
      @answer = "Congrats #{@attempt} is a word!"
    end
  end
end
