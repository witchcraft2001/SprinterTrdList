rem echo OFF
echo Unmounting old image ...
osfmount.com -D -m X:

echo Assembling ...
tools\sjasmplus\sjasmplus.exe --lst=TRDLIST.lst --lstlab TRDLIST.asm
if errorlevel 1 goto ERR

echo Preparing floppy disk image ...
copy /Y image\dss_image.img build\trdlist.img
rem Delay before copy image
timeout 2 > nul
osfmount.com -a -t file -o rw -f build/trdlist.img -m X:
if errorlevel 1 goto ERR
mkdir X:\TRDLIST
copy /Y trdlist.exe /B X:\TRDLIST\ /B
copy /Y trdlist.txt /A X:\TRDLIST\ /A
if errorlevel 1 goto ERR
echo Unmounting image ...
osfmount.com -d -m X:
rem Delay before copy image
timeout 2 > nul
goto SUCCESS
:ERR
rem pause
echo Some Building ERRORs!!!
pause 0
rem exit
goto END
:SUCCESS
echo Copying image to ZXMAK2 Emulator
copy /Y build\trdlist.img /B %SPRINTER_EMULATOR% /B
"%PROGRAMFILES%\7-Zip\7z.exe" a build\trdlist.zip trdlist.exe trdlist.txt
rem timeout 2 > nul
rem echo Starting ZXMAK2 Emulator
rem call %SPRINTER_EMULATOR%\ZXMAK2.EXE build\trdlist.img
echo Done!
:END
pause 0