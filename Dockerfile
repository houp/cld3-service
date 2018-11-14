
FROM python:3
LABEL maintainer="Witold Bolt <witold.bolt@jit.team>"

RUN apt-get update
RUN apt-get install -y nginx git protobuf-compiler libprotobuf-dev
RUN pip3 install uwsgi flask Cython protobuf
RUN git clone https://github.com/houp/cld3.git
RUN cd cld3/src && protoc --cpp_out=. *.proto && cd .. && python3 ./setup.py install
COPY ./app.py /app/
WORKDIR /app
COPY ./nginx.conf /etc/nginx/sites-enabled/default
CMD service nginx start && uwsgi -s /tmp/uwsgi.sock --chmod-socket=666 --manage-script-name --mount /=app:app