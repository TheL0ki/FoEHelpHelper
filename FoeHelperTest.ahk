/*
	###########################################################################################
	###		Script to push the "Help" button automatically 				###
	###			Made by Alexander Dominikus (DasLoki)				###
	###											###
	###MIT License										###
	###											###
	###Copyright (c) 2016 Alexander Dominikus						###
	###											###
	###Permission is hereby granted, free of charge, to any person obtaining a copy		###
	###of this software and associated documentation files (the "Software"), to deal	###
	###in the Software without restriction, including without limitation the rights		###
	###to use, copy, modify, merge, publish, distribute, sublicense, and/or sell		###
	###copies of the Software, and to permit persons to whom the Software is		###
	###furnished to do so, subject to the following conditions:				###
	###											###
	###The above copyright notice and this permission notice shall be included in all	###
	###copies or substantial portions of the Software.					###
	###											###
	###THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR		###
	###IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,		###
	###FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE		###
	###AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER		###
	###LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,	###
	###OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE	###
	###SOFTWARE.										###
	###########################################################################################
*/

if(FileExist("foetest.ini")) {
	IniRead, nh, foetest.ini, loopcount, nh
	IniRead, gd, foetest.ini, loopcount, gd
	IniRead, fl, foetest.ini, loopcount, fl
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
Gui, Add, Button, x10 y120 w50 gFoELoopCount Default, OK
Gui, Add, Button, x65 y120 w50 gConfig, Config
Gui, Add, Button, x120 y120 w50 gCancelExit, Cancel
Gui, Show

^!r::
	Reload
return

FoELoopCount:
	Gui, Submit
	Gui, Destroy
	IniWrite, %NH%, foetest.ini, loopcount, nh
	IniWrite, %GD%, foetest.ini, loopcount, gd
	IniWrite, %FL%, foetest.ini, loopcount, fl
	IniRead, NHx, foetest.ini, positions, nhx
	IniRead, NHy, foetest.ini, positions, nhy
	IniRead, GDx, foetest.ini, positions, gdx
	IniRead, GDy, foetest.ini, positions, gdy
	IniRead, FLx, foetest.ini, positions, flx
	IniRead, FLy, foetest.ini, positions, fly
	IniRead, Nextx, foetest.ini, positions, Nextx
	IniRead, Nexty, foetest.ini, positions, Nexty
	IniRead, Firstx, foetest.ini, positions, Firstx
	IniRead, Firsty, foetest.ini, positions, Firsty
	IniRead, H1x, foetest.ini, positions, h1x
	IniRead, H1y, foetest.ini, positions, h1y
	IniRead, H2x, foetest.ini, positions, h2x
	IniRead, H2y, foetest.ini, positions, h2y
	IniRead, H3x, foetest.ini, positions, h3x
	IniRead, H3y, foetest.ini, positions, h3y
	IniRead, H4x, foetest.ini, positions, h4x
	IniRead, H4y, foetest.ini, positions, h4y
	IniRead, H5x, foetest.ini, positions, h5x
	IniRead, H5y, foetest.ini, positions, h5y
	IniRead, BPx, foetest.ini, positions, bpx
	IniRead, BPy, foetest.ini, positions, bpy
	IniRead, BPcolor, foetest.ini, positions, bpcolor
	ActiveList:=0
	BPCount:=0
	prog:=0
	progmax+=Ceil(NH/5)
	progmax+=Ceil(GD/5)
	progmax+=Ceil(FL/5)
	progmax*=5
	Gui +AlwaysOnTop
	Gui, Add, Progress, x22 y39 w160 h20 Range0-%progmax% vProgressbar
	Gui, Add, Text, x22 y9 w160 h20 +Center vProgressText
	Gui, Show, x318 y214 h72 w209 NoActivate, ForgeHelper
	GuiControl,, ProgressText, %prog%/%progmax%
	CheckPixel = 0x182375
	SetTitleMatchMode, 2
	IfWinNotActive, Forge of Empires 
	{
		WinWaitActive, Forge of Empires
	}
	while(ActiveList < 3)
	{
		If(ActiveList = 0)
		{
			IniRead, loopcount, foetest.ini, loopcount, nh
			loopcount:=Ceil(loopcount/5)
			MouseClick, Left, %NHx%, %NHy%, 1, 5 ; Click Neighbourhood
			sleep, 500
		}
		else if(ActiveList = 1) {
			IniRead, loopcount, foetest.ini, loopcount, gd
			loopcount:=Ceil(loopcount/5)
			MouseClick, Left, %GDx%, %GDy%, 1, 5 ; Click Guild
			sleep, 500				
		}
		else if(ActiveList = 2) {
			IniRead, loopcount, foetest.ini, loopcount, fl
			loopcount:=Ceil(loopcount/5)
			MouseClick, Left, %FLx%, %FLy%, 1, 5 ; Click Friendlist
			sleep, 500
		}
		; ToolTip, % "List: " ActiveList ", Loop: " loopcount 
		
		MouseClick, Left, %Firstx%, %Firsty%, 1, 5 ;Go to Liststart
		sleep, 500
		loop, %loopcount% {
			MouseClick, Left, %H1x%, %H1y%, 1, 5 ; Click Help Button 1
			Gosub, BPCheck
			prog+=1
			GuiControl,, Progressbar, +1
			GuiControl,, ProgressText, %prog%/%progmax%
			sleep, 2000
			
			MouseClick, Left, %H2x%, %H2y%, 1, 5 ; Click Help Button 2
			Gosub, BPCheck
			prog+=1
			GuiControl,, Progressbar, +1
			GuiControl,, ProgressText, %prog%/%progmax%
			sleep, 2000
			
			MouseClick, Left, %H3x%, %H3y%, 1, 5 ; Click Help Button 3
			Gosub, BPCheck
			prog+=1
			GuiControl,, Progressbar, +1
			GuiControl,, ProgressText, %prog%/%progmax%
			sleep, 2000
			
			MouseClick, Left, %H4x%, %H4y%, 1, 5 ; Click Help Button 4
			Gosub, BPCheck
			prog+=1
			GuiControl,, Progressbar, +1
			GuiControl,, ProgressText, %prog%/%progmax%
			sleep, 2000
			
			MouseClick, Left, %H5x%, %H5y%, 1, 5 ; Click Help Button 5
			Gosub, BPCheck
			prog+=1
			GuiControl,, Progressbar, +1
			GuiControl,, ProgressText, %prog%/%progmax%
			sleep, 2000
			
			MouseClick, Left, %Nextx%, %Nexty%, 1, 5 ; Go to next List (2ArrowButton)
			sleep, 1000
		}
		ActiveList+=1
		; ToolTip
	}
	ActiveList:=0
	Gui, Destroy
	; FileDelete, foetest.ini
	MsgBox, Fertig`n%BPCount% neue Blaupausen
	ExitApp
return

BPCheck:
	CheckPixel = %BPcolor%
	PixelGetColor, pColor, %BPx%, %BPy%
	If (pColor = CheckPixel) {
		MouseClick, Left, %BPx%, %BPy%, 1, 5 ; Close BP Window
		BPCount+=1
		sleep, 1000
	}
return

Config:
	If(FileExist("foetest.ini")) {
	IniRead, NHx, foetest.ini, positions, nhx
	IniRead, NHy, foetest.ini, positions, nhy
	IniRead, GDx, foetest.ini, positions, gdx
	IniRead, GDy, foetest.ini, positions, gdy
	IniRead, FLx, foetest.ini, positions, flx
	IniRead, FLy, foetest.ini, positions, fly
	IniRead, Nextx, foetest.ini, positions, Nextx
	IniRead, Nexty, foetest.ini, positions, Nexty
	IniRead, Firstx, foetest.ini, positions, Firstx
	IniRead, Firsty, foetest.ini, positions, Firsty
	IniRead, H1x, foetest.ini, positions, h1x
	IniRead, H1y, foetest.ini, positions, h1y
	IniRead, H2x, foetest.ini, positions, h2x
	IniRead, H2y, foetest.ini, positions, h2y
	IniRead, H3x, foetest.ini, positions, h3x
	IniRead, H3y, foetest.ini, positions, h3y
	IniRead, H4x, foetest.ini, positions, h4x
	IniRead, H4y, foetest.ini, positions, h4y
	IniRead, H5x, foetest.ini, positions, h5x
	IniRead, H5y, foetest.ini, positions, h5y
	IniRead, BPx, foetest.ini, positions, bpx
	IniRead, BPy, foetest.ini, positions, bpy
	IniRead, BPcolor, foetest.ini, positions, bpcolor
	} else {
		NHx:=0
		NHy:=0
		GDx:=0
		GDy:=0
		FLx:=0
		FLy:=0
		Nextx:=0
		Nexty:=0
		Firstx:=0
		Firsty:=0
		H1x:=0
		H1y:=0
		H2x:=0
		H2y:=0
		H3x:=0
		H3y:=0
		H4x:=0
		H4y:=0
		H5x:=0
		H5y:=0
		BPx:=0
		BPy:=0
		BPcolor:=0
	}
	Gui, New
	Gui, Add, Picture, x12 y9 w60 h40 , C:\Users\uyve7bo\Pictures\nh.png
	Gui, Add, Picture, x12 y59 w60 h40 , C:\Users\uyve7bo\Pictures\gd.PNG
	Gui, Add, Picture, x12 y109 w60 h40 , C:\Users\uyve7bo\Pictures\fl.PNG
	Gui, Add, Picture, x42 y159 w30 h30 , C:\Users\uyve7bo\Pictures\next.PNG
	Gui, Add, Picture, x42 y199 w30 h30 , C:\Users\uyve7bo\Pictures\SL.PNG
	Gui, Add, Text, x82 y19 w20 h20 +Right, X:
	Gui, Add, Text, x82 y69 w20 h20 +Right, X:
	Gui, Add, Text, x82 y119 w20 h20 +Right, X:
	Gui, Add, Text, x82 y169 w20 h20 +Right, X:
	Gui, Add, Text, x82 y209 w20 h20 +Right, X:
	Gui, Add, Edit, x112 y69 w60 h20 +vGDx, %GDx%
	Gui, Add, Edit, x112 y119 w60 h20 +vFLx, %FLx%
	Gui, Add, Edit, x112 y169 w60 h20 +vNextx, %Nextx%
	Gui, Add, Text, x182 y19 w20 h20 +Right, Y:
	Gui, Add, Text, x182 y69 w20 h20 +Right, Y:
	Gui, Add, Text, x182 y119 w20 h20 +Right, Y:
	Gui, Add, Text, x182 y169 w20 h20 +Right, Y:
	Gui, Add, Text, x182 y209 w20 h20 +Right, Y:
	Gui, Add, Edit, x212 y19 w60 h20 +vNHy, %NHy%
	Gui, Add, Edit, x212 y69 w60 h20 +vGDy, %GDy%
	Gui, Add, Edit, x212 y119 w60 h20 +vFLy, %FLy%
	Gui, Add, Edit, x212 y169 w60 h20 +vNexty, %Nexty%
	Gui, Add, Edit, x212 y209 w60 h20 +vFirsty, %Firsty%
	Gui, Add, Edit, x112 y209 w60 h20 +vFirstx, %Firstx%
	Gui, Add, Edit, x112 y19 w60 h20 +vNHx, %NHx%
	Gui, Add, Button, x12 y469 w110 h30 gSaveConfig, Save
	Gui, Add, Button, x172 y469 w110 h30 gDestroyGui, Cancel
	Gui, Add, Text, x82 y249 w20 h20 +Right, X:
	Gui, Add, Edit, x112 y249 w60 h20 +vH1x, %H1x%
	Gui, Add, Text, x182 y249 w20 h20 +Right, Y:
	Gui, Add, Edit, x212 y249 w60 h20 +vH1y, %H1y%
	Gui, Add, Text, x82 y279 w20 h20 +Right, X:
	Gui, Add, Edit, x112 y279 w60 h20 +vH2x, %H2x%
	Gui, Add, Text, x182 y279 w20 h20 +Right, Y:
	Gui, Add, Edit, x212 y279 w60 h20 +vH2y, %H2y%
	Gui, Add, Text, x72 y429 w30 h20 +Right, Color:
	Gui, Add, Edit, x112 y429 w60 h20 +ReadOnly +vBPcolor, %BPcolor%
	Gui, Add, Edit, x112 y309 w60 h20 +vH3x, %H3x%
	Gui, Add, Edit, x212 y309 w60 h20 +vH3y, %H3y%
	Gui, Add, Text, x82 y309 w20 h20 +Right, X:
	Gui, Add, Text, x182 y309 w20 h20 +Right, Y:
	Gui, Add, Text, x82 y339 w20 h20 +Right, X:
	Gui, Add, Text, x182 y339 w20 h20 +Right, Y:
	Gui, Add, Edit, x112 y339 w60 h20 +vH4x, %H4x%
	Gui, Add, Edit, x212 y339 w60 h20 +vH4y, %H4y%
	Gui, Add, Text, x82 y369 w20 h20 +Right, X:
	Gui, Add, Edit, x112 y369 w60 h20 +vH5x, %H5x%
	Gui, Add, Text, x182 y369 w20 h20 +Right, Y:
	Gui, Add, Edit, x212 y369 w60 h20 +vH5y, %H5y%
	Gui, Add, Text, x82 y399 w20 h20 +Right, X:
	Gui, Add, Edit, x112 y399 w60 h20 +vBPx, %BPx%
	Gui, Add, Text, x182 y399 w20 h20 +Right, Y:
	Gui, Add, Edit, x212 y399 w60 h20 +vBPy, %BPy%
	Gui, Add, Text, x2 y249 w70 h20 +Right, Help Button 1:
	Gui, Add, Text, x2 y279 w70 h20 +Right, Help Button 2:
	Gui, Add, Text, x2 y309 w70 h20 +Right, Help Button 3:
	Gui, Add, Text, x2 y339 w70 h20 +Right, Help Button 4:
	Gui, Add, Text, x2 y369 w70 h20 +Right, Help Button 5:
	Gui, Add, Text, x2 y399 w70 h20 +Right, BP Close Button:
	Gui, Add, Button, x182 y429 w90 h20 +gGetBPColor, Get Color
	; Generated using SmartGUI Creator 4.0
	Gui, Show, x238 y148 h516 w302, FoEHelper Config
	tooltipcheck:=True
	while(tooltipcheck=True)
	{
		MouseGetPos, MouseX, MouseY
		PixelGetColor, MousePColor, %MouseX%, %MouseY%
		ToolTip, % "X: " MouseX " Y: " MouseY "`nColor: " MousePColor
	}
	ToolTip
Return

SaveConfig:
	tooltipcheck:=False
	Gui, Submit
	IniWrite, %NHx%, foetest.ini, positions, nhx
	IniWrite, %NHy%, foetest.ini, positions, nhy
	IniWrite, %GDx%, foetest.ini, positions, gdx
	IniWrite, %GDy%, foetest.ini, positions, gdy
	IniWrite, %FLy%, foetest.ini, positions, flx
	IniWrite, %FLy%, foetest.ini, positions, fly
	IniWrite, %Nextx%, foetest.ini, positions, Nextx
	IniWrite, %Nexty%, foetest.ini, positions, Nexty
	IniWrite, %Firstx%, foetest.ini, positions, Firstx
	IniWrite, %Firsty%, foetest.ini, positions, Firsty
	IniWrite, %H1x%, foetest.ini, positions, h1x
	IniWrite, %H1y%, foetest.ini, positions, h1y
	IniWrite, %H2x%, foetest.ini, positions, h2x
	IniWrite, %H2y%, foetest.ini, positions, h2y
	IniWrite, %H3x%, foetest.ini, positions, h3x
	IniWrite, %H3y%, foetest.ini, positions, h3y
	IniWrite, %H4x%, foetest.ini, positions, h4x
	IniWrite, %H4y%, foetest.ini, positions, h4y
	IniWrite, %H5x%, foetest.ini, positions, h5x
	IniWrite, %H5y%, foetest.ini, positions, h5y
	IniWrite, %BPx%, foetest.ini, positions, bpx
	IniWrite, %BPy%, foetest.ini, positions, bpy
	IniWrite, %BPcolor%, foetest.ini, positions, bpcolor
	Gui, Destroy
return

GetBPColor:
	ControlGetText, colorBPx, Edit22
	ControlGetText, colorBPy, Edit23
	IfWinNotActive, Forge of Empires 
	{
		ToolTip, Please open FOE
		WinWaitActive, Forge of Empires
	}
	ToolTip
	MouseMove, %colorBPx%, %colorBPy%, 5
	PixelGetColor, GetBPColor, %colorBPx%, %colorBPy%
	GuiControl,, %BPColor%, %GetBPColor%
return

DestroyGui:
	tooltipcheck:=False
	Gui, Destroy
return

CancelExit:
	ExitApp
return

GuiClose:
	ExitApp
return
