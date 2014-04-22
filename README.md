Protobuf Guy
============

Simple command line tool to translate protobuf messages into code. One goal of the script is plattform independency, so you can use it either on OSX, Windows or Linux. 

The script is written in Ruby with some requirements.

## Requirements

The tool is only tested with Ruby 1.9 on Windows 8 and Ubuntu 13.10. More environments will be tested in the future and reported in the tested secion below.
 
## Installation

To install protobuf please refer the install guide in the protobuf directory. Usually you only need to add `protoc` to your path.

## Usage

You can run the following command from command line.

```BASH
# Unix
./protobuf-guy.rb -i tests -o tests/
# Windows
ruby protobuf-guy.rb -i tests -o tests/
```

The script creates four subdirectories in the `tests` directory and the translations for the supported languages. In the root of the output folder is a map `MessageTypes.txt` with in csv syntax, that contains all discovered proto messages and an index per message. This is useful because the protobuf messages aren't self identifying.

```CSV
0,Test
1,Test.InnerTest
2,Test.InnerTest2
3,Test.InnerTest.InnerInnerTest
```

To create nested messages in the MessagesTypes list, you must use the convention of `two spaces` as indentation for every nesting level.

## Tested

The script was currently tested with following configurations:

 * Ubuntu 13.10, Ruby 1.9: C++, Java, Python
 * Windows 8, Ruby 1.9: C++, Java, Python, C#

## TODO

 * improve documentation
 * refactor some methods and use classes
 * all classes should be in one folder, if possible in one file
 * check input and output paths before (trailing slashes)
