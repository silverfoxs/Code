#! /bin/bash

#Auth：
#Data:
#Func:


#VSCode中多行注释的快捷键是[alt+shift+A]。
#单行注释（ctrl+/或ctrl+k,ctrl+c）
#取消单行注释（ctrl+k,ctrl+u）
#多行注释（/* */）


#更新环境到最新
#sudo apt update && sudo apt -y upgrade

#[仅限Kali]配置中文显示以及中文输入法--安装完成软件包以后，直接在键盘里面设置输入法即可。
#sudo apt install -y locales
#export LANG=zh_CN.UTF-8
#sudo update-locale LANG=zh_CN.UTF-8
#sudo apt-get install fcitx-bin fcitx-table-all
#sudo apt-get install -y fcitx-pinyin

##Kali安装Multipass
##官方手册https://snapcraft.io/docs/installing-snap-on-kali
#sudo apt install -y snapd
#sudo systemctl enable --now snapd apparmor
#sudo snap install multipass


#~/.bashrc bashrc是一个针对Bash Shell的配置文件，用于交互式非登录Shell会话。这意味着每次打开一个新的终端窗口或者标签页时，.bashrc中的配置就会被加载。
#～/.bash_profile(对于Bash Shell)和～/.profile(对于其他sh兼容shell)是在登录shell会话开始时加载的配置文件。当你通过图形界面登录、SSH远程连接到系统或通过终端登陆时，这些文件的设置就会生效。


if [ -f /etc/os-release ] ; then
    echo "I'm here!!"
elif [ 1 == 1 ] ; then
    echo "I'm not here!!"
fi

for i in {1..100}
do
    for (( j=100;j>=0;j-- ))
    do
        #输出不换行
        echo -n "${i}*${j}=$(( ${i}*${j} )) "
    done
    echo ""
done

#scale表示设置保留小数点后面6位。
echo "scale=6; 2.34 * 4.32" |bc

