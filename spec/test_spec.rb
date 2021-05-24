require_relative '../lib/file_tester'
require_relative 'spec_helper'

RSpec.describe TestFile do
  let(:checker) { TestFile.new('../ruby-linter/example/bad_code.rb') }

  describe '#check_spaces' do
    it 'should return trailing space error' do
      checker.check_spaces
      expect(checker.errors[0]).to eql('line:5:19: Error: Trailing whitespace detected.')
    end
  end

  describe '#check_indentation' do
    it 'should return indentation errors' do
      checker.check_indentation
      expect(checker.errors[0]).to eql('line:8 IndentationWidth: Use 2 spaces for indentation.')
    end
  end

  describe '#tag_error' do
    it 'should return tag errors' do
      checker.tag_error
      expect(checker.errors[0]).to eql("line:12 Lint/Syntax: Unexpected/Missing token ')' Parenthesis")
    end
  end

  describe '#check_end_empty_line' do
    it 'should return end errors' do
      checker.empty_line_error
      expect(checker.errors[0]).to eql('line:6 Extra empty line detected at method body beginning')
    end
  end

  describe '#end_error' do
    it 'should return end errors' do
      checker.end_error
      expect(checker.errors[0]).to eql("Lint/Syntax: Unexpected 'end'")
    end
  end

  describe '#empty_line_error' do
    it 'should return empty line errors' do
      checker.empty_line_error
      expect(checker.errors[0]).to eql('line:6 Extra empty line detected at method body beginning')
    end
  end

  describe '#check_camelcase_class' do
    it 'should return CamelCase format errors' do
      checker.check_camelcase_class
      expect(checker.errors[0]).to eql('line:2 Use CamelCase after class keyword')
    end
  end

  describe '#check_camelcase_module' do
    it 'should return CamelCase format errors' do
      checker.check_camelcase_module
      expect(checker.errors[0]).to eql(nil)
    end
  end

  describe '#line_length' do
    it 'should return long line error' do
      checker.line_length
      expect(checker.errors[0]).to eql('line:8 Line is too long. [163/120]')
    end
  end
  describe '#space_methods' do
    it 'should return space error before method' do
      checker.space_methods
      expect(checker.errors[0]).to eql('line:5 Expected empty line before def keyword')
    end
  end
end