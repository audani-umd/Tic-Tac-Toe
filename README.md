# Tic-Tac-Toe
This is a simple 2-player version of the Tic Tac Toe game developed in Perl.

To run this game, you need to have Perl installed on your system.
Go to the terminal, and type the following command to run the game 
perl Tic_tac_toe.pl

This is a two player game. The user always gets to take the first turn and is assigned the 'X' symbol. The computer plays next and is assigned the 'O' symbol. Both the player and the computer take turns to play the game until either the computer wins or the game is tied. The algorithm that the computer uses to decide its move is such that, the player can never win. 

The Algorithm

The algorithm really only computes the computer's moves for the following three squares:

 * | * |  
---+---+---
   | * |  
---+---+---
   |   | 
   
If the computer determines that it needs to move into one of these squares, then it takes the move and allows the player to make his/her move. If these squares are already occupied, or there isn't an important move in any of these squares, the computer rotates the board 90 degrees counter-clockwise and tries these same three positions (on the new board) again. After rotating the board four times, the computer winds up with the original configuration. If this occurs, and the board isn't completely filled, the computer takes the first available position on the game board (first trying the center, then moving from left to right, top to bottom).

When making a move, the computer first checks to see if it can win by putting an "O" into one of these three squares. If it cannot win, it checks to see if it has to block X from winning on the next move by putting an "O" into one of these three squares. If neither of these two conditions holds, the computer checks to see if it has to move into one of these squares to block X from winning in two moves. If it can't win and doesn't need to block X on the next one or two moves, the computer tries to take the center square. If that is not available, it starts at the left top corner and moves across and then down until it finds an open square. 

To see if the computer can win, it checks for one of the following patterns. The computer checks them in the following order.
Note: an "X", "O", or space appear in a square below means that character must be present. A * means that anything may appear in the square. A "?" denotes the position (that must currently contain a blank) where the computer will put an "O" if the pattern matches.


Pattern #1 to check:

 ? | O | O 
---+---+---
 * | * | * 
---+---+---
 * | * | * 

Pattern #2 to check:

 ? | * | * 
---+---+---
 O | * | * 
---+---+---
 O | * | * 

Pattern #3 to check:

 ? | * | * 
---+---+---
 * | O | * 
---+---+---
 * | * | O 

Pattern #4 to check:

 O | ? | O 
---+---+---
 * | * | * 
---+---+---
 * | * | * 

Pattern #5 to check:

 * | ? | * 
---+---+---
 * | O | * 
---+---+---
 * | O | * 

Pattern #6 to check:

 * | O | * 
---+---+---
 * | ? | * 
---+---+---
 * | O | * 


Pattern #7 to check:

 O | * | * 
---+---+---
 * | ? | * 
---+---+---
 * | * | O 
The following patterns check to see if the computer needs to block the player from winning on the next move.


Pattern #8 to check:

 ? | X | X 
---+---+---
 * | * | * 
---+---+---
 * | * | * 

Pattern #9 to check:

 ? | * | * 
---+---+---
 X | * | * 
---+---+---
 X | * | * 

Pattern #10 to check:

 ? | * | * 
---+---+---
 * | X | * 
---+---+---
 * | * | X 

Pattern #11 to check:

 X | ? | X 
---+---+---
 * | * | * 
---+---+---
 * | * | * 

Pattern #12 to check:

 * | ? | * 
---+---+---
 * | X | * 
---+---+---
 * | X | * 


Pattern #13 to check:

 * | X | * 
---+---+---
 * | ? | * 
---+---+---
 * | X | * 


Pattern #14 to check:

 X | * | * 
---+---+---
 * | ? | * 
---+---+---
 * | * | X 



The following patterns represent positions the computer must move to block the player from winning in two moves.

Pattern #15 to check:

    | ? | X     
 ---+---+---
    | O |   
 ---+---+---
  X |   |   

Pattern #16 to check:

 ? | X |   
---+---+---
 X | O | * 
---+---+---
   | * | * 

Pattern #17 to check:

 ? |   | X 
---+---+---
 X | O | * 
---+---+---
   | * | * 


Pattern #18 to check:

 * | * | X 
---+---+---
 * | O | 
---+---+---
   | X | ? 

Pattern #19 to check:

 ? |   | X 
---+---+---
   | O | * 
---+---+---
 X | * | * 

Pattern #20 to check:
 ? | * | * 
---+---+---
 * | X | * 
---+---+---
 * | * |   


Pattern #21 to check:

 * | ? | * 
---+---+---
 * | X | * 
---+---+---
 * |   | * 
 
If the computer cannot match one of the above patterns, it rotates the board 90 degrees and tries again. After rotating the board four times without finding a match, the computer locates the first empty square and moves there (check the middle first, and then the rest). If there are not empty squares, the game is over.

With this algorithm, the computer should never lose.
