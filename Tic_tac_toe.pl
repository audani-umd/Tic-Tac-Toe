#!/usr/bin/perl;

@board = ([0,1,2],[3,4,5],[6,7,8]);
$computerWins = 0;
$playerTurnCount = 0;

while (true) {

printBoard();

print "\nPick a space:";
$input = <>;
chomp($input);

$userPlayed = populateBoardForUser($input);

if($userPlayed == 0) {
	next;
}

# If the player has completed 5 turns, it means that the board is filled.
# Also, since the algorithm is such that a player can never win, we check either for a computer
# win or a tie.
if ($playerTurnCount == 5) {
	printBoard();
	print "\nIts a tie!!!!";
	last;
}

populateBoardForComputer();

if ($computerWins == 1) {
	printBoard();
	print "\nComputer wins!!!!";
	last;
}
}


sub printBoard {
	print "\n";
	for ($i=0;$i<3;$i++) {
		for ($j=0;$j<3;$j++) {
			print " $board[$i][$j] ";
			if ($j!=2) {
				print "|";
			}
		}
		print "\n---+---+---\n";
	}
}

sub populateBoardForUser {
	
	$input = @_[0];

	# Checking if the user input is a digit between 0(inclusive) to 8(inclusive)
	if ($input =~ /[^\d]/ || ($input < 0 || $input > 8)) {
		print "Invalid input. Try again\n";
		return 0;
	}

	for ($i=0;$i<3;$i++) {
		for ($j=0;$j<3;$j++) {
			if ($board[$i][$j] eq $input) {
				$board[$i][$j] = "X";
				$playerTurnCount++;
				return 1;
			}
		}
	}
	return 0;
}

sub populateBoardForComputer {
	
	$computerPlayed = 0;
	$rotationCounter = 0;
	
	while ($rotationCounter < 4) {
		
		$computerPlayed = checkIfComputerCanWin();

		if ($computerPlayed == 1) {
			last;
		}
		rotateBoard();
		$rotationCounter++;
	}

	if ($computerPlayed != 1) {
		$rotationCounter = 0;

		while ($rotationCounter < 4) {

			$computerPlayed = checkIfComputerCanBlockFirstMove();
			if ($computerPlayed == 1) {
				last;
			}
			rotateBoard();
			$rotationCounter++;
		}		
	}
		
	if ($computerPlayed != 1) {
		$rotationCounter = 0;

		while ($rotationCounter < 4) {
			$computerPlayed = checkIfComputerCanBlockSecondMove();
			if ($computerPlayed == 1) {
				last;
			}
			rotateBoard();
			$rotationCounter++;
		}
	}

	# This step ensures that the board is rotated back to its original position
	while ($rotationCounter < 4) {
		rotateBoard();
		$rotationCounter++;
	}
			

	if ($computerPlayed != 1) {
		if ($board[1][1] =~ /[^XO]/) {
			$board[1][1] = "O";
		} else {
			OUTER: for ($i = 0; $i<3; $i++) {
					for ($j = 0; $j<3; $j++) {
						if ($board[$i][$j] =~ /[^XO]/) {
							$board[$i][$j] = "O";
							last OUTER;
						}
					}
				}
		}
	}
}

sub checkIfComputerCanWin {
	
	# Pattern 1
	if ($board[0][1] eq "O" && $board[0][2] eq "O" && $board[0][0] =~ /[^XO]/) {
		$board[0][0] = "O";
		$computerWins = 1;
	}
	# Pattern 2
	elsif($board[1][0] eq "O" && $board[2][0] eq "O" && $board[0][0] =~ /[^XO]/) {
		$board[0][0] = "O";
		$computerWins = 1;	
	}
	# Pattern 3
	elsif($board[1][1] eq "O" && $board[2][2] eq "O" && $board[0][0] =~ /[^XO]/) {
		$board[0][0] = "O";
		$computerWins = 1;	
	}
	# Pattern 4
	elsif ($board[0][0] eq "O" && $board[0][2] eq "O" && $board[0][1] =~ /[^XO]/) {
		$board[0][1] = "O";
		$computerWins = 1;
	}
	# Pattern 5
	elsif ($board[1][1] eq "O" && $board[2][1] eq "O" && $board[0][1] =~ /[^XO]/) {
		$board[0][1] = "O";
		$computerWins = 1;	
	}
	# Pattern 6
	elsif ($board[0][1] eq "O" && $board[2][1] eq "O" && $board[1][1] =~ /[^XO]/) {
		$board[1][1] = "O";
		$computerWins = 1;
	}
	# Pattern 7
	elsif ($board[0][0] eq "O" && $board[2][2] eq "O" && $board[1][1] =~ /[^XO]/) {
		$board[1][1] = "O";
		$computerWins = 1;	
	}

	if ($computerWins == 1) {
		return 1;
	}
	else {
		return 0;
	}
}

sub checkIfComputerCanBlockFirstMove {
	
	# Pattern 8
	if ($board[0][1] eq "X" && $board[0][2] eq "X" && $board[0][0] =~ /[^XO]/) {
		$board[0][0] = "O";
		return 1;
	}
	# Pattern 9
	elsif($board[1][0] eq "X" && $board[2][0] eq "X" && $board[0][0] =~ /[^XO]/) {
		$board[0][0] = "O";
		return 1;	
	}
	# Pattern 10
	elsif ($board[1][1] eq "X" && $board[2][2] eq "X" && $board[0][0] =~ /[^XO]/) {
		$board[0][0] = "O";
		return 1;	
	}
	# Pattern 11
	elsif ($board[0][0] eq "X" && $board[0][2] eq "X" && $board[0][1] =~ /[^XO]/) {
		$board[0][1] = "O";
		return 1;
	}
	# Pattern 12
	elsif ($board[1][1] eq "X" && $board[2][1] eq "X" && $board[0][1] =~ /[^XO]/) {
		$board[0][1] = "O";
		return 1;	
	}
	# Pattern 13
	elsif ($board[0][1] eq "X" && $board[2][1] eq "X" && $board[1][1] =~ /[^XO]/) {
		$board[1][1] = "O";
		return 1;
	}
	# Pattern 14
	elsif ($board[0][0] eq "X" && $board[2][2] eq "X" && $board[1][1] =~ /[^XO]/) {
		$board[1][1] = "O";
		return 1;	
	} 
	else {
		return 0;
	}
}

sub checkIfComputerCanBlockSecondMove {
	
	# Pattern 15
	if ($board[0][2] eq "X" && $board[1][1] eq "O" && $board[2][0] eq "X" && $board[0][0] =~ /[^XO]/ && $board[1][0] =~ /[^XO]/ && $board[1][2] =~ /[^XO]/ && $board[2][1] =~ /[^XO]/ && $board[2][2] =~ /[^XO]/ && $board[0][1] =~ /[^XO]/) {
		$board[0][1] = "O";
		return 1;
	}
	# Pattern 16
	elsif ($board[0][1] eq "X" && $board[1][0] eq "X" && $board[1][1] eq "O" && $board[0][2] =~ /[^XO]/ && $board[2][0] =~ /[^XO]/ && $board[0][0] =~ /[^XO]/) {
		$board[0][0] = "O";
		return 1;	
	}
	# Pattern 17
	elsif ($board[0][2] eq "X" && $board[1][0] eq "X" && $board[1][1] eq "O" && $board[0][1] =~ /[^XO]/ && $board[2][0] =~ /[^XO]/ && $board[0][0]=~ /[^XO]/) {
		$board[0][0] = "O";
		return 1; 
	}
	# Pattern 18
	elsif ($board[0][2] eq "X" && $board[1][1] eq "O" && $board[2][1] eq "X" && $board[1][2] =~ /[^XO]/ && $board[2][0] =~ /[^XO]/ && $board[2][2] =~ /[^XO]/) {
		$board[2][2] = "O";
		return 1;	
	}
	# Pattern 19
	elsif ($board[0][2] eq "X" && $board[1][1] eq "O" && $board[2][0] eq "X" && $board[0][1] =~ /[^XO]/ && $board[1][0] =~ /[^XO]/ && $board[0][0] =~ /[^XO]/) {
		$board[0][0] = "O";
		return 1;
	}
	# Pattern 20
	elsif ($board[1][1] eq "X" && $board[2][2] =~ /[^XO]/ && $board[0][0] =~ /[^XO]/) {
		$board[0][0] = "O";
		return 1;
	}
	# Pattern 21
	elsif ($board[1][1] eq "X" && $board[2][1] =~ /[^XO]/ && $board[0][1] =~ /[^XO]/) {
		$board[0][1] = "O";
		return 1;
	} else {
		return 0;
	}
}

sub rotateBoard {
	@temp = map { [@$_] } @board;
	@topRow = ($temp[0][2],$temp[1][2],$temp[2][2]);
	@middleRow = ($temp[0][1],$temp[1][1],$temp[2][1]);
	@bottomRow = ($temp[0][0],$temp[1][0],$temp[2][0]);

	@board = (\@topRow,\@middleRow,\@bottomRow);
}