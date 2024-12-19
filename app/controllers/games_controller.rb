require 'nokogiri'
require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a[rand(0..25)] }
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(' ')
    url = "https://dictionary.lewagon.com/#{@word}"
    details = URI.parse(url).read
    word = JSON.parse(details)
    if !eligible?(@word, @letters)
      @result = "Sorry, but '#{@word.capitalize}' cannot be built out of those letters"
    elsif !word['found']
      @result_first_half = "Sorry, but '"
      @result_word = @word.capitalize
      @result_second_half = "' is not a word existing in the English language"
    else
      @result_first_half = "Yes, '"
      @result_word = @word.capitalize
      @result_second_half = "' can be built out of those letters"
    end
  end

  def eligible?(input, letters)
    temp_array = letters.map { |item| item }
    input.chars.each do |letter|
      return false unless temp_array.include?(letter.upcase)

      index = temp_array.find_index(letter.upcase)
      temp_array[index] = 0
    end
    true
  end
end
