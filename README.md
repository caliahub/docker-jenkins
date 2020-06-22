#### jenkins版本：2.222.1

#### docker启动示例：
```
docker run -d -p 8080:8080 -p 50000:50000 --restart=always caliahub/jenkins:2.222.1
```

#### docker-compose启动示例：
```
version: '3'
services:
  redis:
    image: caliahub/jenkins:2.222.1
    restart: always
    ports:
      - 8080:8080
      - 50000:50000
```
