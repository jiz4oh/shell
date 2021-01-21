# ffmpeg 相关脚本

## multi_trans.sh

- 脚本说明: 一条命令批量转换音视频格式，支持文件名带空格情况 
- 系统支持: Debian8+

#### 使用方法:

```bash
curl -fsSL https://raw.jiz4oh.com/jiz4oh/shell/master/ffmpeg/multi_trans.sh | bash -s 转换前格式 转换后格式
```

示例：

```bash
curl -fsSL https://raw.jiz4oh.com/jiz4oh/shell/master/ffmpeg/multi_trans.sh | bash -s flv mp4
```
