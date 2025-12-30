FROM python:3.14-alpine

COPY entrypoint.sh /entrypoint.sh

RUN pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir requests bypy

RUN chmod +x /entrypoint.sh

ENV TZ=Asia/Shanghai

VOLUME /apps

CMD ["/entrypoint.sh"]