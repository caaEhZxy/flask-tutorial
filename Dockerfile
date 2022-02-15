FROM python:3.9.5-alpine

ENV TIME_ZONE=Asia/Shanghai
COPY requirements.txt /
RUN pip3 install -r /requirements.txt -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

COPY . /app
WORKDIR /app
RUN chmod +x ./gunicorn.sh

ENTRYPOINT ["./gunicorn.sh"]