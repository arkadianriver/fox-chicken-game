
# The Fox and Chicken Game

```
perl fox.pl
```

Starting on side 'false', move three items to side 'true' according
to the rules printed on the screen. Makes use of _exclusive or_ such
that if items a and b are on the same side without you, that is,
both false or both true, you lose.

## The game

In action! LOL

```
    Fox and Chicken Game
    --------------------
Rules:
- Get everything to the other side without anything being eaten.
- Your boat can hold you and one other thing (or just you, too).
- Fox and chicken can't be left alone on either side without you;
  otherwise, the fox will eat the chicken.
- chicken and corn can't be left alone on either side without you;
  otherwise, the chicken will eat the corn.

-----------------
 Side 0 | Side 1
--------|--------
fox     |
chicken |
corn    |
you \__/|
-----------------

You're on side 0.
What do you want to take across? (or 'q' to quit)
 chicken, corn, fox, you
--> fox▃
```
