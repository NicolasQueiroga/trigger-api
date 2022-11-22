FROM python:3.9-alpine3.13
LABEL maintainer="https://github.com/NicolasQueiroga"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
COPY ./api /api
COPY ./scripts /scripts

WORKDIR /api
EXPOSE 8000

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk update && \
    apk add gcc libc-dev make git libffi-dev openssl-dev python3-dev libxml2-dev libxslt-dev && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-deps \
        build-base postgresql-dev musl-dev linux-headers && \
    /py/bin/pip install -r /requirements.txt && \
    apk del .tmp-deps && \
    adduser --disabled-password --no-create-home api && \
    mkdir -p /vol/web/static && \
    mkdir -p /vol/web/media && \
    chown -R api:api /vol && \
    chmod -R 755 /vol && \
    chmod -R +x /scripts


ENV PATH="/scripts:/py/bin:$PATH"

USER api

CMD ["run.sh"]