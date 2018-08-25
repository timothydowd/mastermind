

class Game

  def initialize
    @board = Board.new
    @player = Player.new
    @letters = Letter.new
    @round_count = -1
    self.game_start
  end


  def game_start
    self.choose_game
    if @player.player_stance == 1
      self.computer_plays
    elsif @player.player_stance == 2
      self.player_plays
    else
      puts "Invalid input"
      self.game_start
    end
  end

  def computer_plays
    self.player_choose_code
    @computer = Computer.new
    self.show_board
    self.computer_place_letters
  end

  def computer_place_letters
    @computer.letter_choice = self.gen_code
    @board.board_array[@round_count] = @computer.letter_choice
    self.show_board
    self.check_status_comp

  end

  def check_status_comp
    if @player.code_choice == @board.board_array[@round_count]
      puts "\n"
      puts "Computer cracked the code: #{@player.code_choice.join(" ")}"
    else
      if self.game_over?
        puts "\n"
        puts "Computer couldn't crack the code. Game Over}"
        exit
      else
        self.give_clue_computer
        @round_count -= 1
        self.computer_place_letters
      end
    end
  end

  def give_clue_computer
    clue_array = []
    letter_row = 0
    @clcc_hash = Hash.new
    @clwc_hash = Hash.new
    @board.board_array[@round_count].each do |comp_letter|
        if comp_letter == @player.code_choice[letter_row]
         clue_array.push("CLCC")
         @clcc_hash[letter_row] = comp_letter
     elsif @player.code_choice.include?(comp_letter)
         clue_array.push("CLWC")
         @clwc_hash[letter_row] = comp_letter
       else
         clue_array.push("X")
       end
       letter_row += 1
    end
    @board.board_array[@round_count].push(clue_array.join(" "))
    puts "\n"
  end


  def gen_code
    @code = (0...4).map {(65 + rand(8)).chr}

    unless @clwc_hash.nil?
      @clwc_hash.each do |clwc, letter|
        @code.each_with_index do |gen_letter, index|
          if index != clwc
            @code[index] = letter
            break

          end
        end
      end
    end

    unless @clcc_hash.nil?
      @clcc_hash.each{|clcc, letter| @code[clcc] = letter}
    end

    code_uniq = @code.uniq

    until code_uniq == @code
    @code = (0...4).map {(65 + rand(8)).chr}

    unless @clwc_hash.nil?
      @clwc_hash.each do |clwc, letter|
        @code.each_with_index do |gen_letter, index|
          if index != clwc
            @code[index] = letter
            break
          end
        end
      end
    end

      unless @clcc_hash.nil?
        @clcc_hash.each{|clcc, letter| @code[clcc] = letter}
      end
    code_uniq = @code.uniq
    end
    @code
  end


  def place_letters
    letters_placed = 0
    while letters_placed < 4
      puts "\n"
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

  def rules
    puts "The aim of mastermind is to guess the secret code by placing the correct letter in the correct column."
    puts "Along the way you will be given hints as to how close your guess is to cracking the code."
    puts "CLCW stand for correct letter in correct column, CLCC stands for correct letter in correct column.  X's mean the letter does not exist in the secret code."
    puts "\n"
  end


  def player_plays
    self.rules
    self.show_board
    self.gen_code
    self.place_letters
  end


  def player_choose_code
    puts "Please enter a 4 letter secret code using letters A to H:"
    @player.code_choice = gets.chomp.upcase.split("")

    while self.is_valid_code?(@player.code_choice) == false
      puts "Invalid code, please enter a 4 letter secret code using only A to H and without duplicates:"
      @player.code_choice = gets.chomp.upcase.split("")
    end
  end


  def is_valid_code?(code_choice)
    code_uniq = code_choice.uniq
    if code_uniq != code_choice
      return false
    elsif code_choice.length != 4
      return false
    else
      code_choice.each do |code_letter|
        if @letters.letters_arr.include?(code_letter) == false
          return false
        end
      end
    end
  end


  def is_valid_letter?(letter_choice)
    @letters.letters_arr.include?(letter_choice)
  end


  def show_board
    puts "\n"
    @board.board_array.each {|row| puts row.join(" ")}
  end


  def choose_game
    puts "Please type 1 to be the codemaster or 2 to be the codebreaker"
    @player.player_stance = gets.chomp.to_i
    puts "\n"
  end



  def check_status
    if @code == @board.board_array[@round_count]
      puts "\n"
      puts "Congratulations, you cracked the code: #{@code.join(" ")}"
    else
      if self.game_over?
        puts "\n"
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
    puts "\n"
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
  attr_accessor :letter_choice, :player_stance, :code_choice

end
#------------------------------------------

class Computer
  attr_accessor :letter_choice
  def initialize
    puts "computer obj created"
  end
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
