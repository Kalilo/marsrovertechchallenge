# Mars Rover Challenge

This is a ruby terminal program, that completes Google's Mars Rover Challenge

The challenge details can be found here:
`https://code.google.com/archive/p/marsrovertechchallenge/`

The application was written using ruby 2.6, although it should work for most ruby 2.x versions

## Assumptions

* The program will read any amount of rovers from the provided input,
although it does assume that rovers cannot occupy the same coordinates,
thus rovers can not bump into each other, or load on top of each other.

* A valid map is at least of a size 2x2, and has no specified max size.
This program should be able to handle massive maps, although it has not been intended for such, nor tested for such.

* Because the map has a starting position of (0, 0), negative coordinates don't fall on the map.

* Rovers can not travel out of bounds

## Dependancies

Install dependancies by running:
```
bundle
```

## Usage

The program's entry point is `mars_rover.rb`

To see all usage options run `ruby mars_rover.rb --help`
```
Usage: ruby mars_rover.rb -f <input_file>
    -h, --help                       Prints this help
    -f, --file=FILENAME              Set the file name
    -v, --[no-]verbose               Run verbosely
    -m, --[no-]map                   Print map at begining and end
```

A test file has been provided in the input folder

## Test

The programs core functionality files have automated tests

`run_tests.rb` will execute all test in the `tests` folder

To run the tests use: `ruby run_tests.rb`

example output:
```
Run options: --seed 13823

# Running:

.....................

Finished in 0.004672s, 4494.8628 runs/s, 32748.2864 assertions/s.
21 runs, 153 assertions, 0 failures, 0 errors, 0 skips
```

## The Code

The code has been written with two distinct use cases in mind. Some of the files have been
created with the intention of using them as library functions, where as the rest of the files
have been created with the intension of having extended features.

The Library functions have the most extensive test coverage, as they are expected to have to
behave in unintended usage. The IO managers have the worst test coverage as I was battling to
decide on how to appropriately test them, and thus manually tested them rather than
automatically.

The program file was written in such a way as to add on an interactive mode, although I eventually
decided that it would make the program too different from the requirements.
