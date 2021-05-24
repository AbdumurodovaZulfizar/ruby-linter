#!/usr/bin/env ruby
require_relative '../lib/file_tester'

check = TestFile.new(ARGV.first)
check.check_indentation
check.check_spaces
check.tag_error
check.end_error
check.empty_line_error
check.check_camelcase_class
check.check_camelcase_module
check.line_length
check.space_methods

if check.errors.empty?
  puts "\n\nNo offenses detected".upcase.colorize(:green)

else
  check.errors.uniq.each do |error|
    puts "#{check.file.file_path.colorize(:green)} : #{error.colorize(:red)}"
  end
  puts "#{check.line_number} lines of code inspected
#{check.errors_number} offenses detected"
end
