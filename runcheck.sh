#!/bin/bash
mkdir ./tmp -p

# -s 参数将不输出错误和进度信息。
# -l 参数会让 HTTP 请求跟随服务器的重定向。curl 默认不跟随重定向。
# -v 参数输出通信的整个过程，用于调试。
# -o 参数将网页文件转存到某一目录，/dev/null 为空。即隐藏网页文件。
curl https://${1} -v -s -l -o /dev/null 2>./tmp/ca.info

cat ./tmp/ca.info | grep 'start date: ' >./tmp/${1}.info
cat ./tmp/ca.info | grep 'expire date: ' >>./tmp/${1}.info
cat ./tmp/ca.info | grep 'issuer: ' >>./tmp/${1}.info
cat ./tmp/ca.info | grep 'SSL certificate verify' >>./tmp/${1}.info
cat ./tmp/ca.info | grep 'subject: ' >>./tmp/${1}.info

sed -i 's|\*  start date: ||g' ./tmp/${1}.info
sed -i 's|\*  expire date: ||g' ./tmp/${1}.info
sed -i 's|\*  issuer: ||g' ./tmp/${1}.info
sed -i 's|\*  SSL certificate verify ||g' ./tmp/${1}.info
sed -i 's|\*  subject: ||g' ./tmp/${1}.info

# 证书颁布时间
start_GMT=$(sed -n '1p' ./tmp/${1}.info)
start_arr=(${start_GMT})

# 证书到期时间
expire_GMT=$(sed -n '2p' ./tmp/${1}.info)
expire_arr=(${expire_GMT})

# 调用子脚本，修改时间、日期
chmod +x ./modify-time-format.sh
bash ./modify-time-format.sh

start=${start_UTC}
expire=${expire_UTC}
issuer=$(sed -n '3p' ./tmp/${1}.info)
status=$(sed -n '4p' ./tmp/${1}.info)
subject=$(sed -n '5p' ./tmp/${1}.info)

rm -f ./tmp/ca.info
rm -f ./tmp/${1}.info

DATE_Previous="$(echo $(date '+%Y-%m-%d %H:%M:%S'))"
DATE_current="$(echo $(date '+%Y %m %d %H:%M:%S'))"
nowstamp="$(date -d "$DATE_Previous" +%s)"
expirestamp="$(date -d "$expire_GMT" +%s)"
# 剩余天数
expireday=$(expr $((expirestamp - nowstamp)) / 86400)

echo '{' >tmp/${1}.json
echo '"domain": "'${1}'",' >>./tmp/${1}.json
echo '"subject": "'$subject'",' >>./tmp/${1}.json
echo '"start": "'$start'",' >>./tmp/${1}.json
echo '"expire": "'$expire'",' >>./tmp/${1}.json
echo '"issuer": "'$issuer'",' >>./tmp/${1}.json

if [ $expirestamp \< $nowstamp ]; then
	echo '"status": "Expired",' >>./tmp/${1}.json
	echo '"statuscolor": "error",' >>./tmp/${1}.json
elif [ $expireday \< 10 ]; then
	echo '"status": "Soon Expired",' >>./tmp/${1}.json
	echo '"statuscolor": "warning",' >>./tmp/${1}.json
elif [ "$status" = "ok." ]; then
	echo '"status": "Valid",' >>./tmp/${1}.json
	echo '"statuscolor": "success",' >>./tmp/${1}.json
else
	echo '"status": "Invalid",' >>./tmp/${1}.json
	echo '"statuscolor": "error",' >>./tmp/${1}.json
fi

echo '"check": "'$DATE_current'",' >>./tmp/${1}.json
echo '"remain": "'$expireday'"' >>./tmp/${1}.json
echo '},' >>./tmp/${1}.json
