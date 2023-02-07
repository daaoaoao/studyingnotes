:: git 提交脚本
:: 用法：commit.bat [message]
:: message: 提交信息
git add *
git commit -m %*
git push origin main
