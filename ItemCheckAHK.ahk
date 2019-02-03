#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force
#include <Vis2>
#Persistent
;   OCR script taken from https://github.com/iseahound/Vis2

; TODO
;   give credit for the ocr
;   Highlight the highest price
;   Different way to display text to allow more customization
;   Look into combining hak and python so I can have one python file with functions and just call them instead of several files
;   If I have a database, that could catch ocr errors


;   Total execution time with new items         :   3.86 seconds
;   Total execution time with existing items    :   3.20 seconds




URL = https://api.warframe.market/v1/items/
URLEnd = /statistics
PrScDir = E:\ShareX\Screenshots\newScreenshot.jpg
PrScDirNew = E:\ahkocr\images\relicScreen.jpg

^q::
{
    StartTime := A_TickCount

    

    Send {PrintScreen}

    Loop
    {   
        if FileExist("E:\ShareX\Screenshots\newScreenshot.jpg")
        {
            FileMove, %PrScDir%, %PrScDirNew%, 1
            Break
        }
    Sleep, 50
    }
    


    msgbox, take a break have a kitkat

      
    Run, python E:/ahkocr/imageTransform.py,,Hide
    Sleep, 500

    SplashImage, %PrScDirNew%, b
    
    ;---------- First Item Scan and Check ----------
    itemScanOriginal := OCR([168, 433, 380, 50])

    FileAppend, %itemScanOriginal%`n, itemresults.txt

    CharRemove := RegExReplace(itemScanOriginal, "[^a-zA-Z ]", "")
    itemScan := StrReplace(CharRemove, A_Space, "_")
    StringLower, itemScan, itemScan

    FileAppend, %itemScan%`n, itemresults.txt

    ; Checking if the item is a frame set, as api link doesnt include "_blueprint" at the end
    if InStr(itemScan, "neuroptics")
    {    
        ItemScanNew := StrReplace(ItemScan, "_blueprint", "")
        FileAppend, %ItemScanNew%`n, itemresults.txt
        ItemScan := ItemScanNew
    }
    else if InStr(itemScan,"chassis")
    {    
        ItemScanNew := StrReplace(ItemScan, "_blueprint", "")
        FileAppend, %ItemScanNew%`n, itemresults.txt
        ItemScan := ItemScanNew
    }
    else if InStr(itemScan,"systems")
    {    
        ItemScanNew := StrReplace(ItemScan, "_blueprint", "")
        FileAppend, %ItemScanNew%`n, itemresults.txt
        ItemScan := ItemScanNew
    }

    FilePath = itemLibrary/%itemScan%.json
    if FileExist(FilePath)
    {
       FileRead, apiText1, %FilePath%
    }
    else
    {
        NewURL = %URL%%itemScan%%URLEnd%
        UrlDownloadToFile, %NewURL%, %FilePath%
        FileRead, apiText1, %FilePath%
    }
    apiText := SubStr(apiText1, 1, 500)
    ValueFound := RegExMatch(apiText, ".min_price"": (\d.*?)", subpat)
    
    FirstItem = %ItemScan% is : %subpat1% platinum

    ElapsedTime :=  A_TickCount - StartTime
    ElapsedTime /= 1000.0
    FileAppend, First item done at  : %ElapsedTime% `n, executionTime.txt


    ;---------- Second Item Scan and Check ----------
    itemScanOriginal := OCR([566, 452, 380, 31])
    
    FileAppend, `n%itemScanOriginal%`n, itemresults.txt

    CharRemove := RegExReplace(itemScanOriginal, "[^a-zA-Z ]", "")
    itemScan := StrReplace(CharRemove, A_Space, "_")
    StringLower, itemScan, itemScan

    FileAppend, %itemScan%`n, itemresults.txt

    ; Checking if the item is a frame set, as api link doesnt include "_blueprint" at the end
    if InStr(itemScan, "neuroptics")
    {    
        ItemScanNew := StrReplace(ItemScan, "_blueprint", "")
        FileAppend, %ItemScanNew%`n`n, itemresults.txt
        ItemScan := ItemScanNew
    }
    else if InStr(itemScan,"chassis")
    {    
        ItemScanNew := StrReplace(ItemScan, "_blueprint", "")
        FileAppend, %ItemScanNew%`n`n, itemresults.txt
        ItemScan := ItemScanNew
    }
    else if InStr(itemScan,"systems")
    {    
        ItemScanNew := StrReplace(ItemScan, "_blueprint", "")
        FileAppend, %ItemScanNew%`n`n, itemresults.txt
        ItemScan := ItemScanNew
    }

    FilePath = itemLibrary/%itemScan%.json
    if FileExist(FilePath)
    {
       FileRead, apiText1, %FilePath%
    }
    else
    {
        NewURL = %URL%%itemScan%%URLEnd%
        UrlDownloadToFile, %NewURL%, %FilePath%
        FileRead, apiText1, %FilePath%
    }
    apiText := SubStr(apiText1, 1, 500)
    ValueFound := RegExMatch(apiText, ".min_price"": (\d.*?)", subpat)
    
    SecondItem =  %ItemScan% is : %subpat1% platinum

    ElapsedTime :=  A_TickCount - StartTime
    ElapsedTime /= 1000.0
    FileAppend, Second item done at : %ElapsedTime% `n, executionTime.txt



    ;---------- Third Item Scan and Check ----------
    itemScanOriginal := OCR([971, 452, 380, 31])
    
    FileAppend, %itemScanOriginal%`n, itemresults.txt

    CharRemove := RegExReplace(itemScanOriginal, "[^a-zA-Z ]", "")
    itemScan := StrReplace(CharRemove, A_Space, "_")
    StringLower, itemScan, itemScan

    FileAppend, %itemScan%`n, itemresults.txt

    ; Checking if the item is a frame set, as api link doesnt include "_blueprint" at the end
    if InStr(itemScan, "neuroptics")
    {    
        ItemScanNew := StrReplace(ItemScan, "_blueprint", "")
        FileAppend, %ItemScanNew%`n, itemresults.txt
        ItemScan := ItemScanNew
    }
    else if InStr(itemScan,"chassis")
    {    
        ItemScanNew := StrReplace(ItemScan, "_blueprint", "")
        FileAppend, %ItemScanNew%`n, itemresults.txt
        ItemScan := ItemScanNew
    }
    else if InStr(itemScan,"systems")
    {    
        ItemScanNew := StrReplace(ItemScan, "_blueprint", "")
        FileAppend, %ItemScanNew%`n, itemresults.txt
        ItemScan := ItemScanNew
    }

    FilePath = itemLibrary/%itemScan%.json
    if FileExist(FilePath)
    {
       FileRead, apiText1, %FilePath%
    }
    else
    {
        NewURL = %URL%%itemScan%%URLEnd%
        UrlDownloadToFile, %NewURL%, %FilePath%
        FileRead, apiText1, %FilePath%
    }
    apiText := SubStr(apiText1, 1, 500)
    ValueFound := RegExMatch(apiText, ".min_price"": (\d.*?)", subpat)
    
    ThirdItem =  %ItemScan% is : %subpat1% platinum

    ElapsedTime :=  A_TickCount - StartTime
    ElapsedTime /= 1000.0
    FileAppend, Third item done at  : %ElapsedTime% `n, executionTime.txt

    
    ;----------------------------------------------------------------------

    itemScanOriginal := OCR([1370, 452, 380, 31])
    
    FileAppend, %itemScanOriginal%`n, itemresults.txt

    CharRemove := RegExReplace(itemScanOriginal, "[^a-zA-Z ]", "")
    itemScan := StrReplace(CharRemove, A_Space, "_")
    StringLower, itemScan, itemScan

    FileAppend, %itemScan%`n, itemresults.txt

    ; Checking if the item is a frame set, as api link doesnt include "_blueprint" at the end
    if InStr(itemScan, "neuroptics")
    {    
        ItemScanNew := StrReplace(ItemScan, "_blueprint", "")
        FileAppend, %ItemScanNew%`n, itemresults.txt
        ItemScan := ItemScanNew
    }
    else if InStr(itemScan,"chassis")
    {    
        ItemScanNew := StrReplace(ItemScan, "_blueprint", "")
        FileAppend, %ItemScanNew%`n, itemresults.txt
        ItemScan := ItemScanNew
    }
    else if InStr(itemScan,"systems")
    {    
        ItemScanNew := StrReplace(ItemScan, "_blueprint", "")
        FileAppend, %ItemScanNew%`n, itemresults.txt
        ItemScan := ItemScanNew
    }

    ; Check if item is already in the database, if not download json file
    FilePath = itemLibrary/%itemScan%.json
    if FileExist(FilePath)
    {
       FileRead, apiText1, %FilePath%
    }
    else
    {
        NewURL = %URL%%itemScan%%URLEnd%
        UrlDownloadToFile, %NewURL%, %FilePath%
        FileRead, apiText1, %FilePath%
    }
    apiText := SubStr(apiText1, 1, 500)
    ValueFound := RegExMatch(apiText, ".min_price"": (\d.*?)", subpat)
    
    FourthItem =  %ItemScan% is : %subpat1% platinum

    ElapsedTime :=  A_TickCount - StartTime
    ElapsedTime /= 1000.0
    FileAppend, Fourth item done at : %ElapsedTime% `n, executionTime.txt

    
    ;----------------------------------------------------------------------
    SplashImage, Off

    SoundBeep, 1800, 150 
    ElapsedTime :=  A_TickCount - StartTime
    ElapsedTime /= 1000.0
    FileAppend, Total execution time is : %ElapsedTime% seconds`n`n, executionTime.txt

    MsgBox, %FirstItem%,`n%SecondItem%,`n%ThirdItem%,`n%FourthItem%`nin%ElapsedTime% seconds

    ;ToolTip,%FirstItem%, 168, 500, 1
    ;ToolTip,%SecondItem%, 566, 500, 2
    ;ToolTip,%ThirdItem%, 970, 500, 3
    ;ToolTip,%FourthItem%, 1370, 500, 4
    ;SetTimer, RemoveToolTip, -5000

    
}
Return




RemoveToolTip:
Loop,10{
    ToolTip, , , , % A_Index
}
return
