FROM debian:buster
MAINTAINER Theo Pons <tpons@student.42.fr>
COPY ./srcs/test.sh .
CMD bash test.sh