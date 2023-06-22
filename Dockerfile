# 기본 이미지 선택
FROM erlang:23-alpine

# RabbitMQ 버전 및 환경 변수 설정
ENV RABBITMQ_VERSION 3.9.3

# 필수 패키지 설치 및 RabbitMQ 다운로드
RUN apk add --no-cache --virtual .build-deps \
        curl \
        gnupg \
    && curl -LO https://github.com/rabbitmq/rabbitmq-server/releases/download/v${RABBITMQ_VERSION}/rabbitmq-server-generic-unix-${RABBITMQ_VERSION}.tar.xz \
    && tar -xJf rabbitmq-server-generic-unix-${RABBITMQ_VERSION}.tar.xz \
    && mv rabbitmq_server-${RABBITMQ_VERSION} /rabbitmq \
    && rm rabbitmq-server-generic-unix-${RABBITMQ_VERSION}.tar.xz \
    && apk del .build-deps

# RabbitMQ 포트 노출
EXPOSE 5672 15672

# RabbitMQ 실행
CMD ["/rabbitmq/sbin/rabbitmq-server"]
