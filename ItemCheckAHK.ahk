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
;
;



;   https://warframe.market/items/
URL1 = https://api.warframe.market/v1/items/
URL = https://warframe.market/items/
URLEnd = /statistics

^q::
{
    ie := ComObjCreate("InternetExplorer.Application")


    ;---------- First Item Scan and Check ----------
    itemScanOriginal := OCR([168, 452, 380, 31])
    NewItemScanUnderscore := StrReplace(itemScanOriginal, A_Space, "_")
    StringLower, itemScan, NewItemScanUnderscore
    ;FileAppend, First item is  : %itemScan% `n, itemsScanned.txt
    ;SoundBeep, 800, 150

    NewURL = %URL%%itemScan%%URLEnd%
    ie.navigate(NewURL)
    while ie.ReadyState != 4
        Sleep, 20
    ie.visible  := false
    apiText := ie.document.body.innerHTML
    ValueFound := RegExMatch(apiText, ".min_price"": (\d.*?)", subpat)
    
    FirstItem = Price is : %subpat1% platinum
    ;FileAppend, url = %NewURL%`nprice = %subpat1%`n%FirstItem%`n, itemsCheckup.txt
    ToolTip,%FirstItem%, 168, 500, 1



    ;---------- Second Item Scan and Check ----------
    itemScanOriginal := OCR([566, 452, 380, 31])
    NewItemScanUnderscore := StrReplace(itemScanOriginal, A_Space, "_")
    StringLower, itemScan, NewItemScanUnderscore
    ;FileAppend, Second item is : %itemScan% `n, itemsScanned.txt
    ;SoundBeep, 800, 150 

    ;NewURL = %URL%%itemScan%%URLEnd%
    ;ie.navigate(NewURL)
    ;while ie.ReadyState != 4
    ;    Sleep, 20
    ;ie.visible  := false
    ;apiText := ie.document.body.innerHTML

    if FileExist("D:\")
    MsgBox, The drive exists.

    NewURL = %URL1%%itemScan%%URLEnd%
    UrlDownloadToFile, %NewURL%, jsons/%itemScan%.json

    FileRead, apiText1, jsons/%itemScan%.json
    apiText := SubStr(apiText1, 1, 500)
    ValueFound := RegExMatch(apiText, ".min_price"": (\d.*?)", subpat)
    
    SecondItem = Price is : %subpat1% platinum
    ;FileAppend, url = %NewURL%`nprice = %subpat1%`n%SecondItem%`n, itemsCheckup.txt
    ToolTip,%SecondItem%, 566, 500, 2



    ;---------- Third Item Scan and Check ----------
    itemScanOriginal := OCR([971, 452, 380, 31])
    NewItemScanUnderscore := StrReplace(itemScanOriginal, A_Space, "_")
    StringLower, itemScan, NewItemScanUnderscore
    ;FileAppend, Third item is  : %itemScan% `n, itemsScanned.txt
    ;SoundBeep, 800, 150 

    NewURL = %URL%%itemScan%%URLEnd%
    ie.navigate(NewURL)
    while ie.ReadyState != 4
        Sleep, 20
    ie.visible  := false
    apiText := ie.document.body.innerHTML
    ValueFound := RegExMatch(apiText, ".min_price"": (\d.*?)", subpat)
    
    ThirdItem = Price is : %subpat1% platinum
    ;FileAppend, url = %NewURL%`nprice = %subpat1%`n%ThirdItem%`n, itemsCheckup.txt
    ToolTip,%ThirdItem%, 970, 500, 3
    
    ;----------------------------------------------------------------------

    itemScanOriginal := OCR([1370, 452, 380, 31])
    NewItemScanUnderscore := StrReplace(itemScanOriginal, A_Space, "_")
    StringLower, itemScan, NewItemScanUnderscore
    ;FileAppend, Fouth item is  : %itemScan% `n, itemsScanned.txt
    ;SoundBeep, 800, 150 

    NewURL = %URL%%itemScan%%URLEnd%
    ie.navigate(NewURL)
    while ie.ReadyState != 4
        Sleep, 20
    ie.visible  := false
    apiText := ie.document.body.innerHTML
    ValueFound := RegExMatch(apiText, ".min_price"": (\d.*?)", subpat)
    
    FourthItem = Price is : %subpat1% platinum
    ;FileAppend, url = %NewURL%`nprice = %subpat1%`n%FourthItem%`n, itemsCheckup.txt
    ToolTip,%FourthItem%, 1370, 500, 4

    ;----------------------------------------------------------------------

    
    
    SoundBeep, 1800, 150 
    SetTimer, RemoveToolTip, -5000

    ie.quit
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
