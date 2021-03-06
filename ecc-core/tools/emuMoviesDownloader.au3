; ------------------------------------------------------------------------------
; Script for             : EmuMoviesDownloader (EMD)
; Script version         : v1.2.1.3
; Last changed           : 2014.11.20
;
; Author: Sebastiaan Ebeltjes (AKA Phoenix)
;
; NOTES: None yet!
;
; ------------------------------------------------------------------------------
FileChangeDir(@ScriptDir)
#include "eccToolVariables.au3"

Global $EmuMoviesName = BinaryToString(_Crypt_DecryptData(Iniread(@Scriptdir & "\emuMoviesDownloader.ini", "data", "name", ""), $EmuMovieshKey, $CALG_AES_128))
Global $EmuMoviesPass = BinaryToString(_Crypt_DecryptData(Iniread(@Scriptdir & "\emuMoviesDownloader.ini", "data", "pass", ""), $EmuMovieshKey, $CALG_AES_128))
Global $EmuMoviesId

Select
	Case $CmdLine[0] = 0
		Main()

	Case $CmdLine[1] = "accountdata"
		EnterLoginData()
		Exit

EndSelect

Func Main()
; Exit if user wants to download from the ECC menu "ALL PLATFORMS", this is not possible, $RomEccId = ""
If $RomEccId = "" Then
	ToolTip("You cannot download content for ALL platforms at once!", @DesktopWidth/2, @DesktopHeight/2, "EMD", 1, 6)
	Sleep(1500)
	Exit
EndIf

; Check if this platform is available on EmuMovies.
$EmuMoviesListData = IniReadSection($EmuMoviesList, "DATA")
For $i = 1 To $EmuMoviesListData[0][0]
If $EmuMoviesListData[$i][0] = $RomEccId Then $EmuMoviesId = $EmuMoviesListData[$i][1]
Next
If $EmuMoviesId = "" Then
	ToolTip("This platform is NOT available on EmuMovies!", @DesktopWidth/2, @DesktopHeight/2, "EMD", 1, 6)
	Sleep(1500)
	Exit
EndIf

; Check if user has entered accountdata.
If $EmuMoviesName = "" Or $EmuMoviesPass = "" Then
	EnterLoginData()
	Exit
EndIf

; Check: writable media...
ToolTip("Check if media is writable...!", @DesktopWidth/2, @DesktopHeight/2, "EMD", 1, 6)

Global $eccDummyFile = @ScriptDir & "\emuMoviesDownloader.dummy"
$FileToWrite = FileOpen($eccDummyFile, 10)
FileWrite($FileToWrite, "Dummy")
FileClose($FileToWrite)
If FileExists($eccDummyFile) Then
	If FileGetSize($eccDummyFile) < 4 Then
		ToolTip("This media is not writable!", @DesktopWidth/2, @DesktopHeight/2, "EMD", 1, 6)
		Sleep(1500)
		Exit
	EndIf
Else
	ToolTip("This media is not writable!", @DesktopWidth/2, @DesktopHeight/2, "EMD", 1, 6)
	Sleep(1500)
	Exit
EndIf

; Check if 7zip is working...
ToolTip("Check if 7zip is working...!", @DesktopWidth/2, @DesktopHeight/2, "EMD", 1, 6)
ShellExecuteWait($7zexe, "a eccUpdate.7z " & Chr(34) & $eccDummyFile & Chr(34) & " -o" & Chr(34) & @ScriptDir & Chr(34) & " -y", "", "", @SW_HIDE)
If FileExists(@ScriptDir & "\eccUpdate.7z") Then
	If FileGetSize(@ScriptDir & "\eccUpdate.7z") < 100 Then
		ToolTip("7Zip is not working properly!", @DesktopWidth/2, @DesktopHeight/2, "EMD", 1, 6)
		Sleep(1500)
		Exit
	EndIf
Else
	ToolTip("7Zip is not working properly!", @DesktopWidth/2, @DesktopHeight/2, "EMD", 1, 6)
	Sleep(1500)
	Exit
EndIf
FileDelete($eccDummyFile)
FileDelete(@ScriptDir & "\eccUpdate.7z")

; Retrieve ROMlist from ECC
ToolTip("Retrieving ROMlist from ECC database!", @DesktopWidth/2, @DesktopHeight/2, "EMD", 1, 6)

$INSTFile = Fileopen($SQLInstructionFile, 10)
FileWriteLine($INSTFile, ".separator ;")
FileWriteLine($INSTFile, ".output " & $PlatformDataFile)
FileWriteLine($INSTFile, "SELECT crc32, title FROM fdata WHERE eccident='" & $RomEccId & "';")
FileClose($INSTFile)

; It's not possible to execute the sqlite.exe with these command's, so we have to create a .BAT or .CMD file and then run that file.
; ShellExecuteWait($SQliteExe, Chr(34) & $eccDataBaseFile & Chr(34) & " <" & Chr(34) & $SQLcommandFile & Chr(34), @ScriptDir)
; RunWait(Chr(34) & $SQliteExe & Chr(34) & " " & Chr(34) & $eccDataBaseFile & Chr(34) & " <" & Chr(34) & $SQLcommandFile & Chr(34), @ScriptDir)

$CMDFile = Fileopen($SQLcommandFile, 10)
FileWrite($CMDFile, Chr(34) & $SQliteExe & Chr(34) & " " & Chr(34) & $eccDataBaseFile & Chr(34) & " <" & Chr(34) & $SQLInstructionFile & Chr(34))
FileClose($CMDFile)

RunWait(Chr(34) & $SQLcommandFile & Chr(34), @ScriptDir, @SW_HIDE) ; Execute the CMD file with the query

; Delete the temporally files
FileDelete($SQLInstructionFile)
FileDelete($SQLcommandFile)
Sleep(1000)
ToolTip("")

; Exit if user has no ROMS imported for the platform
If FileGetSize(@ScriptDir & "\" & $PlatformDataFile) < 8 Then
	ToolTip("No imported ROMS found for this platform!", @DesktopWidth/2, @DesktopHeight/2, "EMD", 1, 6)
	Sleep(1500)
	Exit
Else
	;Count ROMS that the user has imported into ECC.
	$PlatFormRomCountUser = _FileCountLines(@ScriptDir & "\" & $PlatformDataFile)
EndIf

ToolTip("Login to EmuMovies...", @DesktopWidth/2, @DesktopHeight/2, "EMD", 1, 6)
$EmuMoviesCache = InetRead($EmuMoviesServer & "login.aspx?user=" & _UnicodeURLEncode($EmuMoviesName) & "&api=" & _UnicodeURLEncode($EmuMoviesPass) & "&product=" & $eccSig, 1) ;Download Login results
If StringLen($EmuMoviesCache) < 1 Then
	ToolTip("")
	MsgBox(64, "ECC EmuMovies Downloader", "No response from the EmuMovies server..." & @CRLF & "it could be offline or you have no internet connection!")
	Exit
EndIf
ToolTip("")
_XMLFileOpen($EmuMoviesCache)
Global $LoginOk = _XMLGetAttrib("/Results/Result", "Success")
Global $SessionID = _XMLGetAttrib("/Results/Result", "Session")
Global $Error = _XMLGetAttrib("/Results/Result", "Error")
Global $Message = _XMLGetAttrib("/Results/Result", "MSG")

If $LoginOk = "False" Then
	If $Error = "True" Then
		MsgBox(64, "ECC EmuMovies Downloader", "Server message: " & $Message)
		Exit
	Else
		MsgBox(64, "ECC EmuMovies Downloader", "Something went wrong!")
		Exit
	EndIf
EndIf

; $LoginOk = "True"
ToolTip("Downloading SYSTEM data...", @DesktopWidth/2, @DesktopHeight/2, "EMD", 1, 6)
Global $EmuMoviesSystemCacheTemp = InetRead($EmuMoviesServer & "getsystems.aspx?sessionid=" & $SessionID & "&product=" & $eccSig, 1) ;Download Systems XML

$FileHandleOut = FileOpen("Arcade.md", 1)
FileWriteLine($FileHandleOut, $EmuMoviesSystemCacheTemp)
FileClose($FileHandleOut)


Global $EmuMoviesSystemCache = StringToBinary("<Root>") & $EmuMoviesSystemCacheTemp & StringToBinary("</Root>") ;Add a 'virtual' ROOT node to make it a proper XML file.
;~ ToolTip("Downloading MEDIA data...", @DesktopWidth/2, @DesktopHeight/2, "EMD", 1, 6)
;~ InetGet($EmuMoviesServer & "getmedias.aspx?sessionid=" & $SessionID, $EmuMoviesMediaFile, 1) ; Download Media XML
ToolTip("")

_XMLFileOpen($EmuMoviesSystemCache)
Global $PlatformMedia = _XMLGetAttrib("/Root/Systems/System[@Lookup='" & $EmuMoviesId & "']", "Media")
Global $PlatformMediaX = StringSplit($PlatformMedia, ",")
Global $PlatformMediaUpdated = _XMLGetAttrib("/Root/Systems/System[@Lookup='" & $EmuMoviesId & "']", "MediaUpdated")
Global $PlatformMediaUpdatedX = StringSplit($PlatformMediaUpdated, ",")

;==============================================================================
;BEGIN *** GUI
;==============================================================================
Global $EMDGUI = GUICreate("ECC EmuMoviesDownloader (EMD)", 550, 375, -1, -1)
GUISetBkColor(0xFFFFFF)
Global $DownloadBarImage = GUICtrlCreateProgress(0, 312, 422, 17)
Global $Label1 = GUICtrlCreateLabel("Downloading:", 0, 296, 92, 15)
GUICtrlSetFont(-1, 8, 800, 0, "Verdana")
GUICtrlSetColor(-1, 0x000000)
Global $Label3 = GUICtrlCreateLabel("ECC ID:", 272, 16, 52, 15, $SS_RIGHT)
GUICtrlSetFont(-1, 8, 800, 0, "Verdana")
GUICtrlSetColor(-1, 0x000000)
Global $Label4 = GUICtrlCreateLabel("CRC32:", 304, 296, 44, 15, $SS_RIGHT)
GUICtrlSetFont(-1, 8, 800, 0, "Verdana")
GUICtrlSetColor(-1, 0x000000)
Global $eccidLabel = GUICtrlCreateLabel("-", 336, 16, 68, 15)
GUICtrlSetFont(-1, 8, 800, 0, "Verdana")
GUICtrlSetColor(-1, 0x000080)
Global $crcLabel = GUICtrlCreateLabel("-", 352, 296, 68, 15)
GUICtrlSetFont(-1, 8, 800, 0, "Verdana")
GUICtrlSetColor(-1, 0x000080)
Global $Label6 = GUICtrlCreateLabel("Total platform progress:", 0, 336, 164, 15)
GUICtrlSetFont(-1, 8, 800, 0, "Verdana")
GUICtrlSetColor(-1, 0x000000)
Global $DownloadBarTotalPlatform = GUICtrlCreateProgress(0, 352, 422, 17)
Global $Label7 = GUICtrlCreateLabel("Remaining:", 288, 336, 76, 15, $SS_RIGHT)
GUICtrlSetFont(-1, 8, 800, 0, "Verdana")
GUICtrlSetColor(-1, 0x000000)
Global $RemainingPlatformLabel = GUICtrlCreateLabel("-", 368, 336, 52, 15)
GUICtrlSetFont(-1, 8, 800, 0, "Verdana")
GUICtrlSetColor(-1, 0x000080)
Global $ProcessingList = GUICtrlCreateEdit("", 0, 160, 545, 129, BitOR($ES_AUTOHSCROLL,$ES_READONLY,$ES_WANTRETURN,$WS_VSCROLL))
Global $MediaList = GUICtrlCreateListView("Media|Last updated", 0, 16, 266, 142)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 160)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 85)
GUICtrlSetBkColor(-1, 0xA6CAF0)
Global $ButtonOk = GUICtrlCreateButton("OK", 432, 296, 115, 33)
GUICtrlSetFont(-1, 9, 800, 2, "Verdana")
Global $Label2 = GUICtrlCreateLabel("Select content to download:", 0, 0, 180, 15)
GUICtrlSetFont(-1, 8, 800, 0, "Verdana")
GUICtrlSetColor(-1, 0x000000)
Global $Label5 = GUICtrlCreateLabel("EM ID:", 280, 32, 44, 15, $SS_RIGHT)
GUICtrlSetFont(-1, 8, 800, 0, "Verdana")
GUICtrlSetColor(-1, 0x000000)
Global $emidLabel = GUICtrlCreateLabel("-", 336, 32, 164, 15)
GUICtrlSetFont(-1, 8, 800, 0, "Verdana")
GUICtrlSetColor(-1, 0x000080)
Global $Picture = GUICtrlCreatePic("", 272, 64, 272, 90)
Global $ButtonCancel = GUICtrlCreateButton("CANCEL", 432, 336, 115, 33)
GUICtrlSetFont(-1, 9, 800, 2, "Verdana")
;==============================================================================
;END *** GUI
;==============================================================================

GUICtrlSetImage($Picture, @ScriptDir & "\emuMoviesDownloader_logo.gif")
GUISetIcon(@ScriptDir & "\emuMoviesDownloader.ico", "", $EMDGUI) ;Set proper icon for the window.
GUICtrlSetData($eccidLabel, $RomEccId)
GUICtrlSetData($emidLabel, $EmuMoviesId)

Global $row = 0
For $i = 1 to $PlatformMediaX[0] ;Fill the rows with only supported content from EmuMovies
	$ContentSupport = 0
	If $PlatformMediaX[$i] = "Title" Then $ContentSupport = 1
	If $PlatformMediaX[$i] = "Snap" Then $ContentSupport = 1
	If $PlatformMediaX[$i] = "Cart" Then $ContentSupport = 1
	If $PlatformMediaX[$i] = "PCB" Then $ContentSupport = 1
	If $PlatformMediaX[$i] = "CartTop" Then $ContentSupport = 1
	If $PlatformMediaX[$i] = "Box_3D" Then $ContentSupport = 1
	If $PlatformMediaX[$i] = "Box" Then $ContentSupport = 1
	If $PlatformMediaX[$i] = "BoxBack" Then $ContentSupport = 1
	If $PlatformMediaX[$i] = "Icon" Then $ContentSupport = 1
	If $PlatformMediaX[$i] = "Advert" Then $ContentSupport = 1
	If $PlatformMediaX[$i] = "Banner" Then $ContentSupport = 1
	If $PlatformMediaX[$i] = "Artwork" Then $ContentSupport = 1
	If $PlatformMediaX[$i] = "Artwork_Preview" Then $ContentSupport = 1
	If $PlatformMediaX[$i] = "Video_FLV_HI_QUAL" Then $ContentSupport = 1
	If $PlatformMediaX[$i] = "Video_MP4" Then $ContentSupport = 1
	If $PlatformMediaX[$i] = "Video_MP4_HI_QUAL" Then $ContentSupport = 1

	If  $ContentSupport = 1 Then
		_GUICtrlListView_AddItem($MediaList, "", $row)
		_GUICtrlListView_AddSubItem($MediaList, $row, $PlatformMediaX[$i], 0)
		_GUICtrlListView_AddSubItem($MediaList, $row, $PlatformMediaUpdatedX[$i], 1)
		$row = $row + 1
	EndIf
Next

GUISetState(@SW_SHOW, $EMDGUI)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $ButtonCancel
			Exit

		Case $ButtonOk
			Global $eccMediaType = "", $MediaPath
			GUICtrlSetData($ProcessingList, "") ;Clear processing list
			$SelectedRow = _GUICtrlListView_GetItemTextString($MediaList) ;Get current rowselection
			$RowData = StringSplit($SelectedRow, "|")
			Global $SelectedMedia = $Rowdata[1]

			If $SelectedMedia = "Title" Then
				$eccMediaType = "_ingame_title"
				$MediaPath = "images"
			EndIf

			If $SelectedMedia = "Snap" Then
				$eccMediaType = "_ingame_play_01"
				$MediaPath = "images"
			EndIf

			If $SelectedMedia = "Cart" Then
				$eccMediaType = "_media_storage"
				$MediaPath = "images"
			EndIf

			If $SelectedMedia = "CartTop" Then
				$eccMediaType = "_media_stor_02"
				$MediaPath = "images"
			EndIf

			If $SelectedMedia = "PCB" Then
				$eccMediaType = "_media_stor_03"
				$MediaPath = "images"
			EndIf

			If $SelectedMedia = "Box" Then
				$eccMediaType = "_cover_front"
				$MediaPath = "images"
			EndIf

			If $SelectedMedia = "BoxBack" Then
				$eccMediaType = "_cover_back"
				$MediaPath = "images"
			EndIf

			If $SelectedMedia = "Box_3D" Then
				$eccMediaType = "_cover_3d"
				$MediaPath = "images"
			EndIf

			If $SelectedMedia = "Icon" Then
				$eccMediaType = "_media_icon"
				$MediaPath = "images"
			EndiF

			If $SelectedMedia = "Advert" Then
				$eccMediaType = "_media_flyer"
				$MediaPath = "images"
			EndIf

			If $SelectedMedia = "Banner" Then
				$eccMediaType = "_media_flyer_02"
				$MediaPath = "images"
			EndIf

			If $SelectedMedia = "Artwork" Then
				$eccMediaType = "_media_flyer_03"
				$MediaPath = "images"
			EndIf

			If $SelectedMedia = "Artwork_Preview" Then
				$eccMediaType = "_media_flyer_04"
				$MediaPath = "images"
			EndIf

			If $SelectedMedia = "Video_FLV" Then
				$eccMediaType = ""
				$MediaPath = "videos"
			EndIf

			If $SelectedMedia = "Video_FLV_HI_QUAL" Then
				$eccMediaType = ""
				$MediaPath = "videos"
			EndIf

			If $SelectedMedia = "Video_MP4" Then
				$eccMediaType = ""
				$MediaPath = "videos"
			EndIf

			If $SelectedMedia = "Video_MP4_HI_QUAL" Then
				$eccMediaType = ""
				$MediaPath = "videos"
			EndIf

			If $MediaPath <> "" Then
				Global $FilesDownloaded = 0
				GUICtrlSetState($ButtonOk, $GUI_DISABLE)
				GUICtrlSetState($MediaList, $GUI_DISABLE)
				$RomDataFile = Fileopen(@ScriptDir & "\" & $PlatformDataFile)

				For $imagecount = 1 to $PlatFormRomCountUser
					$ReadRomData = StringSplit(FileReadLine($RomDataFile, $imagecount), ";") ;$ReadRomData[1] = CRC32, $ReadRomData[2] = ROM Filename
					If @error = -1 Then ExitLoop
					AddNote("searching for: " & FixRomName($ReadRomData[2]) & " {Media: " & StringReplace($SelectedMedia, "_", "") & "}...")
					Global $ImageFolderLocal = $eccUserPath & $RomEccId & "\" & $MediaPath & "\" & StringLeft($ReadRomData[1], 2) & "\" & $ReadRomData[1] & "\" ;Constuct local image folder
					Global $FileNameToSaveJPG = "ecc_" & $RomEccId & "_" & $ReadRomData[1] & $eccMediaType & ".jpg" ;Construct JPG image filename
					Global $FileNameToSavePNG = "ecc_" & $RomEccId & "_" & $ReadRomData[1] & $eccMediaType & ".png" ;Construct PNG image filename
					Global $FileNameToSaveMP4 = "ecc_" & $RomEccId & "_" & $ReadRomData[1] & $eccMediaType & ".mp4" ;Construct MP4 video filename
					Global $FileNameToSaveFLV = "ecc_" & $RomEccId & "_" & $ReadRomData[1] & $eccMediaType & ".flv" ;Construct FLV video filename
					;Global $FileNameToSaveZIP = "ecc_" & $RomEccId & "_" & $ReadRomData[1] & $eccMediaType & ".zip" ;Construct ZIP file filename

					;Check if content already exists...do NOT add doubles!
					Global $FileNameToSave = "dummy"; we need the DUMMY otherwise it will also search for folders...
					If FileExists($ImageFolderLocal & $FileNameToSaveJPG) Then $FileNameToSave = $FileNameToSaveJPG
					If FileExists($ImageFolderLocal & $FileNameToSavePNG) Then $FileNameToSave = $FileNameToSavePNG
					If FileExists($ImageFolderLocal & $FileNameToSaveMP4) Then $FileNameToSave = $FileNameToSaveMP4
					If FileExists($ImageFolderLocal & $FileNameToSaveFLV) Then $FileNameToSave = $FileNameToSaveFLV
					;If FileExists($ImageFolderLocal & $FileNameToSaveZIP) Then $FileNameToSave = $FileNameToSaveZIP

					If FileExists($ImageFolderLocal & $FileNameToSave) = 0 Then ;Do not overwrite existing files!
						Global $EmuMoviesRomImageSearch = InetRead($EmuMoviesServer & "search.aspx?search=" & _UnicodeURLEncode(FixRomName($ReadRomData[2])) & "&system=" & $EmuMoviesId & "&media=" & $SelectedMedia & "&sessionid=" & $SessionID & "&product=" & $eccSig, 1) ; Download Rom image XML
						_XMLFileOpen($EmuMoviesRomImageSearch)
						Global $ContentFound = _XMLGetAttrib("/Results/Result", "Found")
						Global $Error = _XMLGetAttrib("/Results/Result", "Error")
						Global $Message = _XMLGetAttrib("/Results/Result", "MSG")

						If $ContentFound = "True" Then
							AddNote("found!#")
							Global $ImageUrl = _XMLGetAttrib("/Results/Result", "URL")
							Global $ImageExtension = StringLower(StringRight($ImageUrl, 3))
							Global $ImageFileSize = InetGetSize($ImageUrl)
							Global $FileNameToSave = "ecc_" & $RomEccId & "_" & $ReadRomData[1] & $eccMediaType & "." & $ImageExtension ;Construct FOUND image filename

							DirCreate($ImageFolderLocal)
							GUICtrlSetData($crcLabel, $ReadRomData[1])
							GUICtrlSetData($RemainingPlatformLabel, $PlatFormRomCountUser - $imageCount)
							$DownloadProcentTotal = ((($imageCount)/$PlatFormRomCountUser) * 100)
							GUICtrlSetData($DownloadBarTotalPlatform, $DownloadProcentTotal)

							AddNote("downloading: " & $ReadRomData[2] & "...")
							$FileDownloadHandle = InetGet($ImageUrl, $ImageFolderLocal & $FileNameToSave, 1, 1)

							Do
								$InetBytesRead = InetGetInfo($FileDownloadHandle, 0)
								$DownloadProcentImage = (($InetBytesRead/$ImageFileSize) * 100)
								GUICtrlSetData($DownloadBarImage, $DownloadProcentImage)

								If GUIGetMsg($EMDGUI) = $GUI_EVENT_CLOSE Then
									InetClose($FileDownloadHandle) ;Close the handle to release resources.
									FileDelete($ImageFolderLocal & $FileNameToSave) ;Delete unfnished content
									Exit
								EndIf

								If GUIGetMsg($EMDGUI) = $ButtonCancel Then
									InetClose($FileDownloadHandle) ;Close the handle to release resources.
									FileDelete($ImageFolderLocal & $FileNameToSave) ;Delete unfnished content
									Exit
								EndIf

							Until InetGetInfo($FileDownloadHandle, 2) ;Check if the download is complete.

							AddNote("complete!#")


							; Handle ZIP files for MAME "Artwork", there could be more platforms later on.
							; ALL Artwork seems to be in a ZIP file, and the image seems to be [romfilename].PNG format
							If $ImageExtension = "zip" And $RomEccId = "mame" Then
								AddNote("extracting images for: " & $ReadRomData[2] & "...")
								ShellExecuteWait($7zexe, "e -y " & Chr(34) & $ImageFolderLocal & $FileNameToSave & Chr(34) & " -o" & Chr(34) & $ImageFolderLocal & Chr(34) & " " & Chr(34) & $ReadRomData[2] & ".png" & Chr(34), "", "", @SW_HIDE)
								$FileNameToSavePNG = "ecc_" & $RomEccId & "_" & $ReadRomData[1] & $eccMediaType & ".png"
								FileMove($ImageFolderLocal & $ReadRomData[2] & ".png", $ImageFolderLocal & $FileNameToSavePNG) ; Rename the extracted file to the proper ECC filename
								FileDelete($ImageFolderLocal & $FileNameToSave) ;Delete ZIP file
								AddNote("complete!#")
							EndIf


							GUICtrlSetData($crcLabel, "-")
							GUICtrlSetData($DownloadBarImage, 0)

							$FilesDownloaded = $FilesDownloaded + 1
							Sleep(100)
						Else
							AddNote("not found!#")
							GUICtrlSetData($RemainingPlatformLabel, $PlatFormRomCountUser - $imageCount)
							$DownloadProcentTotal = ((($imageCount)/$PlatFormRomCountUser) * 100)
							GUICtrlSetData($DownloadBarTotalPlatform, $DownloadProcentTotal)
						EndIf

					Else
						AddNote("media already exists, skipping...#")
						GUICtrlSetData($RemainingPlatformLabel, $PlatFormRomCountUser - $imageCount)
						$DownloadProcentTotal = ((($imageCount)/$PlatFormRomCountUser) * 100)
						GUICtrlSetData($DownloadBarTotalPlatform, $DownloadProcentTotal)
					EndIf


					If $Error = "True" Then
						MsgBox(64, "ECC EmuMovies Downloader", "Server message: " & $Message)
						Exit
					EndIf

				Next
				FileClose($RomDataFile)
				GUICtrlSetData($DownloadBarTotalPlatform, 0)
				GUICtrlSetData($DownloadBarImage, 0)
				GUICtrlSetState($ButtonOk, $GUI_ENABLE)
				GUICtrlSetState($MediaList, $GUI_ENABLE)
				ToolTip($FilesDownloaded & " NEW files downloaded!", @DesktopWidth/2, @DesktopHeight/2, "EMD", 1, 6)
				Sleep(2000)
				Tooltip("")
			Else
				ToolTip("This content is not supported by ECC, please select another content...", @DesktopWidth/2, @DesktopHeight/2, "EMD", 1, 6)
				Sleep(2000)
				Tooltip("")
			EndIf

	EndSwitch
WEnd

EndFunc


Func EnterLoginData()
;==============================================================================
;BEGIN *** GUI
;==============================================================================
Global $EMDAccountDataGui = GUICreate("EmuMovies Account Data", 290, 257, -1, -1)
GUISetBkColor(0xFFFFFF)
Global $Group1 = GUICtrlCreateGroup(" Login Data ", 8, 48, 273, 105)
GUICtrlSetFont(-1, 8, 800, 2, "Verdana")
Global $UserName = GUICtrlCreateInput("", 80, 72, 193, 21)
GUICtrlSetBkColor(-1, 0xA6CAF0)
Global $UserPass = GUICtrlCreateInput("", 80, 96, 193, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
GUICtrlSetBkColor(-1, 0xA6CAF0)
Global $KnopOK = GUICtrlCreateButton("OK", 120, 120, 75, 25)
GUICtrlSetFont(-1, 10, 800, 2, "Verdana")
Global $KnopCancel = GUICtrlCreateButton("CANCEL", 200, 120, 75, 25)
GUICtrlSetFont(-1, 10, 800, 2, "Verdana")
Global $Login = GUICtrlCreateLabel("Name:", 32, 72, 44, 17, $SS_RIGHT)
GUICtrlSetFont(-1, 8, 400, 0, "Verdana")
Global $Label1 = GUICtrlCreateLabel("Password:", 16, 96, 62, 17, $SS_RIGHT)
GUICtrlSetFont(-1, 8, 400, 0, "Verdana")
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $Edit1 = GUICtrlCreateEdit("", 8, 0, 273, 49, BitOR($ES_READONLY,$ES_WANTRETURN))
GUICtrlSetData(-1, StringFormat("Enter your EmuMovies account data here.\r\nyou can create an account on EmuMovies for free!\r\nto visit the website click on the banner underneath."))
Global $Picture = GUICtrlCreatePic("", 8, 160, 272, 90)
GUICtrlSetTip(-1, "Click to visit website.")
;==============================================================================
;END *** GUI
;==============================================================================
GUICtrlSetImage($Picture, @ScriptDir & "\emuMoviesDownloader_logo.gif")
If Iniread(@Scriptdir & "\emuMoviesDownloader.ini", "data", "name", "") = "" Then $EmuMoviesName = ""
If Iniread(@Scriptdir & "\emuMoviesDownloader.ini", "data", "pass", "") = "" Then $EmuMoviesPass = ""
GUICtrlSetData($UserName, $EmuMoviesName)
GUICtrlSetData($UserPass, $EmuMoviesPass)
GUISetState(@SW_SHOW, $EMDAccountDataGui)
GUISetIcon(@ScriptDir & "\emuMoviesDownloader_login.ico", "", $EMDAccountDataGui) ;Set proper icon for the window.

While 1
	$nMsg = GUIGetMsg($EMDAccountDataGui)
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $KnopCancel
			Exit
		Case $Picture
			Run(@comspec & " /c start " & $EmuMoviesWebsite, "", @SW_HIDE)
		Case $KnopOK
			IniWrite(@ScriptDir & "\emuMoviesDownloader.ini", "DATA", "name", _Crypt_EncryptData(GUICtrlRead($UserName), $EmuMovieshKey, $CALG_AES_128))
			IniWrite(@ScriptDir & "\emuMoviesDownloader.ini", "DATA", "pass", _Crypt_EncryptData(GUICtrlRead($UserPass), $EmuMovieshKey, $CALG_AES_128))
			ExitLoop
	EndSwitch
Sleep(10)
WEnd
EndFunc ;EnterLoginData


Func FixRomName($RomNameToFix)
$RomNameBack = $RomNameToFix

;Fix the ROM title if nessesary
If StringInStr($RomNameBack, " (") Then
	$FixedRomName = StringSplit($RomNameBack, " (", 1)
	$RomNameBack = $FixedRomName[1]
EndIf

If StringInStr($RomNameBack, " [") Then
	$FixedRomName = StringSplit($RomNameBack, " [", 1)
	$RomNameBack = $FixedRomName[1]
EndIf

Return $RomNameBack
EndFunc ;FixRomName()


Func AddNote($string)
Global $totalstring
$string = StringReplace($string, "#", @CRLF)
$totalstring = $totalstring & $string
GUICtrlSetData($ProcessingList, $totalstring)
_GUICtrlEdit_LineScroll($ProcessingList, 0, _GUICtrlEdit_GetLineCount($ProcessingList))
EndFunc ;Addnote