require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    # session[:score] = 0
    word = params["word"]
    letters_array = params["letters_array"].split

    if grid_include?(word, letters_array) == false
      @message = "Sorry, but #{word} can't be built out of #{letters_array.join}"
    elsif english_word?(word) == false
      @message = "Sorry, but #{word} does not seem to be a valid English word..."
    else
      @message = "Congratulations! #{word.capitalize} is a valid English word!"
      # @score_message = "Your score is #{score}."
    end
  end



  private

  def grid_include?(word, letters_array)
    word.chars.all? { |letter| word.count(letter) <= letters_array.count(letter.upcase) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end


end
