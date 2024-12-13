INCLUDE Irvine32.inc

.data
startMsg        BYTE "Press 5 to start the game.", 0
playAgainMsg    BYTE "Do you want to play again? (y/n): ", 0
dodgeLeftMsg    BYTE "Opponent attacks LEFT! Dodge left (press 7).", 0
dodgeRightMsg   BYTE "Opponent attacks RIGHT! Dodge right (press 8).", 0
dodgeDownMsg    BYTE "Opponent attacks UP! Dodge down (press 6).", 0
dodgeUpMsg      BYTE "Opponent attacks DOWN! Dodge up (press 9).", 0
attackMsg       BYTE "Opponent tired! Attack (press 0).", 0
successMsg      BYTE "You successfully attacked! Score: ", 0
failMsg         BYTE "You failed! Game over. Final score: ", 0
tooSlowMsg		BYTE "You were too slow! Game over. Final score: ", 0
victoryMsg      BYTE "The enemy has fallen! Final score: ", 0
newline         BYTE 13, 10, 0

score			BYTE 0
setDelay		WORD 2000 ; in milliseconds
attackType		BYTE 0

consoleHandle	HANDLE 0

startTime		SYSTEMTIME <>
endTime			SYSTEMTIME <>
timeDiff		DWORD 0

.code
; changes the color of the text
textColor MACRO color
	pushad
	mov eax, color
	call SetTextColor
	popad
ENDM

; prints out a message to the console
print MACRO msg
	pushad
	call Crlf
	mov edx, OFFSET msg
	call WriteString
	popad
ENDM

; checks if the input is right and done fast enough
valIn MACRO num
	tick
	call ReadChar
	tock

	movzx ebx, setDelay
	cmp timeDiff, ebx
	ja slowGameOver

	cmp al, num
	jne gameOver
	jmp continueRound
ENDM

; gets initial time
tick MACRO
	pushad
	INVOKE GetLocalTime, ADDR startTime
	popad
ENDM

; calulates difference between initial time and current time
tock MACRO
	pushad
	INVOKE GetLocalTime, ADDR endTime

	movzx ebx, startTime.wMinute
	movzx eax, endTime.wMinute
	sub eax, ebx
	mov ecx, 60
	mul ecx ; to minutes
	mov ecx, 1000
	mul ecx ; to milliseconds
	mov timeDiff, eax

	movzx ebx, startTime.wSecond
	movzx eax, endTime.wSecond
	sub eax, ebx
	mov ecx, 1000
	mul ecx ; to milliseconds
	add timeDiff, eax

	movzx ebx, startTime.wMilliseconds
	movzx eax, endTime.wMilliseconds
	sub eax, ebx
	add timeDiff, eax
	popad
ENDM

randAttack PROC
	mov eax, 4
	call RandomRange
	add eax, 1; Random attack 1 - 4
	ret
randAttack ENDP

main PROC
	call Randomize

	startGame :
		textColor lightBlue
		mov score, 0
		call Clrscr
		print startMsg
		call ReadChar
		cmp al, '5'
		jne startGame; Wait until '5' is pressed

		gameLoop :
			cmp score, 10
			je victory; End game if score reaches 10

			mov ecx, 5; 5 attacks per round

			roundStart :
				call randAttack; Get random attack type

				; change this if you want to make it not random
				mov attackType, al
				;mov attackType, 1

				; Display corresponding attack message
				cmp attackType, 1
				je attackLeft
				cmp attackType, 2
				je attackRight
				cmp attackType, 3
				je attackUp
				cmp attackType, 4
				je attackDown

			attackLeft :
				print dodgeLeftMsg
				valIn '7'

			attackRight :
				print dodgeRightMsg
				valIn '8'

			attackUp :
				print dodgeDownMsg
				valIn '6'

			attackDown :
				print dodgeUpMsg
				valIn '9'

			continueRound :
				dec ecx
				jnz roundStart; Continue until all attacks are done

				; Opponent tired, player's turn to attack
				print attackMsg
				call ReadChar
				cmp al, '0'
				jne gameOver; Fail if player doesn't attack in time

				; Successful attack
				add score, 1 ; Increment score
				print successMsg
				movzx eax, score
				textColor green
				call WriteDec
				textColor lightBlue
				call Crlf

				jmp gameLoop

		victory :
			print victoryMsg
			movzx eax, score
			textColor green
			call WriteDec
			textColor lightBlue
			call Crlf
			jmp askPlayAgain
		
		slowGameOver :
			print tooSlowMsg
			jmp scoring
		gameOver :
			print failMsg

		scoring:
			movzx eax, score
			textColor red
			call WriteDec
			textColor lightBlue
			call Crlf

		askPlayAgain :
			print playAgainMsg
			call ReadChar
			cmp al, 'y'
			je startGame; Restart game if 'y'
			cmp al, 'n'
			jne askPlayAgain; Prompt again if input is invalid

	exitGame :
		exit
main ENDP
END main
