require 'colorize'
require 'strscan'
require_relative './file_reader'
class TestFile
  attr_reader :file, :lines, :line_number, :errors, :errors_number

  def initialize(file_path)
    @file_path = file_path
    @file = FileReader.new(file_path)
    @lines = @file.lines
    @line_number = @file.line_number
    @errors = []
    @keywords = %w[begin case class def do if module unless]
    @errors_number = 0
  end

  def check_spaces
    @lines.each_with_index do |ele, idx|
      if ele[-2] == ' ' && !ele.strip.empty?
        @errors << "line:#{idx + 1}:#{ele.size - 1}: Error: Trailing whitespace detected."
      end
      @errors_number += 1
    end
  end

  def tag_error
    check_tag(/\(/, /\)/, '(', ')', 'Parenthesis')
    check_tag(/\[/, /\]/, '[', ']', 'Square Bracket')
    check_tag(/\{/, /\}/, '{', '}', 'Curly Bracket')
  end

  def check_tag(*args)
    @lines.each_with_index do |ele, index|
      open_p = []
      close_p = []
      open_p << ele.scan(args[0])
      close_p << ele.scan(args[1])

      status = open_p.flatten.size <=> close_p.flatten.size

      log_error("line:#{index + 1} Lint/Syntax: Unexpected/Missing token '#{args[3]}' #{args[4]}") if status.eql?(1)
      log_error("line:#{index + 1} Lint/Syntax: Unexpected/Missing token '#{args[2]}' #{args[4]}") if status.eql?(-1)
    end
  end

  def empty_line_error
    @lines.each_with_index do |ele, idx|
      check_class_empty_line(ele, idx)
      check_def_empty_line(ele, idx)
      check_end_empty_line(ele, idx)
      check_do_empty_line(ele, idx)
    end
  end

  def check_class_empty_line(ele, idx)
    mesg = 'Extra empty line detected at class body beginning'
    return unless ele.strip.split.first.eql?('class')

    log_error("line:#{idx + 2} #{mesg}") if @lines[idx + 1].strip.empty?
  end

  def check_def_empty_line(ele, idx)
    mesg1 = 'Extra empty line detected at method body beginning'
    mesg2 = 'Use empty lines between method definition'

    return unless ele.strip.split.first.eql?('def')

    log_error("line:#{idx + 2} #{mesg1}") if @lines[idx + 1].strip.empty?
    log_error("line:#{idx + 1} #{mesg2}") if @lines[idx - 1].strip.split.first.eql?('end')
  end

  def check_end_empty_line(ele, idx)
    mesg = 'Extra empty line detected at block body end'
    return unless ele.strip.split.first.eql?('end')

    log_error("line:#{idx} #{mesg}") if @lines[idx - 1].strip.empty?
  end

  def check_do_empty_line(ele, idx)
    mesg = 'Extra empty line detected at block body beginning'
    return unless ele.strip.split.include?('do')

    log_error("line:#{idx + 2} #{mesg}") if @lines[idx + 1].strip.empty?
  end

  def end_error
    keyw_count = 0
    end_count = 0
    @lines.each do |ele|
      keyw_count += 1 if @keywords.include?(ele.split.first) || ele.split.include?('do')
      end_count += 1 if ele.strip == 'end'
    end

    status = keyw_count <=> end_count
    log_error("Lint/Syntax: Missing 'end'") if status.eql?(1)
    log_error("Lint/Syntax: Unexpected 'end'") if status.eql?(-1)
  end
  # rubocop:disable Metrics/CyclomaticComplexity

  def check_indentation
    mesg = 'IndentationWidth: Use 2 spaces for indentation.'
    cur_val = 0
    indent_val = 0

    @lines.each_with_index do |ele, idx|
      strip_line = ele.strip.split
      exp_ele = cur_val * 2
      res_word = %w[class def if elsif until module unless begin case while]

      next unless !ele.strip.empty? || !strip_line.first.eql?('#')

      indent_val += 1 if res_word.include?(strip_line.first) || strip_line.include?('do')
      indent_val -= 1 if ele.strip == 'end'

      next if ele.strip.empty?

      indent_error(ele, idx, exp_ele, mesg)
      cur_val = indent_val
    end
  end

  # rubocop:enable Metrics/CyclomaticComplexity

  def indent_error(ele, idx, exp_ele, mesg)
    strip_line = ele.strip.split
    emp = ele.match(/^\s*\s*/)
    end_chk = emp[0].size.eql?(exp_ele.zero? ? 0 : exp_ele - 2)

    if ele.strip.eql?('end') || strip_line.first == 'elsif' || strip_line.first == 'when'
      log_error("line:#{idx + 1} #{mesg}") unless end_chk
    elsif !emp[0].size.eql?(exp_ele)
      log_error("line:#{idx + 1} #{mesg}")
    end
  end

  def check_camelcase_class
    @lines.each_with_index do |line, line_num|
      next unless line.match(/class\b/) && !line.match(/\b[A-Z]/)

      message_error = "line:#{line_num + 1} Use CamelCase after class keyword"
      @errors << message_error
      @errors_number += 1
    end
  end

  def check_camelcase_module
    @lines.each_with_index do |line, line_num|
      next unless line.match(/module\b/) && !line.match(/\b[A-Z]/)

      message_error = "line:#{line_num + 1} Use CamelCase after module keyword"
      @errors << message_error
      @errors_number += 1
    end
  end

  def line_length
    @lines.each_with_index do |line, line_num|
      next unless line.length > 120

      message_error = "line:#{line_num + 1} Line is too long. [#{line.length}/120]"
      @errors << message_error
      @errors_number += 1
    end
  end

  def space_methods
    @lines.each_with_index do |line, line_num|
      next unless line.match(/def\b/) && !@lines[line_num - 1].strip.empty?

      message_error = "line:#{line_num + 1} Expected empty line before def keyword"
      @errors << message_error
      @errors_number += 1
    end
  end

  def log_error(error_mesg)
    @errors << error_mesg
    @errors_number += 1
  end
end
