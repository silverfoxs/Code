<#
#更新帮助文档
Update-Help

#关闭服务。如需超管权限，只能在启动PowerShell窗口时，选择run as administrator
Stop-Service -Name 服务名

#确定PowerSehll版本
$PSVersionTable

#查询执行策略，以及详细的执行策略介绍。
#https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.4
Get-ExecutionPolicy
Set-ExecutionPolicy -ExecutionPolicy AllSigned #变更执行策略

#无需超管修改执行策略，仅限当前用户
Set-ExecutionPolicy -ExecutionPolicy AllSigned -Scope CurrentUser

#获取所有后台服务
Get-Service -Name 服务名
Get-Service |findstr 服务名
Get-Service 

#获取帮助
Get-Help Set-ExecutionPolicy         #获得该命令简化文档。
Get-Help Set-ExecutionPolicy -Full   #获得该命令的全部文档。
help -Name Get-Help -Full            #相当于|more
help Get-Help -Full                  #基本同上
Get-Help -Name Get-Command -Full
Get-Help -Name Get-Command -Detailed
Get-Help -Name Get-Command -Examples
Get-Help -Name Get-Command -Online   #推荐
Get-Help -Name Get-Command -Parameter Noun
Get-Help -Name Get-Command -ShowWindow

#获取日志
Get-EventLog Application  #获取应用程序系统日志。
(Get-EventLog Security).count


Get-Service -Name PeerDistSvc | Select-Object -Property *

#判断PowerShell主版本号。
if($PSVersionTable.PSVersion.Major -ge 5){ Write-Host "PowerShell主版本大于5" }

Write-Host -ForegroundColor Green "测试Get-WinEvent,使用where-object过滤(条件：Eventid=4625、近1天)"
(Measure-Command -Expression {Get-WinEvent -LogName $LogName | Where-Object { $_.TimeCreated -ge $StartDate -and $_.ID -eq "4625" }}).TotalSeconds

#获取主机信息
Get-CimInstance -ClassName Win32_BIOS
Get-CimInstance -ClassName Win32_Desktop

#操作主机
#Stop-Computer  #关机
#Restart-computer #重启
#Restart-computer -Force  #强制重启


#获取磁盘信息分区信息
$disk = Get-CimInstance -ClassName Win32_LogicalDisk -KeyOnly
Get-CimInstance -ClassName 

Get-CimAssociatedInstance -InputObject $disk[1]
Get-CimAssociatedInstance -InputObject $disk[1] -ResultClassName Win32_DiskPartition

#获取运行进程
Get-CimInstance -ClassName Win32_Process
Get-WmiObject -Class Win32_Process | Select-Object Name,ProcessId,status

#
Get-CimInstance -Namespace root -ClassName __NAMESPACE

Get-CimInstance -Namespace 

Get-CimInstance -Query "select * from Win32_Process where name like '进程名字，如SGTool(搜狗输入法)或 P*'"


#获取执行脚本的物理路径
$scriptpath = $MyInvocation.MyCommand.Path
Write-Host $scriptpath
#结果：C:\Users\Kevin Mendoza\Desktop\Code\PowerShell\init.ps1

$scriptDir = Split-Path -Parent $scriptpath
Write-Host $scriptDir
#结果：C:\Users\Kevin Mendoza\Desktop\Code\PowerShell

#通过特定类的限定符获取所有关联的实例
$s = Get-CimInstance -Query "Select * from Win32_Service where name like 'Winmgmt'"
Get-CimAssociatedInstance -InputObject $s -Association Win32_DependentService

#获取所有Windows应用包的信息。。以下两行输出行数和数据都一样。
Get-AppPackage -Name microsoft.windowscommunicationsapps
Get-AppxPackage | Select-Object Name,Version,status


Get-WmiObject -Class Win32_Product 
Get-WmiObject -Class Win32_Process | Select-Object Name,ProcessId,status
Get-WmiObject -Class Win32_Product | Select-Object Name,ProcessId,status | Sort-Object ProcessId

#获取系统主要语言
Get-InstalledLanguage

#>

<#
接受POST请求的测试网站
Reqres (https://reqres.in)、‌
https://api.apiopen.top/swagger/index.html#/    #上传文件等测试接口
JSONPlaceholder (https://jsonplaceholder.typicode.com)、‌
Mockbin (https://mockbin.org)、‌
Postman Echo (https://postman-echo.com)、‌
ReqBin (https://reqbin.com)、‌
Beeceptor (https://beeceptor.com)、‌
HTTPretty (http://httpretty.io) 
Restlet Client (https://restlet.com/modules/client)。‌


# 写入默认颜色的文本
Write-Host "这是默认颜色的文本"
 
# 写入红色的文本
Write-Host "这是红色的文本" -ForegroundColor Red
 
# 写入绿色的文本
Write-Host "这是绿色的文本" -ForegroundColor Green
 
# 写入蓝色的文本
Write-Host "这是蓝色的文本" -ForegroundColor Blue
 
# 写入黄色的文本
Write-Host "这是黄色的文本" -ForegroundColor Yellow
 
# 写入紫色的文本
Write-Host "这是紫色的文本" -ForegroundColor Magenta
 
# 写入青色的文本
Write-Host "这是青色的文本" -ForegroundColor Cyan
 
# 写入黑色的文本
Write-Host "这是黑色的文本" -ForegroundColor Black
 
# 写入白色的文本
Write-Host "这是白色的文本" -ForegroundColor White

#>

#发送GET请求
$response = Invoke-WebRequest -Uri "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics" -Method Get
Write-Host $response.Content      #返回的网页内容
Write-Host $response.StatusCode   #200

#发送POST请求:获取单个登录用户成功登录后的token
$data = @{
    'email' = 'eve.holt@reqres.in'
    'password' = 'cityslicka'
}
$response1 = Invoke-WebRequest -Uri "https://reqres.in/api/register" -Method Post -Body $data
$response1.StatusCode  #请求状态码
$retunResult = $response.Content | ConvertFrom-Json
($response1.Content | ConvertFrom-Json).id #获取返回结果中的ID值
Write-Host $retunResult.id
Write-Host $retunResult.token

#修改JSON属性值
$retunResult.id = 5
Write-Host $retunResult.id -ForegroundColor Red

#发送get请求：获取用户列表
$response2 = Invoke-WebRequest -Uri "https://reqres.in/api/users?page=2" -Method Get 

Write-Host $response2.StatusCode
Write-Host $response2.Content

$userlist = $response2.Content | ConvertFrom-Json
Write-Host "用户数：" $userlist.data.count  -ForegroundColor Green #6
Write-Host $userlist.data[0]

Write-Host "用户名及邮箱列表" -ForegroundColor Yellow #6
for ($i = 0; $i -lt $userlist.data.Count; $i++) {
    Write-Host  $userlist.data[$i].first_name  $userlist.data[$i].email -ForegroundColor Red
}

Write-Host (Invoke-WebRequest -Uri "https://api.apiopen.top/swagger/index.html#/api/getImages" -Method Get).Content

<# 发送电子邮件。妈的，139只能给自己发！
#Send-MailMessage
#备注:cmdlet Send-MailMessage 已过时。 有关详细信息，请参阅平台兼容性说明 DE0005。 此 cmdlet 不保证与 SMTP 服务器具有安全连接。
#DE0005 建议使用第三方库 MailKit。 如果使用 Exchange Online，则可以从 Microsoft Graph PowerShell SDK 使用 Send-MgUserMail 。
#https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.security/get-credential?view=powershell-5.1&WT.mc_id=ps-gethelp
$mail_username = Read-Host -Prompt '输入用户名'    #139邮箱手机号
$mail_pwd = Read-Host -Prompt '输入密码' -AsSecureString   #139邮箱-设置-账户信息-客户端授权码管理
$mail_cred_first = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $mail_username,$mail_pwd
Send-MailMessage -SmtpServer "smtp.139.com" -Credential $mail_cred_first -From "136****16@139.com" -To "198****1013@139.com" -Subject "Test Email" -UseSsl -Body "From PowerShell!"

# 捕获异常 try/cath
try {
    $response2 = Invoke-WebRequest -Uri "https://www.microsoft.com/api/xxxdfa?page=222" -Method Get 
    $statuscode = $response2.Code
}
catch {
    $statuscode = $_.Exception.Response.StatusCode.value__
}

Write-Host $statuscode
#>


#创建文件夹
New-Item new_code -Type Directory   #Type值包含:Directory、File、SymbolicLink(符号链接)、Junction(连接)、HardLink(硬链接)

#将进程信息写入到process.txt中,此文件在写入前不存在。
Get-Process | Out-File -FilePath 'C:\Users\Kevin Mendoza\Desktop\new_code\process.txt'

#读取写入的数据
Get-Content 'C:\Users\Kevin Mendoza\Desktop\new_code\process.txt'



<#
    跟老版本比,最新的openssl 3.3在标准命令部分新增了5个命令
    cmp fipsinstall info kdf mac

    信息摘要部分新增
    新增:mdc2
    移除:gost

    密码相关的命令新增
    bf bf-cbc bf-cfb bf-ecb bf-ofb
#>


openssl genpkey -algorithm RSA -out root.key -pkeyopt rsa_keygen_bits:2048
openssl req -new -x509 -days 3650 -key root.key -out root.crt -addext "subjectAltName = DNS:localhost" -addext "keyUsage = digitalSignature, keyCertSign, cRLSign" -addext "extendedKeyUsage = serverAuth, clientAuth" -addext "basicConstraints = CA:true"

#对称加密成功，第一次提示输入密码后，后面再次加解密不会在提示输入密码--会被提醒-k过时
#以下是警告内容
#*** WARNING : deprecated key derivation used.
#Using -iter or -pbkdf2 would be better.
#-iter +int          Specify the iteration count and force the use of PBKDF2   翻译：指定迭代计数并强制使用PBKDF2  默认值：10000
#                    Default: 10000
#-pbkdf2             Use password-based key derivation function 2 (PBKDF2)     翻译：-pbkdf2使用基于密码的密钥推导函数2（pbkdf2） 使用-iter将迭代计数从10000更改为10000
#                    Use -iter to change the iteration count from 10000

openssl enc -e -aes-256-cbc -in 'C:\Users\Kevin Mendoza\Desktop\123.txt' -out 'C:\Users\Kevin Mendoza\Desktop\123_encrypt.txt' -k password
openssl enc -d -aes-256-cbc -in 'C:\Users\Kevin Mendoza\Desktop\123_encrypt.txt' -out 'C:\Users\Kevin Mendoza\Desktop\123_unencrypt.txt' -k password

#对称加解密成功
openssl enc -e -aes-256-cbc -in 'C:\Users\Kevin Mendoza\Desktop\123.txt' -out 'C:\Users\Kevin Mendoza\Desktop\123_encrypt.txt' -iter 1
openssl enc -d -aes-256-cbc -in 'C:\Users\Kevin Mendoza\Desktop\123_encrypt.txt' -out 'C:\Users\Kevin Mendoza\Desktop\123_unencrypt.txt' -iter 1

#对称加解密成功
openssl enc -e -aes-256-cbc -in 'C:\Users\Kevin Mendoza\Desktop\123.txt' -out 'C:\Users\Kevin Mendoza\Desktop\123_encrypt.txt' -iter 1024
openssl enc -d -aes-256-cbc -in 'C:\Users\Kevin Mendoza\Desktop\123_encrypt.txt' -out 'C:\Users\Kevin Mendoza\Desktop\123_unencrypt.txt' -iter 1024

#对称加解密成功
openssl enc -e -aes-256-cbc -in 'C:\Users\Kevin Mendoza\Desktop\123.txt' -out 'C:\Users\Kevin Mendoza\Desktop\123_encrypt.txt' -iter 2048
openssl enc -d -aes-256-cbc -in 'C:\Users\Kevin Mendoza\Desktop\123_encrypt.txt' -out 'C:\Users\Kevin Mendoza\Desktop\123_unencrypt.txt' -iter 2048


openssl enc -e -aes-256-cbc -in 'C:\Users\Kevin Mendoza\Desktop\123.txt' -out 'C:\Users\Kevin Mendoza\Desktop\123_encrypt.txt' -iter 50000
openssl enc -d -aes-256-cbc -in 'C:\Users\Kevin Mendoza\Desktop\123_encrypt.txt' -out 'C:\Users\Kevin Mendoza\Desktop\123_unencrypt.txt' -iter 50000

#帮助
openssl enc -d -chacha20 -help

#堆成加密--会被提醒-k过时
#以下是警告内容
#*** WARNING : deprecated key derivation used.
#Using -iter or -pbkdf2 would be better.
openssl enc -e -chacha20 -in 'C:\Users\Kevin Mendoza\Desktop\123.txt' -out 'C:\Users\Kevin Mendoza\Desktop\123_encrypt.txt' -k password
openssl enc -d -chacha20 -in 'C:\Users\Kevin Mendoza\Desktop\123_encrypt.txt' -out 'C:\Users\Kevin Mendoza\Desktop\123_unencrypt.txt' -k password

#对称加解密成功
openssl enc -e -chacha20 -in 'C:\Users\Kevin Mendoza\Desktop\123.txt' -out 'C:\Users\Kevin Mendoza\Desktop\123_encrypt.txt' -iter 1
openssl enc -d -chacha20 -in 'C:\Users\Kevin Mendoza\Desktop\123_encrypt.txt' -out 'C:\Users\Kevin Mendoza\Desktop\123_decrypt.txt' -iter  1

#对称加解密成功
openssl enc -e -chacha20 -in 'C:\Users\Kevin Mendoza\Desktop\123.txt' -out 'C:\Users\Kevin Mendoza\Desktop\123_encrypt.txt' -iter 1024
openssl enc -d -chacha20 -in 'C:\Users\Kevin Mendoza\Desktop\123_encrypt.txt' -out 'C:\Users\Kevin Mendoza\Desktop\123_decrypt.txt' -iter 1024

#对称加解密成功
openssl enc -e -chacha20 -in 'C:\Users\Kevin Mendoza\Desktop\123.txt' -out 'C:\Users\Kevin Mendoza\Desktop\123_encrypt.txt' -iter 2048
openssl enc -d -chacha20 -in 'C:\Users\Kevin Mendoza\Desktop\123_encrypt.txt' -out 'C:\Users\Kevin Mendoza\Desktop\123_decrypt.txt' -iter 2048

#对称解密失败
openssl enc -e -chacha20 -in 'C:\Users\Kevin Mendoza\Desktop\123.txt' -out 'C:\Users\Kevin Mendoza\Desktop\123_encrypt.txt' -iter 2048
openssl enc -d -chacha20 -in 'C:\Users\Kevin Mendoza\Desktop\123_encrypt.txt' -out 'C:\Users\Kevin Mendoza\Desktop\123_decrypt.txt' -iter 1024


#生成证书--根证书
openssl genrsa -out 'C:\Users\Kevin Mendoza\Desktop\Code\OpenSSL\priv_root.pem'
openssl genrsa -engine -help    #需要在linux平台上执行查看结果

openssl req -new -key 'C:\Users\Kevin Mendoza\Desktop\Code\OpenSSL\priv_root.pem' -out 'C:\Users\Kevin Mendoza\Desktop\Code\OpenSSL\req_sc.csr'
openssl req -in 'C:\Users\Kevin Mendoza\Desktop\Code\OpenSSL\req_sc.csr'

#输出证书请求文件的内容。查看CSR文件申请详细内容。会显示国家、省、城市、组织域名、签名指纹等。
openssl req -in 'C:\Users\Kevin Mendoza\Desktop\Code\OpenSSL\req_sc.csr' -text

#将”-text”和”-noout”结合使用,则只输出证书请求的文件头部分。
openssl req -in 'C:\Users\Kevin Mendoza\Desktop\Code\OpenSSL\req_sc.csr' -noout -text

#只输出subject部分的内容
openssl req -in 'C:\Users\Kevin Mendoza\Desktop\Code\OpenSSL\req_sc.csr' -subject -noout
#结果:subject=C=CN, ST=SC, L=chengdu, OU=www.jju.com

#可以使用”-pubkey”输出证书请求文件中的公钥内容。如果从申请证书请求时所提供的私钥中提取出公钥，这两段公钥的内容是完全一致的。
openssl req -in 'C:\Users\Kevin Mendoza\Desktop\Code\OpenSSL\req_sc.csr' -pubkey -noout
openssl rsa -in 'C:\Users\Kevin Mendoza\Desktop\Code\OpenSSL\priv_root.pem'-pubout

#生成CA根证书
openssl req -x509 -key 'C:\Users\Kevin Mendoza\Desktop\Code\OpenSSL\priv_root.pem' 
-in 'C:\Users\Kevin Mendoza\Desktop\Code\OpenSSL\req_sc.csr' 
-out 'C:\Users\Kevin Mendoza\Desktop\Code\OpenSSL\ca_master_0a.crt' -days 365

#openssl asn1parse :用来诊断ASN.1结构的工具，也能用于从ASN1.1数据中提取数据。
openssl asn1parse -in .\ca_master_0a.crt
openssl asn1parse -in .\req_sc.csr
    0:d=0  hl=4 l= 647 cons: SEQUENCE
    4:d=1  hl=4 l= 367 cons: SEQUENCE
    8:d=2  hl=2 l=   1 prim: INTEGER           :00
   11:d=2  hl=2 l=  66 cons: SEQUENCE
   13:d=3  hl=2 l=  11 cons: SET
   15:d=4  hl=2 l=   9 cons: SEQUENCE
   17:d=5  hl=2 l=   3 prim: OBJECT            :countryName
   22:d=5  hl=2 l=   2 prim: PRINTABLESTRING   :CN
   26:d=3  hl=2 l=  11 cons: SET
   28:d=4  hl=2 l=   9 cons: SEQUENCE
   30:d=5  hl=2 l=   3 prim: OBJECT            :stateOrProvinceName
   35:d=5  hl=2 l=   2 prim: UTF8STRING        :SC
   39:d=3  hl=2 l=  16 cons: SET
   41:d=4  hl=2 l=  14 cons: SEQUENCE
   43:d=5  hl=2 l=   3 prim: OBJECT            :localityName
   48:d=5  hl=2 l=   7 prim: UTF8STRING        :chengdu
   57:d=3  hl=2 l=  20 cons: SET
   59:d=4  hl=2 l=  18 cons: SEQUENCE
   61:d=5  hl=2 l=   3 prim: OBJECT            :organizationalUnitName
   66:d=5  hl=2 l=  11 prim: UTF8STRING        :www.jju.com
   79:d=2  hl=4 l= 290 cons: SEQUENCE
   83:d=3  hl=2 l=  13 cons: SEQUENCE
   85:d=4  hl=2 l=   9 prim: OBJECT            :rsaEncryption
   96:d=4  hl=2 l=   0 prim: NULL
   98:d=3  hl=4 l= 271 prim: BIT STRING
  373:d=2  hl=2 l=   0 cons: cont [ 0 ]
  375:d=1  hl=2 l=  13 cons: SEQUENCE
  377:d=2  hl=2 l=   9 prim: OBJECT            :sha256WithRSAEncryption
  388:d=2  hl=2 l=   0 prim: NULL
  390:d=1  hl=4 l= 257 prim: BIT STRING


#使用RSA算法生成私钥 -aes-128-cbc 指明加密秘钥的算法。也可以是-aes-256-cbc
openssl genpkey -out fd.key -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -aes-128-cbc

#使用ECDSA算法生成私钥 -aes-128-cbc 指明加密秘钥的算法。也可以是-aes-256-cbc
#ECDSA 密钥的过程类似，只是不能创建任意大小的密钥。相反，对于每个密钥，
#您都要选择一个命名曲线，它控制密钥大小，但它也控制其他 EC 参数。以下示例使用 P-256（或）命名曲线创建一个 256 位 ECDSA 密钥
openssl genpkey -out fd.key -algorithm EC -pkeyopt ec_paramgen_curve:P-256 -aes-128-cbc

#生成CSR文件，也可以是用配置文件。
openssl req -new -key .\fd.key -out fd.csr

apt-mark hold nginx bunkerweb

