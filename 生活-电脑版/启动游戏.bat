@echo off
chcp 65001 >nul 2>nul
title 生活 · 兽都三十天

rem ============================================================
rem  生活（电脑版）启动器
rem  作用：找到本文件夹里的游戏页面，用电脑自带的 Edge / Chrome
rem        以「应用窗口」模式打开（没有地址栏，像独立小程序）。
rem  说明：本文件内不含中文路径字面量，中文只出现在提示文字里，
rem        路径一律在运行时从 %~dp0 取得，避免编码问题。
rem ============================================================

set "PF=%ProgramFiles%"
set "PF86=%ProgramFiles(x86)%"
set "LAD=%LocalAppData%"

rem ---- 1. 找到同目录下的游戏页面（唯一一个 .html）----
set "GAME="
for %%f in ("%~dp0*.html") do set "GAME=%%~ff"
if not defined GAME goto nogame

rem ---- 2. 依次寻找 Chromium 内核浏览器 ----
set "BROWSER="
for %%p in (
  "%PF86%\Microsoft\Edge\Application\msedge.exe"
  "%PF%\Microsoft\Edge\Application\msedge.exe"
  "%PF%\Google\Chrome\Application\chrome.exe"
  "%PF86%\Google\Chrome\Application\chrome.exe"
  "%LAD%\Google\Chrome\Application\chrome.exe"
  "%PF%\BraveSoftware\Brave-Browser\Application\brave.exe"
  "%PF86%\BraveSoftware\Brave-Browser\Application\brave.exe"
  "%LAD%\BraveSoftware\Brave-Browser\Application\brave.exe"
) do (
  if not defined BROWSER if exist "%%~p" set "BROWSER=%%~p"
)

rem ---- 3. 组装本地地址并启动 ----
set "URL=file:///%GAME:\=/%"
if not defined BROWSER goto fallback

start "" "%BROWSER%" --app="%URL%" --allow-file-access-from-files --window-size=1120,800
exit /b 0

:fallback
echo.
echo   没有找到 Edge / Chrome，改用系统默认浏览器打开（会出现地址栏）。
echo   想要独立窗口效果，装一个 Edge 或 Chrome 再双击本文件就行。
echo.
start "" "%GAME%"
exit /b 0

:nogame
echo.
echo   [错误] 没有在本文件夹里找到游戏页面（*.html）。
echo   请确认压缩包已完整解压，并且 生活.html 与 启动游戏.bat 在同一个文件夹里。
echo.
pause
exit /b 1