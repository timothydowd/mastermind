

class Game

  def initialize
    @board = Board.new
    @player = Player.new
    @letters = Letter.new
    self.game_start
  end

  def game_start
    self.show_board
    self.gen_code
    self.place_letters
  end

  def show_board
    @board.board_array.each {|row| puts row.join(" ")}
  end

  def gen_code
    @code = (0...8).map {(65 + rand(8)).chr}
  end

  def place_letters
    puts "Player, please place a letter from A to H in cell 1"
    @player.letter_choice = gets.chomp.upcase

  while @player.is_letter?
    #if @letters.letters_arr.any? {|letter| @player.letter_choice != letter}
      puts "Must be a letter from A to H"
      @player.letter_choice = gets.chomp.upcase
    #else
  end
    puts "valid letter"

    puts @player.letter_choice
  end


end


class Board

  attr_accessor :board_array

  def initialize
    @board_array = [[1,2,3,4],[1,2,3,4],[1,2,3,4],[1,2,3,4],[1,2,3,4],[1,2,3,4],[1,2,3,4],[1,2,3,4],[1,2,3,4],[1,2,3,4],[1,2,3,4]]
  end

end


class Player
  attr_accessor :letter_choice

  def is_letter?
    if @letters.letters_arr.any? {|letter| self.letter_choice != letter}
      return false
    else
      true
    end
  end


end


class Computer
end


class Letter

  def initialize
    @letters_arr = ["A","B","C","D","E","F","G","H"]
  end

  def letters_arr
    @letters_arr
  end




end


class ClueGiver
end

game = Game.new
