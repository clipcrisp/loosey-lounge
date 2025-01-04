#!/usr/bin/env fish

cc $argv[1..-1] -MJ main.o.json -L/opt/homebrew/lib/ -I/opt/homebrew/include/ -std=c23 -Wall -lm -lraylib -o test.out 
sed -e '1s/^/[\n/' -e '$s/,$/\n]/' *.o.json > compile_commands.json
rm *.o.json
