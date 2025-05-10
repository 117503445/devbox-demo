# FROM alpine:3.21.3
FROM registry.cn-hangzhou.aliyuncs.com/117503445-mirror/sync:linux.amd64.docker.io.library.alpine.3.21.3

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add nix --no-cache

RUN nix profile install --extra-experimental-features 'flakes nix-command' --option substituters https://mirrors.ustc.edu.cn/nix-channels/store github:jetify-com/devbox/0.14.2

WORKDIR /workspace

ENTRYPOINT [ "sh" ]