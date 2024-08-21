# docker-bypy

> 百度网盘python客户端 bypy 的 docker 镜像
>
> 自动化的 备份数据到百度网盘命令行程序

## 怎么用

### 创建工作目录

```bash
mkdir -pv /opt/bypy
cd /opt/bypy
```

### 登陆

```bash
docker run -it --rm  \
    -v ./data/:/root/.bypy \
    jockerdragon/bypy:latest /usr/local/bin/bypy info
```

### 同步

```bash
docker run -it -d \
    -v /你的同步目录:/apps \
    -v ./data/:/root/.bypy \
    -e "CRON_SCHEDULE=0 0 * * *" ## 可选项，默认每天0点同步 \
    --name baidunetdisk-sync \
    --restart always \
    jockerdragon/bypy:latest
```

