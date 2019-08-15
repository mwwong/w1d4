require "byebug"
require_relative "board"
require 'colorize'

puts "Only contractors write code this bad.".yellow

class SudokuGame
  def self.from_file(filename)
    board = Board.from_file(filename)
    self.new(board)
  end

  def initialize(board)
    debugger
    @board = board
  end

  def method_missing(method_name, *args)
    debugger
    if method_name =~ /val/
      debugger
      Integer(1)
    else
      debugger
      string = args[0]
      debugger
      string.split(",").map! { |char| Integer(char)}
      debugger
    end
  end

  def get_pos
    pos = nil
    until pos && valid_pos?(pos)
      puts "Please enter a position on the board (e.g., '3,4')"
      print "> "

      begin
        debugger
        pos = parse_pos(gets.chomp)
     #  pos = pos.split(",").map { | ele| Integer(ele) }
      rescue
        debugger
        TODO: Google how to print the error that happened inside of a rescue statement.
       puts "Invalid position entered (did you use a comma?)"
       puts ""

       pos = nil
     end
    end
    pos
  end

  def get_val
    val = nil
    until val && valid_val?(val)
      puts "Please enter a value between 1 and 9 (0 to clear the tile)"
      print "> "
      val = parse_val(gets.chomp)
    end
    val
  end

  def play_turn
    board.render
    pos = get_pos
    val = get_val
    board[pos] = val
  end

  def run
    debugger
    play_turn until solved?
    board.render
    puts "Congratulations, you win!"
  end

  def solved?
   # debugger
    board.solved?
  end

  def valid_pos?(pos)
    pos.is_a?(Array) &&
      pos.length == 2 &&
      pos.all? { |x| x.between?(0, board.size - 1) }
  end

  def valid_val?(val)
    val.is_a?(Integer) &&
      val.between?(0, 9)
  end

  private
  attr_reader :board
end


game = SudokuGame.from_file("puzzles/sudoku1.txt")
game.run 