/*
	###########################################################################################
	###		Script to push the "Tavern" button automatically  								###
	###			Made by Alexander Dominikus													###
	###																						###
	###MIT License																			###
	###																						###
	###Copyright (c) 2016 Alexander Dominikus												###
	###																						###
	###Permission is hereby granted, free of charge, to any person obtaining a copy			###
	###of this software and associated documentation files (the "Software"), to deal		###
	###in the Software without restriction, including without limitation the rights			###
	###to use, copy, modify, merge, publish, distribute, sublicense, and/or sell			###
	###copies of the Software, and to permit persons to whom the Software is				###
	###furnished to do so, subject to the following conditions:								###
	###																						###
	###The above copyright notice and this permission notice shall be included in all		###
	###copies or substantial portions of the Software.										###
	###																						###
	###THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR			###
	###IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,				###
	###FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE			###
	###AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER				###
	###LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,		###
	###OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE		###
	###SOFTWARE.																			###
	###########################################################################################
*/
if(FileExist("foeHelpConfig.ini")) {
	IniRead, nh, foeHelpConfig.ini, tavern, fl
} else {
	nh:=0
}
Gui Add, Edit, x144 y16 w25 h21 vFL, %nh%
Gui Add, Text, x16 y16 w120 h23 +0x200, Anzahl Spieler in der FL:
Gui Add, Button, x16 y56 w75 h23 gFoELoopCount, OK
Gui Add, Button, x120 y56 w75 h23 gCancelExit, Cancel
Gui Show, w215 h94, Tavernen Helper v0.1
Return

Escape::
	Reload
return

FoELoopCount:
	Gui, Submit
	Gui, Destroy
	IniWrite, %FL%, foeHelpConfig.ini, tavern, fl
	TavCount:=0
	prog:=0
	progmax=0
	progmax+=FL
	prog_step:=progmax/100
	Gui +AlwaysOnTop
	Gui, Add, Progress, x22 y28 w160 h20 Range0-%progmax% vProgressbar BackgroundC0C0C0
	Gui, Add, Text, x22 y9 w160 h20 +Center vProgressText
	Gui, Add, Text, x22 y56 w160 h20 +Center, (ESC to Abort)
	Gui, Show, x318 y214 h72 w209 NoActivate, ForgeHelper
	GuiControl,, ProgressText, %prog%/%progmax%
	SetTitleMatchMode, 2
	IfWinNotActive, Forge of Empires 
	{
		WinWaitActive, Forge of Empires
	}
	WinGetPos, X, Y, WinW, WinH, A
	TabY:=WinH-150
	HY:=WinH-20
	FirstY:=WinH-41
	NextY:=WinH-75
	TavY1:=WinH-50
	TavY2:=WinH-51

	IniRead, loopcount, foeHelpConfig.ini, tavern, fl
	loopcount:=Ceil(loopcount/5)
	MouseClick, Left, 880, %TabY%, 1, 5 ; Click Friendlist
	sleep, 500

	MouseClick, Left, 252, %FirstY%, 1, 5 ;Go to Liststart
	sleep, 2000
	loop, %loopcount% {
		PixelSearch, PixelX, PixelY, 364, %TavY1%, 365, %TavY2%, 0x5D8494, 3
		If (ErrorLevel = 0) {
			MouseClick, Left, 364, %TavY1%, 1, 5
			sleep, 2000
			MouseClick, Left, 364, %TavY1%, 1, 5
			TavCount+=1
		}
		
		Gosub, RaiseProg		
		
		PixelSearch, PixelX, PixelY, 471, %TavY1%, 472, %TavY2%, 0x5D8494, 3
		If (ErrorLevel = 0) {
			MouseClick, Left, 471, %TavY1%, 1, 5
			sleep, 2000
			MouseClick, Left, 471, %TavY1%, 1, 5
			TavCount+=1
		}
		
		Gosub, RaiseProg
		
		PixelSearch, PixelX, PixelY, 578, %TavY1%, 579, %TavY2%, 0x5D8494, 3
		If (ErrorLevel = 0) {
			MouseClick, Left, 578, %TavY1%, 1, 5
			sleep, 1000
			MouseClick, Left, 578, %TavY1%, 1, 5
			TavCount+=1
		}
		
		Gosub, RaiseProg		

		PixelSearch, PixelX, PixelY, 685, %TavY1%, 686, %TavY2%, 0x5D8494, 3
		If (ErrorLevel = 0) {
			MouseClick, Left, 685, %TavY1%, 1, 5
			sleep, 1000
			MouseClick, Left, 685, %TavY1%, 1, 5
			TavCount+=1
		}
		
		Gosub, RaiseProg
		
		PixelSearch, PixelX, PixelY, 792, %TavY1%, 793, %TavY2%, 0x5D8494, 3
		If (ErrorLevel = 0) {
			MouseClick, Left, 792, %TavY1%, 1, 5
			sleep, 1000
			MouseClick, Left, 792, %TavY1%, 1, 5
			TavCount+=1
		}

		Gosub, RaiseProg
		
		MouseClick, Left, 922, %NextY%, 1, 5 ; Go to next List (2ArrowButton)
		sleep, 1000
	}
	Gui, Destroy
	MsgBox, Fertig`n%TavCount% Tavernen besucht
	ExitApp
return

RaiseProg:
	prog+=1
	GuiControl,, Progressbar, +1
	GuiControl,, ProgressText, %prog%/%progmax%
return

DestroyGui:
	Gui, Destroy
return

CancelExit:
	ExitApp
return

GuiClose:
	ExitApp
return