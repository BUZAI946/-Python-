@echo off
REM ──────────── Python 笔记一键推送 GitHub ────────────
REM 在能上 GitHub 的电脑上运行（右键 → 用管理员身份运行）
REM 或者手动复制下面的命令执行
REM ───────────────────────────────────────────────────

echo ====================================================
echo   推送 Python 笔记到 GitHub
echo   仓库: https://github.com/BUZAI946/-Python-
echo ====================================================
echo.

REM 1. 克隆空仓库
echo [1/5] 克隆远程仓库...
git clone https://github.com/BUZAI946/-Python-.git repo-clone
if errorlevel 1 goto :error

REM 2. 进入
cd repo-clone

REM 3. 验证 bundle
echo [2/5] 验证 bundle 完整性...
git bundle verify "..\Python-笔记.bundle"
if errorlevel 1 goto :error

REM 4. 拉取内容
echo [3/5] 拉取 bundle 内容...
git fetch "..\Python-笔记.bundle" main:imported-main
git checkout imported-main
git branch -m main

REM 5. 推送
echo [4/5] 推送到远程...
git push -u origin main --force

echo.
echo [5/5] 完成！
echo 应该看到 1 个 commit: 6ecbf61 v3 完整版

REM 清理临时
cd ..
rmdir /s /q repo-clone

pause
exit /b 0

:error
echo.
echo ╔════════════════════════════════════════════════╗
echo ║         推 送 失 败                          ║
echo ╚════════════════════════════════════════════════╝
echo.
echo 可能原因：
echo   1. 连不上 github.com —— 需要科学上网或换网络
echo   2. 远程仓库不存在 —— 老大先去 github.com 创建仓库
echo   3. 远程仓库不是空 —— 先 git push --force-with-lease
echo.
echo 备用方案：直接网页拖文件上传
echo   - 打开 https://github.com/BUZAI946/-Python-
echo   - 点 Add file - Upload files
echo   - 拖入这 8 个 HTML + README.md
echo   - 点 Commit changes
pause
exit /b 1
