# Souls-
An interactive game made using assembly language that simulates a fast-paced combat system with timing-based inputs.

Game Controls

The game uses the numeric keypad for input. Here are the control keys:

Start Game: Press 5

Dodge Left: Press 7

Dodge Right: Press 8

Dodge Down: Press 6

Dodge Up: Press 9

Attack: Press 0

Play Again: Press y (yes) or n (no) when prompted

Installation

To run Souls Game, you will need to have the following:

Assembler: An assembler that supports Assembly x86, such as MASM (Microsoft Macro Assembler).

Irvine32 Library: Ensure you have the Irvine32.inc file included in your project directory.

Steps to Run

Clone or download the source code.

Place the Irvine32.inc file in the same directory as the game file.

Assemble and link the source code to create an executable.

Run the executable from the console.

How to Play

Start the Game: Run the executable and press 5 to start the game.

Respond to Attacks: Your opponent will attack from one of four directions: left, right, up, or down. Dodge using the respective keys on the numeric keypad.

Counterattack: When the opponent is tired, press 0 to launch an attack.

Victory: Successfully dodge and counter 10 attacks to win.

Game Over: If you fail to dodge or miss an attack opportunity, the game ends, and you will see your final score.

Play Again: You will be prompted to play again. Press y to restart or n to exit.

Game Logic

Randomized Attacks: The opponent launches random attacks (left, right, up, down) in each round.

Timed Inputs: You must respond within a set time limit for each attack. If you are too slow, the game ends.

Scoring: Each successful counterattack increases your score. Once you reach 10 successful counterattacks, you win.

Key Flow

Start → Random Attack → Player Dodge → Repeat (5 attacks per round) → Player Counterattack → Score Update → Victory/Defeat

Technical Details

The game is developed using Assembly x86 with the following components:

Irvine32 Library: Provides system calls for console interaction (like reading input and printing messages).

Game Loop: The main loop where rounds of attacks and player responses occur.

Randomized Attack Generation: Uses the RandomRange function to determine which type of attack is executed.

Input Timing: Captures the player's response time using the GetLocalTime function.

Color-Coded Messages: Different message types are displayed using colored text to provide visual feedback to the player.

Future Enhancements

Possible improvements and new features:

Adjustable Difficulty: Allow players to adjust the response time limit.

Advanced AI: Introduce different attack patterns and smarter opponent logic.

Sound Effects: Add sound effects for successful dodges, attacks, and game over.

Leaderboard: Save and display high scores for replayability.
