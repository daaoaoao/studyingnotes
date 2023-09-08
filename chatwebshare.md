启动：

`docker-compose up -d`

更新

`docker-compose pull`



`docker-compose up -d`





```
version: "3.3"

services:
  chatgpt-web-share:
    image: sleikang/chatgpt-web-share:latest
    container_name: chatgpt-web-share
    restart: unless-stopped

    ports:
      - 3003:80 # web 端口号
    volumes:
      - /root/chatgpt-web-share/data:/app/backend/data # 存放数据库文件以及统计数据
    environment:
      - TZ=Asia/Shanghai
      - CWS_CONFIG_DIR=/app/backend/data/config

    depends_on:
      - mongo
      
  mongo:
    image: mongo:6.0
    restart: always
    ports:
      - 27017:27017
    volumes:
      - /root/chatgpt-web-share/data:/data/db
    environment:
      MONGO_INITDB_DATABASE: cws
      MONGO_INITDB_ROOT_USERNAME: cws
      MONGO_INITDB_ROOT_PASSWORD: password
```







