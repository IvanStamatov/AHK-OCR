#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force
#include <Vis2>
#Persistent


; TODO
;   check if file exists

;   error msg if price is not found (<1)
;   if name is not correctly transformed then price is always error

;   Highlight the hihest price
;   Different way to display text to allow more customization





;   Total execution time with new items         :   4.93000 seconds
;   Total execution time with existing items    :   3.62000 seconds
;   
;
;
;

URL = https://api.warframe.market/v1/items/
URLEnd = /statistics

^q::
{
    StartTime := A_TickCount

    ;---------- First Item Scan and Check ----------
    itemScanOriginal := OCR([168, 452, 380, 31])
    NewItemScanUnderscore := StrReplace(itemScanOriginal, A_Space, "_")
    StringLower, itemScan, NewItemScanUnderscore
    
    FilePath = jsons/%itemScan%.json
    if FileExist(FilePath)
    {
       FileRead, apiText1, jsons/%itemScan%.json
    }
    else
    {
        NewURL = %URL%%itemScan%%URLEnd%
        UrlDownloadToFile, %NewURL%, %FilePath%
        FileRead, apiText1, jsons/%itemScan%.json
    }
    apiText := SubStr(apiText1, 1, 500)
    ValueFound := RegExMatch(apiText, ".min_price"": (\d.*?)", subpat)
    
    FirstItem = Price is : %subpat1% platinum

    ElapsedTime :=  A_TickCount - StartTime
    ElapsedTime /= 1000.0
    FileAppend, First item done at  : %ElapsedTime% `n, executionTime.txt

    ;FileAppend, url = %NewURL%`nprice = %subpat1%`n%FirstItem%`n, itemsCheckup.txt
    ToolTip,%FirstItem%, 168, 500, 1



    ;---------- Second Item Scan and Check ----------
    itemScanOriginal := OCR([566, 452, 380, 31])
    NewItemScanUnderscore := StrReplace(itemScanOriginal, A_Space, "_")
    StringLower, itemScan, NewItemScanUnderscore

    FilePath = jsons/%itemScan%.json
    if FileExist(FilePath)
    {
       FileRead, apiText1, jsons/%itemScan%.json
    }
    else
    {
        NewURL = %URL%%itemScan%%URLEnd%
        UrlDownloadToFile, %NewURL%, %FilePath%
        FileRead, apiText1, jsons/%itemScan%.json
    }
    apiText := SubStr(apiText1, 1, 500)
    ValueFound := RegExMatch(apiText, ".min_price"": (\d.*?)", subpat)
    
    SecondItem = Price is : %subpat1% platinum

    ElapsedTime :=  A_TickCount - StartTime
    ElapsedTime /= 1000.0
    FileAppend, Second item done at : %ElapsedTime% `n, executionTime.txt

    ToolTip,%SecondItem%, 566, 500, 2



    ;---------- Third Item Scan and Check ----------
    itemScanOriginal := OCR([971, 452, 380, 31])
    NewItemScanUnderscore := StrReplace(itemScanOriginal, A_Space, "_")
    StringLower, itemScan, NewItemScanUnderscore

    FilePath = jsons/%itemScan%.json
    if FileExist(FilePath)
    {
       FileRead, apiText1, jsons/%itemScan%.json
    }
    else
    {
        NewURL = %URL%%itemScan%%URLEnd%
        UrlDownloadToFile, %NewURL%, %FilePath%
        FileRead, apiText1, jsons/%itemScan%.json
    }
    apiText := SubStr(apiText1, 1, 500)
    ValueFound := RegExMatch(apiText, ".min_price"": (\d.*?)", subpat)
    
    ThirdItem = Price is : %subpat1% platinum

    ElapsedTime :=  A_TickCount - StartTime
    ElapsedTime /= 1000.0
    FileAppend, Third item done at  : %ElapsedTime% `n, executionTime.txt

    ToolTip,%ThirdItem%, 970, 500, 3
    
    ;----------------------------------------------------------------------

    itemScanOriginal := OCR([1370, 452, 380, 31])
    NewItemScanUnderscore := StrReplace(itemScanOriginal, A_Space, "_")
    StringLower, itemScan, NewItemScanUnderscore

    FilePath = jsons/%itemScan%.json
    if FileExist(FilePath)
    {
       FileRead, apiText1, jsons/%itemScan%.json
    }
    else
    {
        NewURL = %URL%%itemScan%%URLEnd%
        UrlDownloadToFile, %NewURL%, %FilePath%
        FileRead, apiText1, jsons/%itemScan%.json
    }
    apiText := SubStr(apiText1, 1, 500)
    ValueFound := RegExMatch(apiText, ".min_price"": (\d.*?)", subpat)
    
    FourthItem = Price is : %subpat1% platinum

    ElapsedTime :=  A_TickCount - StartTime
    ElapsedTime /= 1000.0
    FileAppend, Fourth item done at : %ElapsedTime% `n, executionTime.txt

    ToolTip,%FourthItem%, 1370, 500, 4

    ;----------------------------------------------------------------------
    
    SoundBeep, 1800, 150 
    ElapsedTime :=  A_TickCount - StartTime
    ElapsedTime /= 1000.0
    FileAppend, Total execution time is : %ElapsedTime% seconds`n`n, executionTime.txt
    Run, notepad executionTime.txt
    
    SetTimer, RemoveToolTip, -5000

    
}
Return

^!q::
{
    Run, notepad itemsScanned.txt
}
Return



RemoveToolTip:
Loop,4{
    ToolTip, , , , % A_Index
}
return
