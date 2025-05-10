# FROM alpine:3.21.3
FROM registry.cn-hangzhou.aliyuncs.com/117503445-mirror/sync:linux.amd64.docker.io.library.alpine.3.21.3

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add nix --no-cache

RUN nix profile install --extra-experimental-features 'flakes nix-command' --option substituters https://mirrors.ustc.edu.cn/nix-channels/store github:jetify-com/devbox/0.14.2

# append to /etc/nix/nix.conf
# substituters = https://mirrors.ustc.edu.cn/nix-channels/store https://cache.nixos.org/
# RUN echo "substituters = https://mirrors.ustc.edu.cn/nix-channels/store" >> /etc/nix/nix.conf
RUN echo "substituters = https://mirrors.ustc.edu.cn/nix-channels/store https://cache.nixos.org/" >> /etc/nix/nix.conf


WORKDIR /workspace

# add /nix/var/nix/profiles/per-user/root/profile/bin to PATH
ENV PATH=/nix/var/nix/profiles/per-user/root/profile/bin:$PATH

# ENTRYPOINT [ "sh" ]
RUN apk add fish --no-cache
ENTRYPOINT [ "fish" ]