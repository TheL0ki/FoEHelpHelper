/*
	###########################################################################################
	###		Script to push the "Help" button automatically  								###
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
	IniRead, nh, foeHelpConfig.ini, loopcount, nh
	IniRead, gd, foeHelpConfig.ini, loopcount, gd
	IniRead, fl, foeHelpConfig.ini, loopcount, fl
} else {
	nh:=0
	gd:=0
	fl:=0
}
Gui, Add, Text, x10 y5, Anzahl Spieler in Nachbarschaft/Gilde/FL:
Gui, Add, Text, x10 y33, NH:
Gui, Add, Edit, x45 y30 w30 r1 vNH, %nh%
Gui, Add, Text, x10 y63, GD:
Gui, Add, Edit, x45 y60 w30 r1 vGD, %gd%
Gui, Add, Text, x10 y93, FL:
Gui, Add, Edit, x45 y90 w30 r1 vFL, %fl%
Gui, Add, Button, x8 y120 w97 h23 gFoELoopCount Default, OK
Gui, Add, Button, x112 y120 w98 h23 gCancelExit, Cancel
Gui, Show,,Foe Helper v0.6

Escape::
	Reload
return

FoELoopCount:
	Gui, Submit
	Gui, Destroy
	IniWrite, %NH%, foeHelpConfig.ini, loopcount, nh
	IniWrite, %GD%, foeHelpConfig.ini, loopcount, gd
	IniWrite, %FL%, foeHelpConfig.ini, loopcount, fl
	IniRead, BPcolor, foeHelpConfig.ini, positions, bpcolor
	ActiveList:=0
	BPCount:=0
	TavCount:=0
	prog:=0
	progmax=0
	progmax+=NH
	progmax+=GD
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
	PSY1:=WinH-30
	PSY2:=WinH-12
	TavY1:=WinH-50
	TavY2:=WinH-51
	hPixel:=0x1C498A
	Brown:=0x0B1D34
	while(ActiveList < 3)
	{
		If(ActiveList = 0)
		{
			IniRead, loopcount, foeHelpConfig.ini, loopcount, nh
			loopcount:=Ceil(loopcount/5)
			MouseClick, Left, 750, %TabY%, 1, 5 ; Click Neighbourhood
			sleep, 500
		}
		else if(ActiveList = 1) {
			IniRead, loopcount, foeHelpConfig.ini, loopcount, gd
			loopcount:=Ceil(loopcount/5)
			MouseClick, Left, 815, %TabY%, 1, 5 ; Click Guild
			sleep, 500				
		}
		else if(ActiveList = 2) {
			IniRead, loopcount, foeHelpConfig.ini, loopcount, fl
			loopcount:=Ceil(loopcount/5)
			MouseClick, Left, 880, %TabY%, 1, 5 ; Click Friendlist
			sleep, 500
		} 
		
		MouseClick, Left, 252, %FirstY%, 1, 5 ;Go to Liststart
		sleep, 2000
		HelpPixel = 0x1E4C8F
		loop, %loopcount% {
			PixelSearch, PixelX, PixelY, 270, %PSY1%, 370, %PSY2%, 0x1C498A, 3, Fast
			If (ErrorLevel = 0) {
				MouseClick, Left, 350, %HY%, 1, 5 ; Click Help Button 1
				sleep, 2000
				Gosub, BPCheck				
			}
			
			if(ActiveList = 2) {
				PixelSearch, PixelX, PixelY, 364, %TavY1%, 365, %TavY2%, 0x5D8494, 3
				If (ErrorLevel = 0) {
					MouseClick, Left, 364, %TavY1%, 1, 5
					sleep, 2000
					MouseClick, Left, 364, %TavY1%, 1, 5
					TavCount+=1
				}
			}
			
			Gosub, RaiseProg
			
			PixelSearch, PixelX, PixelY, 377, %PSY1%, 477, %PSY2%, 0x1C498A, 3, Fast
			If (ErrorLevel = 0) {
				MouseClick, Left, 457, %HY%, 1, 5 ; Click Help Button 2
				sleep, 2000
				Gosub, BPCheck				
			}
			
			if(ActiveList = 2) {
				PixelSearch, PixelX, PixelY, 471, %TavY1%, 472, %TavY2%, 0x5D8494, 3
				If (ErrorLevel = 0) {
					MouseClick, Left, 471, %TavY1%, 1, 5
					sleep, 2000
					MouseClick, Left, 471, %TavY1%, 1, 5
					TavCount+=1
				}
			}
			
			Gosub, RaiseProg
			
			PixelSearch, PixelX, PixelY, 484, %PSY1%, 584, %PSY2%, 0x1C498A, 3, Fast
			If (ErrorLevel = 0) {
				MouseClick, Left, 564, %HY%, 1, 5 ; Click Help Button 3
				sleep, 2000
				Gosub, BPCheck				
			}
			
			if(ActiveList = 2) {
				PixelSearch, PixelX, PixelY, 578, %TavY1%, 579, %TavY2%, 0x5D8494, 3
				If (ErrorLevel = 0) {
					MouseClick, Left, 578, %TavY1%, 1, 5
					sleep, 1000
					MouseClick, Left, 578, %TavY1%, 1, 5
					TavCount+=1
				}
			}
			
			Gosub, RaiseProg
			
			PixelSearch, PixelX, PixelY, 591, %PSY1%, 691, %PSY2%, 0x1C498A, 3, Fast
			If (ErrorLevel = 0) {
				MouseClick, Left, 671, %HY%, 1, 5 ; Click Help Button 4
				sleep, 2000
				Gosub, BPCheck				
			}				
			
			if(ActiveList = 2) {
					PixelSearch, PixelX, PixelY, 685, %TavY1%, 686, %TavY2%, 0x5D8494, 3
					If (ErrorLevel = 0) {
						MouseClick, Left, 685, %TavY1%, 1, 5
						sleep, 1000
						MouseClick, Left, 685, %TavY1%, 1, 5
						TavCount+=1
					}
				}
			
			Gosub, RaiseProg
			
			PixelSearch, PixelX, PixelY, 698, %PSY1%, 798, %PSY2%, 0x1C498A, 3, Fast
			If (ErrorLevel = 0) {
				MouseClick, Left, 778, %HY%, 1, 5 ; Click Help Button 5
				sleep, 2000
				Gosub, BPCheck				
			}
			
			if(ActiveList = 2) {
					PixelSearch, PixelX, PixelY, 792, %TavY1%, 793, %TavY2%, 0x5D8494, 3
					If (ErrorLevel = 0) {
						MouseClick, Left, 792, %TavY1%, 1, 5
						sleep, 1000
						MouseClick, Left, 792, %TavY1%, 1, 5
						TavCount+=1
					}
				}
			
			Gosub, RaiseProg
			
			MouseClick, Left, 922, %NextY%, 1, 5 ; Go to next List (2ArrowButton)
			sleep, 1000
		}
		ActiveList+=1
	}
	ActiveList:=0
	Gui, Destroy
	MsgBox, Fertig`n%BPCount% neue Blaupausen`n%TavCount% Tavernen besucht
	ExitApp
return

RaiseProg:
	prog+=1
	GuiControl,, Progressbar, +1
	GuiControl,, ProgressText, %prog%/%progmax%
return

BPCheck:
	WinGetPos, X, Y, WinW, WinH, A
	BPX1:=Round((WinW/2)+5,0)
	BPY1:=Round((WinH/2)+240,0)
	BPX2:=Round((WinW/2)+175,0)
	BPY2:=Round((WinW/2)+261,0)
	BPCX:=Round((WinW/2)+140,0)
	BPCY:=Round((WinH/2)+250,0)
	PixelSearch, PixelX, PixelY, %BPX1%, %BPY1%, %BPX2%, %BPY2%, 0x192479, 0, Fast
	If (ErrorLevel = 0) {
		MouseClick, Left, %BPCX%, %BPCY%, 1, 5 ; Close BP Window
		BPCount+=1
		sleep, 1000
	}
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