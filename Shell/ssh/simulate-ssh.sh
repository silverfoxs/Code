#! /bin/bash

#expect << EOF
#    spawn ssh ubuntu@10.140.51.143

##同意配置SSH指纹
#    expect "fingerprint])?"
#    send "yes\r"

##配置收到输入密码提醒
#    expect "password:"
#    send "[----------------密码需要配置好----------------]\r"

##配置正常登录后执行的命令
#    expect "~$"
#    send "cat /etc/os-release\r"

#    expect eof
#EOF


#ip_pool中有2行数据
#10.140.51.64
#10.140.51.101
#如果最后一行不是空行，就无法读取最后一样的配置
#采用下面的代码只能读取10.140.51.64这一行
echo -e "方式一：\r"
while read line
do
    echo "${line}"
done < ./ip_pool


#采用这种方式，2行数据都可以输出。
echo -e "方式二：\r"
for line in $(cat ./ip_pool)
do
    expect << EOF
    spawn ssh ubuntu@${line}

    expect "password:"
    send "[----------------密码需要配置好----------------]\r"

    expect "~$"
    send "cat /etc/os-release\r"

    expect eof
EOF
done