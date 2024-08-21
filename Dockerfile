FROM python:3.9.19-alpine3.20

COPY entrypoint.sh /entrypoint.sh

RUN pip3 install --upgrade pip && \
    pip3 install requests bypy

RUN chmod +x /entrypoint.sh

VOLUME /apps

CMD ["/entrypoint.sh"]