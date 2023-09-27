FROM ubuntu:focal AS base
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y curl git ansible python3 python-is-python3 build-essential && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base AS prime
COPY . .
CMD ["sh", "-c", "ansible-playbook $TAGS setup.yml"]
