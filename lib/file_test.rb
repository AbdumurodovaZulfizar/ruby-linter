require 'colorize'
require 'strscan'

class TestFile
  attr_reader :file, :lines, :line_number, :errors, :errors_number

  def initialize(file_path)
    @file_path = file_path
    @file = FileReader.new(file_path)
    @lines = @file.lines
    @line_number = @file.line_number
    @errors = []
    @errors_number = 0
    @keywords = %w[begin case class def do if module unless]
  end
end