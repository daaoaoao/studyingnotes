# git命令速查

## 创建

### 克隆远程分支

- git clone

### 创建新的分支

- git init

## 本地更改

### 查看当前版本状态(是否修改）

- git status

### 显示所有未添加至index的变更

- git diff

### 查看已缓存的与未缓存的所有改动

- git diff HEAD

### 将该文件添加到缓存

- git add <path>

### 提交

- git commit -m "xxx“

### 合并上一次提交（用于反复修改）

- git commit --amend -m "xxx"

### 将add和commit合并为一步

- git commit -am "xxx"

## 提交历史记录

### 显示日志

- git log

### 显示某个提交的详细内容

- git show <commit>

### 在每一行显示 commit 号,提交者,最早提交日期

- git blame <file>

## 分支机构和标签

### 显示本地分支

- git branch

### 切换分支

- git checkout <branch>

### 新建分支

- git branch <new-branch>

### 创建新分支跟踪远程分支

- git branch --track <new><remote>

### 删除本地分支

- git branch -d <branch>

### 给当前分支打标签

- git tag <tag-name>

## 更新和发布

### 列出远程分支详细信息

- git remote -v

### 显示某个分支的信息

- git remote show <remote>

### 添加一个新的远程仓库

- git remote add <remote> <url>

### 获取远程分支，但不更新本地分支，另需merge

- git fetch <remote>

### 获取远程分支，并更新本地分支

- git pull <remote> <branch>

### 推送本地更新到远程分支

- git push <remote> <branch>

### 删除一个远程分支

- git push <remote> --delete <branch>

### 推送本地标签

- git push --tags

## 合并与衍合

### 合并分支到当前分支，存在两个

- git merge <branch>

### 合并分支到当前分支，存在一个

- git rebase <branch>

### 回到执行rebase之前

- git rebase --abort

### 解决矛盾后继续执行rebase

- git rebase --continue

### 使用mergetool解决冲突

- git mergetool

### 使用冲突文件解决冲突

- git add <resolve-file>

### git rm <resolved-file>

## 撤销 UNDO

### 将当前版本重置为HEAD（用于merge）失败

- git reset --hard HEAD

### 将当前版本重置至某一个提交状态(慎用!)

- git reset --hard <commit>

### 将当前版本重置至某一个提交状态，代码不变

- git reset <commit>

### 重置至某一状态,保留版本库中不同的文件

- git reset --merge <commit>

### 重置至某一状态,重置变化的文件,代码改变

- git reset --keep <commit>

### 丢弃本地更改信息并将其存入特定文件

- git checkout HEAD <file>

### 撤消提交

- git revert <commit>

## 获取命令行上的帮助

### git help <command>

