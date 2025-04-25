<#
Noah Tah
4/24/2025
Powershell Assignment 4
Programming II
Evan Vaverka
Northwestern Oklahoma State University
Assignment Description:

Create a program that generates a number between 1 and 10, a number between 1 and 50, and a number between 1 and 100.
Give the user the option of choosing one of the random three numbers to guess.
Let the user guess until they get the right answer.
Tell them if they are too high or too low.
Also make sure to tell them if they enter something that is not a number.
#>


function getRandomNumberBetween1And10 {
	return Get-Random -Minimum 1 -Maximum 11 # 11 is exclusive meaning it does not include 11
}

function getRandomNumberBetween1And50 {
	return Get-Random -Minimum 1 -Maximum 51 # 51 is exclusive meaning it does not include 51
}

function getRandomNumberBetween1And100 {
	return Get-Random -Minimum 1 -Maximum 101 # 101 is exclusive meaning it does not include 101
}

function getUserChoice {
	$validChoice = $false
	$choice = $null

	while (-not $validChoice) {
		Write-Host "Choose a number range:"
		Write-Host "1. 1-10"
		Write-Host "2. 1-50"
		Write-Host "3. 1-100"
		write-host "Enter your choice (1, 2, or 3):"
		$choice = Read-Host

		switch ($choice) {
			"1" {
				$validChoice = $true
				return "1-10"
			}
			"2" {
				$validChoice = $true
				return "1-50"
			}
			"3" {
				$validChoice = $true
				return "1-100"
			}
			default {
				Write-Host "Invalid choice. Please enter 1, 2, or 3."
			}
		}
	}


}

function generateRandomNumber ($choice) {
	switch ($choice) {
		"1-10" { return getRandomNumberBetween1And10 }
		"1-50" { return getRandomNumberBetween1And50 }
		"1-100" { return getRandomNumberBetween1And100 }
		default { Write-Host "Invalid choice." }
	}
}

function guessNumberGame ($randomNumber) {
	$guess = 0
	while ($guess -ne $randomNumber) { # -ne means not equal to
		$guess = Read-Host "Enter your guess"
		if ($guess -as [int]) { # -as [int] checks if the input can be converted to an integer
			if ($guess -lt $randomNumber) { # -lt means less than
				Write-Host "Too low! Try again."
			} elseif ($guess -gt $randomNumber) { # -gt means greater than
				Write-Host "Too high! Try again."
			} else {
				Write-Host "Congratulations! You guessed the number $randomNumber!"
			}
		} else {
			Write-Host "Invalid input. Please enter a number."
			getUserChoice # Call the function again to get a valid input
		}
	}
}

function playAgain {
	Write-Host "Do you want to play again? (y/n)"
	$playAgain = Read-Host
	if ($playAgain -eq "y") {
		main
	} elseif ($playAgain -eq "n") {
		Write-Host "Thanks for playing!"
	} else {
		Write-Host "Invalid input. Please enter 'y' or 'n'."
		playAgain
	}
}

function main {
	# Get the user's choice of number range
	$choice = getUserChoice

	Write-Host "You chose the range: $choice"

	# Generate a random number based on the user's choice
	$randomNumber = generateRandomNumber $choice

	Write-Host $randomNumber

	Write-Host "A random number has been generated in the range $choice."
	Write-Host "Try to guess the number!"

	# Start the guessing game
	guessNumberGame $randomNumber

	# Ask the user if they want to play again
	playAgain

}



main