# nginx 相关脚本

## install.sh

- 脚本说明: 安装最新版 nginx
- 系统支持: Debian8+

#### 使用方法:

```bash
curl -fsSL https://raw.jiz4oh.com/jiz4oh/shell/master/nginx/install.sh | bash
```

## config.sh

- 脚本说明: 有些 nginx 安装时没有默认添加配置文件，会导致 nginx 启动报错，如 docker 安装，所以使用这个脚本自动配置 nginx
- 系统支持: Debian8+

#### 使用方法:

```bash
curl -fsSL https://raw.jiz4oh.com/jiz4oh/shell/master/nginx/config.sh | bash
```

## passenger.sh

- 脚本说明: 配置 passenger 服务器和 nginx 模块
- 系统支持: Debian9+

#### 使用方法:

```bash
curl -fsSL https://raw.jiz4oh.com/jiz4oh/shell/master/nginx/passenger.sh | bash
```
