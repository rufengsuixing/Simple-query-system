@echo off
cd /d "%~dp0"
title=月球查询系统
:start
cls
if exist tmp.txt del tmp.txt>nul
if exist tmp2.txt del tmp2.txt>nul
echo -----------欢迎进入月球查询系统----------------
echo -----------想搜索什么?-----------
set "str="
set /p "str="
if "%str%"=="" goto all
copy /y que.txt tmp.txt>nul
for /f "tokens=1* delims= " %%a in ("%str%") do (
  findstr /n %%a tmp.txt>tmp2.txt || (echo ----没有找到----- & pause & goto start)
  del tmp.txt>nul
  move tmp2.txt tmp.txt>nul
  if "%%b" neq "" set "str=%%b"&goto lp
)
:start2
type tmp.txt
echo ------想要查看的问题（输入序号为空返回）
set "xuan="
set /p "xuan="
set "link="
if "%xuan%"=="" goto start
echo %xuan%|findstr /be "[0-9]*" >nul  || ( echo ----选择错误---- & pause & goto start2)
set /a xuan=%xuan%-1
if "%xuan%"=="0" ( set "xuan=" ) else (set "xuan=skip=%xuan%")
set "que="
for /f "%xuan% tokens=*" %%a in (que.txt) do (if not defined que set "que=%%a")
set "ans="
for /f "%xuan% tokens=*" %%a in (ans.txt) do (if not defined ans set "ans=%%a")
for /f %%a in ('echo %ans% ^|findstr ".htm .html .mhtml .txt .tif"') do (set link=%%a)
echo %que%
if "%link%"=="" ( echo %ans% ) else (start %link%)
pause
cls
goto start2
:all
echo 是否显示所有问题(任意为是，空为否)
set "q="
set /p "q="
if "%q%"=="" goto start
start que.txt
pause
goto start

:lp
for /f "tokens=1* delims= " %%a in ("%str%") do (
  findstr %%a tmp.txt>tmp2.txt || (echo 没有找到 & pause & goto start)
  del tmp.txt>nul
  move tmp2.txt tmp.txt>nul
  if "%%b" neq "" set "str=%%b"&goto lp
)
goto start2

