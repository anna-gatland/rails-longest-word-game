require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.shuffle.first(10)
  end

  def score
    @word = params[:word]
    @letters = params['letters'].split(" ")
    if word_exist?(@word)
      @word_is_ok = included_letter?(@word, @letters)
    else
      @word_is_ok = false
    end
  end

  private

  def included_letter?(word, letters)
    @word.chars.all? { |letter| word.count(letter) <= @letters.count(letter) }
  end

  def word_exist?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    raw_response = URI.open(url).read
    dictionary_response = JSON.parse(raw_response)
    dictionary_response["found"]
  end
end
