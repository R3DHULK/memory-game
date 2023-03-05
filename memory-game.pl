#!/usr/bin/perl

use strict;
use warnings;

# initialize game board
my @cards = (
    ["1", "2", "3", "4"],
    ["5", "6", "7", "8"],
    ["1", "2", "3", "4"],
    ["5", "6", "7", "8"]
);

my @board = (
    [" ", " ", " ", " "],
    [" ", " ", " ", " "],
    [" ", " ", " ", " "],
    [" ", " ", " ", " "]
);

my $num_pairs = 8; # number of pairs of cards to match
my $num_matches = 0; # number of matched pairs so far

# shuffle cards
for (my $i = 0; $i < @cards; $i++) {
    for (my $j = 0; $j < @{$cards[$i]}; $j++) {
        my $x = int(rand(@cards));
        my $y = int(rand(@{$cards[$x]}));
        ($cards[$i][$j], $cards[$x][$y]) = ($cards[$x][$y], $cards[$i][$j]);
    }
}

# main game loop
while ($num_matches < $num_pairs) {
    # print board
    print "   1  2  3  4\n";
    print "  -----------\n";
    for (my $i = 0; $i < @board; $i++) {
        print "$i |";
        for (my $j = 0; $j < @{$board[$i]}; $j++) {
            if ($board[$i][$j] eq "X") {
                print " X ";
            } else {
                print " " . $cards[$i][$j] . " ";
            }
            print "|";
        }
        print "\n";
    }
    print "  -----------\n\n";

    # prompt user for move
    my ($row1, $col1, $row2, $col2);
    do {
        print "Enter the coordinates of the first card to flip (row column): ";
        ($row1, $col1) = split(" ", <STDIN>);
    } until ($board[$row1][$col1] eq " ");
    $board[$row1][$col1] = "X";

    do {
        print "Enter the coordinates of the second card to flip (row column): ";
        ($row2, $col2) = split(" ", <STDIN>);
    } until ($board[$row2][$col2] eq " " && ($row1 != $row2 || $col1 != $col2));
    $board[$row2][$col2] = "X";

    # check for match
    if ($cards[$row1][$col1] eq $cards[$row2][$col2]) {
        print "You found a match!\n";
        $num_matches++;
        $board[$row1][$col1] = " ";
        $board[$row2][$col2] = " ";
    } else {
        print "No match. Try again.\n";
        $board[$row1][$col1] = " ";
        $board[$row2][$col2] = " ";
    }
}

print "Congratulations! You won!\n";
