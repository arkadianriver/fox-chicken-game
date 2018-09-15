#!perl
# The Fox and Chicken Game

# ------------------------------
# Prep
# ------------------------------

use strict;
use warnings;

my $ui   = "";  # simple var used for user input response
my $msg  = "";  # user input mistake message
my $side  = 0;  # start on side false (seeking truth ;-) )

# hash holds which side each is on. (sides are 0 and 1.)
# (an array would be more terse, but more legible with a hash)
my %a = (
  fox     => 0,
  chicken => 0,
  corn    => 0,
  you     => 0
);

# ------------------------------
# Main game loop
# ------------------------------

while (1) {

  # If all on side 1 (true side), you win.
  if ($a{fox} && $a{chicken} && $a{corn}) { gameOver("Hurray, you won."); }

  #show the rules and river
  writePretty(%a);

  # ask the user what to take over
  $ui = listThings();

  # check validity. if invalid, reprint with the msg (in the listThings prompt)
  if (!exists($a{$ui})) {
    $msg = "Oops, type one of the listed things.\n";
    redo;
  }

  # row, row, row your boat..
  $side = int(!$side);             # go to opposite side
  $a{you} = $side;                 # both you and
  $a{$ui} = $side if $ui ne 'you'; # your passenger

  # rewrite the resulting state of the river. in case the game ends in the next step,
  # you want to show the final 'oopsie' outcome.
  writePretty(%a);

  # Testing the losing conditions:
  #   main logic of the game using XOR and XNOR, instead of != and = to better map
  #   to circuitry? something like that. :O)
  #   - 1^1=false and 0^0=false, so if true they're on opposite sides (XOR)
  #   - the ! of that means "yes, they're on the same side" (XNOR)

  # Both acts of carnage would involve the chicken and only if you're on the opposite
  # side, so first xor that critter.
  if ($a{you} ^ $a{chicken}) {

    # While you're away...

    # if chicken and fox are on same side (xnor), fox eats chicken.
    if (!($a{chicken} ^ $a{fox})) { gameOver("You lose. Chicken salad sandwich."); }

    # if chicken and corn are on same side (xnor), chicken eats corn.
    if (!($a{chicken} ^ $a{corn})) { gameOver("You lose. Corn on the cob."); }

  }

  $msg = "";

}

# ------------------------------
# Subs
# ------------------------------

# exit routine
sub gameOver
{
  my ($msg) = @_;
  print $msg ."\n";
  print "*** Game Over ***\n";
  exit;
}

# List items that are available to take to the other side and get user input.
sub listThings
{
  my $str;
  print "You're on side $side.\nWhat do you want to take across? (or 'q' to quit)\n";
  foreach my $key (sort keys %a) {
    length($key) or next;
    if ($a{$key} == $side) { $str .= " $key,"; }
  }
  chop($str);
  print $str."\n".$msg."--> ";
  $ui = <>;
  chomp $ui;
  gameOver("Quitting.") if $ui eq 'q';
  return $ui;
}

# Works okay without this, but the game is easier to get through when you
# have a 2D representation to look at, too. It simply clears the screen and
# redraws the river in a certain way based on which side each varmint is on.
sub writePretty
{
  system $^O eq 'MSWin32' ? 'cls' : 'clear';

  print <<EOR;
    Fox and Chicken Game
    --------------------
Rules:
- Get everything to the other side without anything being eaten.
- Your boat can hold you and one other thing (or just you, too).
- Fox and chicken can't be left alone on either side without you;
  otherwise, the fox will eat the chicken.
- chicken and corn can't be left alone on either side without you;
  otherwise, the chicken will eat the corn.

EOR
  print "-----------------\n Side 0 | Side 1\n--------|--------\n";
  if ($a{fox}     == 1) { print "        |fox\n";       } else { print "fox     |\n"; }
  if ($a{chicken} == 1) { print "        |chicken\n";   } else { print "chicken |\n"; }
  if ($a{corn}    == 1) { print "        |corn\n";      } else { print "corn    |\n"; }
  if ($a{you}     == 1) { print "        |you \\__/\n"; } else { print "you \\__/|\n"; }
  print "-----------------\n\n";
}

