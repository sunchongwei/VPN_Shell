# 功能介绍
一站式在Linux系统部署V2ray脚本。只需运行shell脚本即可.

参考网页：https://www.hduzn.cn/2022/06/14/Linux%E4%BD%BF%E7%94%A8v2ray/

# 使用方法
1.  导出配置文件（必须）

原生的V2ray并不支持订阅，反正我本来就在windows下用的，直接在v2rayN的客户端，服务器列表中中右键->【导出所选服务器为客户端配置】，保存成config.json文件。

2. 运行vpn.sh脚本（必须）

```shell
./vpn.sh
```

3. 设置为开机自启（可选）
```shell
sudo systemctl enable v2ray
```

4. 关闭服务（可选）
```shell
sudo systemctl stop v2ray
```
