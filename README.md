# Hentai@Home Docker

*Run H@H as a non-root user in the docker.*

## Usage

```bash
docker run -d --name hath \
    -p 443:443 \
    -v $PWD/data:/hath/data \
    -v $PWD/download:/hath/download \
    -v $PWD/cache:/hath/cache \
    -v $PWD/log:/hath/log \
    -v /dev/shm/hath:/hath/temp \
    -e HatH_KEY=12345-xXxXxXxXxXxXxXxXxXxX \
    -e PUID=$(id -u) \
    -e "JVM_OPT=-Xmx512m -Xms512m" \
    mocukie0/hath --rescan_cache=true --verify_cache=true
```

## Parameters

| Param                                   | Description                                                                                       |
|-----------------------------------------|---------------------------------------------------------------------------------------------------|
| -p 443:443                              | H@H port set in your configuration page, host port must be match container port.                  |
| -v /hath/data                           | H@H data directory to store your login info.                                                      |
| -v /download                            | Location of H@H downloads on disk.                                                                |
| -v /hath/cache                          | H@H cache directory.                                                                              |
| -v /hath/log                            | H@H log directory.                                                                                |
| -v /hath/temp                           | H@H temp directory.                                                                               |
| -e HatH_KEY=12345-xXxXxXxXxXxXxXxXxXxX  | The Key format is ${client_id}-${client_key}, id and key can be found on your configuration page. |
| -e PUID=$(id -u)                        | Avoid volumes permissions issues between Host and Container.                                      |
| -e "JVM_OPT=-Xmx512m -Xms512m"          | Custom java vm options.                                                                           |
| --rescan_cache=true --verify_cache=true | The arguments passed  to HentaiAtHome.jar, see ehwiki.                                            |


## License
[MIT](LICENSE)
