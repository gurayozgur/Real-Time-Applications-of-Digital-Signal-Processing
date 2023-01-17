@"c:\program files (x86)\national instruments\cvi2020\bin\cviprelink.exe" -cmd prelink_options.txt > PreLink.out 2>&1
@if errorlevel 0 goto err0
@if errorlevel -1 goto err1
@if errorlevel -2 goto err2
:err0
@exit 0
:err1
@echo PreLink failed - report
@exit 1
:err2
@echo PreLink failed - noreport
@exit 1
