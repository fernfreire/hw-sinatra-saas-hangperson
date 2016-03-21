class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(new_word)
    @word = new_word.downcase
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = '-' * new_word.length
  end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def check_win_or_lose
    if @wrong_guesses.length == 7
      return :lose
    else
      if @word_with_guesses.count('-') == 0
        return :win
      else
        return :play
      end
    end
  end
  
  def word_with_guesses
    @word_with_guesses
  end
  
  def change_word_with_guesses(letter)
    for i in 0..(@word.length - 1)
      if @word[i] == letter
        @word_with_guesses[i] = letter
      end
    end
  end
    #@word.split('').each {|l, i| if l == letter then @word_with_guesses(i) = letter end}
  
  def guess(letter)
    if letter == nil
      raise ArgumentError.new('It should be a letter a-z or A-Z')
    end
    letter = letter.downcase
    if letter.match(/^[a-z]$/) == nil
      raise ArgumentError.new('It should be a letter a-z or A-Z')
    else
      if @word.count(letter) > 0
        if @guesses.count(letter) == 0 
          @guesses << letter
          change_word_with_guesses(letter)
        else
          return false
        end
      else
        if @wrong_guesses.count(letter) == 0
          @wrong_guesses << letter
        else
          return false
        end
      end
      
      return true
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
end
