![](https://img.shields.io/badge/Microverse-blueviolet)

# Capstone Project - Ruby linter

## Game description๐

**This ruby linter** checks for the following errors/warnings:<br>
1. Check for trailing spaces
2. Check for the wrong indentation
3. Check for missing/unexpected tags i.e. '( )', '[ ]', and '{ }'
4. Check missing/unexpected end
5. Check empty line error
6. Check class names for CamelCase format
7. Check module names for CamelCase format
8. Check line length
9. Check space before methods

#### Below you can see good, bad and empty code examples and their test results on the console

Good code passes this test successfully!๐
~~~ruby
# Good Code

class Board
  attr_reader :sets, :grid
  attr_accessor :selections

  def initialize
    @sets = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    @grid = "+---+---+---+\n| 1 | 2 | 3 |\n+---+---+---+\n| 4 | 5 | 6 |\n+---+---+---+\n| 7 | 8 | 9 |\n+---+---+---+"
    @selections = []
  end

  def insert(number, sym)
    @grid[@grid.index(number.to_s)] = sym
  end
end
~~~
Console uotput
<img src="./Images/good_test.PNG" alt="" style="width: 100%;">

Bad code passes this test unsuccessfully!๐
~~~ruby
# Bad Code

class board
  attr_reader :sets, :grid
  attr_accessor :selections
  def initialize   

    @sets = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
      @grid = "+---+---+---+\n| 1 | 2 | 3 |\n+---+---+---+\n| 4 | 5 | 6 |\n+---+---+---+\n| 7 | 8 | 9 |\n+---+---+---+"+ "this line is longer than 120 characters"
    @selections = []]
  end

  def insert(number, sym
    @grid[@grid.index(number.to_s)] = sym
  end
end
end
~~~
Console uotput
<img src="./Images/bad_test.PNG" alt="" style="width: 100%;">

The empty file shows a warning to the user!๐
~~~ruby
# Emty Code








~~~
Console uotput
<img src="./Images/empty_test.PNG" alt="" style="width: 100%;">


## Content

* [Necessary requirements](#necessary-requirements)
* [Getting started](#getting-started)
* [RSpec test Instructions](#rspec-test-instructions)
* [Built With](#built-with)
* [Getting Started](#getting-started)
* [Dependencies](#dependencies)
* [Contributing](#contributing)
* [Acknowledgments](#acknowledgments)
* [Author](#author)
* [License](#license)

## Requirements

- gem install colorize
- gem install bundler

## Getting started
- firstly install all requirements above
- open your terminal
- clone the repository `$ git clone https://github.com/AbdumurodovaZulfizar/ruby-linter.git`
- cd ruby-linter
- open the downloaded repository with your code editor.
- Run the command `$ ruby ./bin/main.rb ./folder/your_file.rb`

For instance, to see run good_code write on terminal :`ruby ./bin/main.rb ./example/good_code.rb` 
## RSpec test Instructions

<ol>
  <li>To test this project install RSpec, for it boot up your terminal and punch in `gem install rspec` to install RSpec.</li>
  <li>`cd` into ruby-linter project directory</li>
  <li>Type `rspec`</li>
</ol>

## Built With

- <code><img height="20" src="https://www.ruby-lang.org/images/header-ruby-logo.png"></code> Ruby Language <br>
- ![Git](https://img.shields.io/badge/-Git-05122A?style=flat&logo=git)&nbsp; Git<br>
- ![GitHub](https://img.shields.io/badge/-GitHub-05122A?style=flat&logo=github)&nbsp; GitHub<br>
- ![Visual Studio Code](https://img.shields.io/badge/-Visual%20Studio%20Code-05122A?style=flat&logo=visual-studio-code&logoColor=007ACC)&nbsp; VScode


## Author

๐ฉ๐ปโ๐ผ **Zulfizar Abdumurodova**

- GitHub: [Abdumurodova Zulfizar](https://github.com/AbdumurodovaZulfizar)
- Twitter: [Abdumurodova Zulfizar](https://twitter.com/Zulfiza70357085)
- LinkedIn: [Abdumurodova Zulfizar](https://www.linkedin.com/in/zulfizar-abdumurodova-a61527206/)


### Dependencies

Ruby 3.0.1

### Contributing

Contributions, issues and feature requests are welcome!

You can do it on [issues page](https://github.com/AbdumurodovaZulfizar/ruby-linter/issues/2).

## Show your support

Give a โญ๏ธ if you like this project!

## Acknowledgments

- [Microverse](https://www.microverse.org/) for international opportunities.
- Special thanks to all code reviewers.

## ๐ License

Copyright 2021 Zulfizar Abdumurodova
- [MIT](https://github.com/AbdumurodovaZulfizar/ruby-linter/blob/build_linter/LICENSE.md) for this project.
