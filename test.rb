class Player
  attr_accessor :letter_choice

  def is_letter?
    if @letters.letters_arr.any? {|letter| self.letter_choice != letter}
      return false
    else
      true
    end
  end



  class Letter

    def initialize
      @letters_arr = ["A","B","C","D","E","F","G","H"]
    end

    def letters_arr
      @letters_arr
  end



  
