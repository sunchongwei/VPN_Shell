#!/bin/bash
# 设置当前目录为工作目录
dir=$(pwd)
# Function to check if directory exists or not
check_dir() {
  if [ ! -d "$1" ]; then
    mkdir -p $1
  fi
}

# Function to check if file exists or not
check_file() {
  if [ ! -f "$1" ]; then
    touch $1
  fi
}
# 判断v2ray文件夹是否存在
if [ -d "$dir/v2ray" ]
then
  echo "$dir/v2ray directory has exist!"
else
  mkdir v2ray 
  echo "$dir/v2ray directory has create!"
fi
# 下载软件
cd v2ray
if [ -f "v2ray-linux-64.zip" ]
then
  echo "$dir/v2ray/v2ray-linux-64.zip has exist!"
else
  # 文件不存在
  wget  https://github.com/v2fly/v2ray-core/releases/download/v4.31.0/v2ray-linux-64.zip
  echo "$dir/v2ray/v2ray-linux-64.zip has create!"
  mkdir v2ray-linux-64
  unzip v2ray-linux-64.zip -d v2ray-linux-64  # 解压
fi
# 切换目录
cd v2ray-linux-64
chmod 755 v2ray
chmod 755 v2ctl
chmod 755 systemd/system/v2ray.service
chmod 755 systemd/system/v2ray@.service

# 复制文件
# v2ray
if [ -e "/usr/local/bin/v2ray" ]; then
    echo "/usr/local/bin/v2ray has exist!"
else
    cp v2ray /usr/local/bin/
fi
# v2ctl
if [ -e "/usr/local/bin/v2ctl" ]; then
    echo "/usr/local/bin/v2ctl has exist!"
else
    cp v2ctl /usr/local/bin/
fi
# v2ray.service
if [ -e "/etc/systemd/system/v2ray.service" ]; then
    echo "/etc/systemd/system/v2ray.service has exist!"
else
    cp systemd/system/v2ray.service /etc/systemd/system/
fi
# v2ray@.service
if [ -e "/etc/systemd/system/v2ray@.service" ]; then
    echo "/etc/systemd/system/v2ray@.service has exist!"
else
    cp systemd/system/v2ray@.service /etc/systemd/system/
fi
check_dir "/usr/local/share/v2ray/"
if [ -e "/usr/local/share/v2ray/geoip.dat" ]; then
    echo "/usr/local/share/v2ray/geoip.dat has exist!"
else
    cp geoip.dat /usr/local/share/v2ray/
fi
if [ -e "/usr/local/share/v2ray/geosite.dat" ]; then
    echo "/usr/local/share/v2ray/geosite.dat has exist!"
else
    cp geosite.dat /usr/local/share/v2ray/
fi
check_dir "/var/log/v2ray/"
if [ -e "access.log" ]; then
    echo ""
else
    touch access.log
    cp access.log /var/log/v2ray/
fi
if [ -e "error.log" ]; then
    echo ""
else
    touch error.log
    cp error.log /var/log/v2ray/
fi
# 配置json文件
check_dir "/usr/local/etc/v2ray/"
cp $dir/config.json /usr/local/etc/v2ray/config.json
# 启动V2ray
sudo systemctl start v2ray
# 检查V2ray状态
echo "$(sudo systemctl status v2ray)"