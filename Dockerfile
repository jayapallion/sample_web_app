FROM ubuntu
WORKDIR /jay
ARG folder
COPY ./$folder/ /jay
