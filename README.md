# docker-bypy

> 这是一个自动化周期性备份数据到百度网盘的命令行程序的 Docker 镜像。使用该镜像可以轻松地将数据备份到百度网盘。

## 使用示例

### 创建工作目录

创建一个工作目录：

```bash
mkdir -pv /opt/bypy
cd /opt/bypy
```

### 登陆

登陆百度网盘账户：

```bash
docker run -it --rm  \
    -v ./data/:/root/.bypy \
    jockerdragon/bypy:latest /usr/local/bin/bypy info
```

### 同步

运行同步容器：

假设您想要每天凌晨0点自动备份 `/mnt/data` 目录中的文件到百度网盘，您可以使用以下命令：

```bash
docker run -it -d \
    -v /mnt/data:/apps \
    -v ./data/:/root/.bypy \
    -e "CRON_SCHEDULE=0 0 * * *" \
    --name baidunetdisk-sync \
    --restart always \
    jockerdragon/bypy:latest
```

## 参数说明

### 环境变量

下面列出了可用的环境变量及其描述：

| 环境变量        | 描述                                                         | 默认值      |
| --------------- | ------------------------------------------------------------ | ----------- |
| `CRON_SCHEDULE` | 定义 cron 任务的调度时间。格式为 `分钟 小时 日 月份 星期几`。 | `0 0 * * *` |
| `PREFIX`        | 定义 tar 文件的前缀。                                        | `backup_`   |

### 举例命令


```bash
docker run -it -d \
    -v /你的同步目录:/apps \
    -v ./data/:/root/.bypy \
    -e "CRON_SCHEDULE=0 0 * * *" ## 可选项，默认为 "0 0 * * *" \
    -e "PREFIX=backup" ## 可选项，默认为 "app" \
    --name baidunetdisk-sync \
    --restart always \
    jockerdragon/bypy:latest
```

#### 参数说明

- **`-v /你的同步目录:/apps`**: 将宿主机上的目录挂载到容器的 `/apps` 目录，该目录中的文件将被备份。
- **`-v ./data/:/root/.bypy`**: 将宿主机上的数据目录挂载到容器的 `/root/.bypy` 目录，用于保存登录凭证和配置信息。
- **`-e "CRON_SCHEDULE=0 0 \* \* \*"`**: 设置 cron 任务的调度时间。如果不设置该环境变量，将使用默认值 `0 0 * * *`（即每天凌晨0点）。
- **`-e "PREFIX=backup_"`**: 设置 tar 文件的前缀。如果不设置该环境变量，将使用默认值 `backup_`。
- **`--name baidunetdisk-sync`**: 为容器指定名称。
- **`--restart always`**: 如果容器意外停止，Docker 将自动重启它。

## 致谢

- [bypy](https://github.com/houtianze/bypy)
- [Docker](https://hub.docker.com/)
