<img src="https://capsule-render.vercel.app/api?type=waving&color=00C3FF&height=150&section=header" width="1000" />

<div align="center">
<h1 style="font-size: 36px;">🚀 Docker-Spring-AutoBackup</h1>
</div>
</br>

## 목차
1. [🙆🏻‍♂️ 팀원](#%EF%B8%8F-팀원)
2. [🐳 프로젝트 개요 - Docker를 활용한 Spring Boot 배포](#-프로젝트-개요---Docker를-활용한-Spring-Boot-배포)
3. [🛠 미션 수행 과정](#-미션-수행-과정)
4. [📌 최종 과정 요약](#-최종-과정-요약)
5. [📚 프로젝트에서 배운 점](#-프로젝트에서-배운-점)

## 🙆🏻‍♂️ 팀원

#### 팀명 : Ctrl-4
우리FISA 4기 클라우드 엔지니어링 Ctrl-4팀

|<img src="https://avatars.githubusercontent.com/u/150774446?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/55776421?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/179544856?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/129985846?v=4" width="150" height="150"/>|
|:-:|:-:|:-:|:-:|
|김예진<br/>[@yeejkim](https://github.com/yeejkim)|이슬기<br/>[@seulg2027](https://github.com/seulg2027)|이은준<br/>[@2EunJun](https://github.com/2EunJun)|정파란<br/>[@BlueRedOrange](https://github.com/BlueRedOrange)|

---

<br>

## 프로젝트 개요 - Docker를 활용한 Spring Boot 배포

❤️ Docker

## 미션 수행 과정

### Spring log 파일 설정하고 Container로 올리기

Spring의 어플리케이션 로그파일들을 수집할 수 있도록 `logback` 을 사용한다.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>

    <!-- 콘솔 로그 설정 -->
    <appender name="CONSOLE" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <!-- 파일 로그 설정 -->
    <appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>logs/app.log</file>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <fileNamePattern>logs/app-%d{yyyy-MM-dd}.log</fileNamePattern>
            <maxHistory>7</maxHistory> <!-- 로그 파일 보관 일수 -->
        </rollingPolicy>
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <!-- 기본 로그 레벨 설정 -->
    <logger name="org.springframework" level="INFO"/>
    <logger name="edu.fisa.ce" level="DEBUG"/>
    <logger name="org.hibernate.SQL" level="DEBUG"/>
    <logger name="org.hibernate.type.descriptor.sql.BasicBinder" level="TRACE"/>

    <!-- 로그 출력 (콘솔 + 파일) -->
    <root level="INFO">
        <appender-ref ref="CONSOLE"/>
        <appender-ref ref="FILE"/>
    </root>

</configuration>
```

해당 로그를 Docker-Compose 안의 NFS 서버로 옮긴다.

```sh
#!/bin/bash

LOG_DIR="./logs" # 로그 파일이 위치한 디렉토리
DEST_DIR="/mnt/log-volumes/app-logs" # 이동할 대상 디렉토리

# 대상 디렉토리가 없으면 생성
mkdir -p "$DEST_DIR"

# 로그 파일 이동
mv "$LOG_DIR"/*.log "$DEST_DIR"

# 결과 출력
if [ $? -eq 0 ]; then
    echo "✅ 로그 파일들이 $DEST_DIR 로 이동 완료!"
else
    echo "❌ 로그 파일 이동 실패!"
fi
```

### 


### Container 상태 체크하기