@echo off
cd /d "%~dp0"
title=�����ѯϵͳ
:start
cls
if exist tmp.txt del tmp.txt>nul
if exist tmp2.txt del tmp2.txt>nul
echo -----------��ӭ���������ѯϵͳ----------------
echo -----------������ʲô?-----------
set "str="
set /p "str="
if "%str%"=="" goto all
copy /y que.txt tmp.txt>nul
for /f "tokens=1* delims= " %%a in ("%str%") do (
  findstr /n %%a tmp.txt>tmp2.txt || (echo ----û���ҵ�----- & pause & goto start)
  del tmp.txt>nul
  move tmp2.txt tmp.txt>nul
  if "%%b" neq "" set "str=%%b"&goto lp
)
:start2
type tmp.txt
echo ------��Ҫ�鿴�����⣨�������Ϊ�շ��أ�
set "xuan="
set /p "xuan="
set "link="
if "%xuan%"=="" goto start
echo %xuan%|findstr /be "[0-9]*" >nul  || ( echo ----ѡ�����---- & pause & goto start2)
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
echo �Ƿ���ʾ��������(����Ϊ�ǣ���Ϊ��)
set "q="
set /p "q="
if "%q%"=="" goto start
start que.txt
pause
goto start

:lp
for /f "tokens=1* delims= " %%a in ("%str%") do (
  findstr %%a tmp.txt>tmp2.txt || (echo û���ҵ� & pause & goto start)
  del tmp.txt>nul
  move tmp2.txt tmp.txt>nul
  if "%%b" neq "" set "str=%%b"&goto lp
)
goto start2

