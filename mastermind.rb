

class Game

  def initialize
    @board = Board.new
    @player = Player.new
    @letters = Letter.new
    @round_count = -1
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

    @code = (0...4).map {(65 + rand(8)).chr}
    code_uniq = @code.uniq

    until code_uniq == @code
    @code = (0...4).map {(65 + rand(8)).chr}
    code_uniq = @code.uniq
    end

  end



  def place_letters
    letters_placed = 0
    while letters_placed < 4
      puts "Player, please place a letter from A to H in cell #{letters_placed + 1}"
      @player.letter_choice = gets.chomp.upcase
      until self.is_valid_letter?(@player.letter_choice)
          puts "Must be a letter from A to H"
          @player.letter_choice = gets.chomp.upcase
      end
      @board.board_array[@round_count][letters_placed] = @player.letter_choice
      letters_placed += 1
      self.show_board
    end
    self.check_status
  end




  def check_status
    if @code == @board.board_array[@round_count]
      puts "Congratulations, you cracked the code: #{@code}"
    else
      if self.game_over?
        puts "Game Over, the secret code was #{@code}"
        exit
      else
        self.give_clue
        @round_count -= 1
        self.place_letters
      end
    end
  end




  def game_over?
    @round_count == -11 ? true : false
  end




  def is_valid_letter?(letter_choice)
    @letters.letters_arr.include?(letter_choice)
  end




  def give_clue
    clue_array = []
    letter_row = 0
    @code.each do |code_letter|
       if code_letter == @board.board_array[@round_count][letter_row]
         clue_array.unshift("CLCC")
       elsif @board.board_array[@round_count].include?(code_letter)
         clue_array.unshift("CLWC")
       else
         clue_array.unshift("X")
       end

       letter_row += 1
    end
    @board.board_array[@round_count].push(clue_array.sort.join(" "))
    self.show_board
  end




end
#----------------------------------

class Board

  attr_accessor :board_array

  def initialize
    @board_array = [[1,2,3,4],[1,2,3,4],[1,2,3,4],[1,2,3,4],[1,2,3,4],[1,2,3,4],[1,2,3,4],[1,2,3,4],[1,2,3,4],[1,2,3,4],[1,2,3,4]]
  end

end
#--------------------------------------

class Player
  attr_accessor :letter_choice

end
#------------------------------------------

class Computer
end
#---------------------------------------------

class Letter

  def initialize
    @letters_arr = ["A","B","C","D","E","F","G","H"]
  end

  def letters_arr
    @letters_arr
  end

end
#-------------------------------------------------



#---------------------------------------------------------
game = Game.new
