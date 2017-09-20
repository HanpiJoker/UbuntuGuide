# How to use git to save my code
1. mkdir git   
  create a directory as the Store to upload my code
2. git init
 init the git
3. cp -r ~/path_to_work/project ~/git
copy your project code into the Store
4. git remote add origin git@github.com:yourName/yourRepo.git
get in the Store where you want to save your code.
4. git add . (/<filename>)
add your code in the HEAD
5. git commit -m "something"
upload the code with some comments
6. git pull origin master
同步云端仓库和本地仓库内容
需要你输入新的merge信息的终端窗口，在最上面的提示句下有一行空格，按照链接的帮  
助，按”i”进入输入模式，随便输入个什么，然后 esc，直接输入”:wq”你会发现这个出现  
在终端的最下面，这是OK的，最后 enter，就OK了
7. git push origin master
completed

PS:这只是个人使用时，备份自己代码的一些方法，绝对不是git的完全使用方法！！！
