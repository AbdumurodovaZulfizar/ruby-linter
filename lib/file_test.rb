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

  def check_spaces
    @lines.each_with_index do |ele, idx|
      if ele[-2] == ' ' && !ele.strip.empty?
        @errors << "line:#{idx + 1}:#{ele.size - 1}: Error: Trailing whitespace detected."
      end
      @errors_number += 1
    end
  end
end