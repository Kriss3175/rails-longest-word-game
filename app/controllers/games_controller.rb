require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = [*('A'..'Z')].sample(10).join
  end

  def score
    @letters = params[:letters].split
    @word = (params [:word] || "").upcase
    @include = include_or_not?(@word, @letters)
    english_word = english_word?(word)
  end

 private
  def include_or_not(answer, letters)
    answer.split("").each do |letter|
    letters.include? letter
    end
  end
  def english_word?(answer)
    response = open("https://wagon-dictionary.herokuapp.com/#{answer.downcase}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
