#!/bin/bash
uid=$1
upw=$2
uidarr=(${uid//,/ }) #字符串预处理
upwarr=(${upw//,/ })
num=${#uidarr[@]}
smbtn="进入健康状况上报平台"
url1="https://jksb.v.zzu.edu.cn/vls6sss/zzujksb.dll/login"
url2="https://jksb.v.zzu.edu.cn/vls6sss/zzujksb.dll/jksb"
for((i=0;i<num;i++))
do
curl -d "uid=${uidarr[i]}&upw=${upwarr[i]}&smbtn=$smbtn&hh28=722" -s $url1 -o temp.txt
udata=$(sed -n '11p' temp.txt)
udata=${udata#*ptopid=}
udata=${udata%\"\}\}*}
ptopid="${udata%&*}"
sid="${udata#*&sid=}" #登录获取ptopid和sid
curl -d "day6=b&did=1&men6=a" -d "ptopid=$ptopid&sid=$sid" -s $url2 -o /dev/null #进入确认界面
# curl -d "@myvs.txt" -d "jingdu=113.658333&weidu=34.783333&ptopid=$ptopid&sid=$sid" -s $url2 -o temp.txt #获取经纬度并打卡
curl -d "@myvs.txt" -d "jingdu=113.658333&weidu=34.7822222&ptopid=$ptopid&sid=$sid" -s $url2 -o temp.txt #获取经纬度并打卡-东经113.658333北纬34.7822222
udata=$(sed -n '24p' temp.txt)
echo "$udata"
done
