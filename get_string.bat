@echo off
title getString by CabCon
COLOR 2F
set /p Input= Enter String:
echo %id%
findstr /s /i "%Input%" *.*
pause