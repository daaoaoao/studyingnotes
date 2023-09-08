:: git 提交脚本
:: 用法：commit.bat [message]
:: message: 提交信息
:: 检查是否传入了提交消息
if "%~1"=="" (
  :: 如果消息为空，将日期赋给提交消息
  set "commit_message=%date%"
) else (
  :: 如果有传入消息，使用传入的消息
  set "commit_message=%~1"
)

:: 提交更改
git add *
git commit -m "%commit_message%"
git push origin main

endlocal
