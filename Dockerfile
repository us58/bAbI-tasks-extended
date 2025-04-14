FROM ubuntu:14.04

RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/torch/distro.git /root/torch --recursive && cd /root/torch && \
  bash install-deps && ./install.sh

ENV LUA_PATH='/root/.luarocks/share/lua/5.1/?.lua;/root/.luarocks/share/lua/5.1/?/init.lua;/root/torch/install/share/lua/5.1/?.lua;/root/torch/install/share/lua/5.1/?/init.lua;./?.lua;/root/torch/install/share/luajit-2.1.0-beta1/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua'
ENV LUA_CPATH='/root/.luarocks/lib/lua/5.1/?.so;/root/torch/install/lib/lua/5.1/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so'
ENV PATH=/root/torch/install/bin:$PATH

RUN git clone https://github.com/torch/argcheck.git /root/argcheck --recursive && cd /root/argcheck && \
  luarocks make rocks/argcheck-scm-1.rockspec

RUN git clone https://github.com/torch/class /root/class --recursive && cd /root/class && \
  luarocks make rocks/class-scm-1.rockspec

RUN git clone https://github.com/us58/bAbI-tasks-extended.git /root/bAbI-tasks-extended --recursive && cd /root/bAbI-tasks-extended && \
  luarocks make babitasks-scm-1.rockspec

WORKDIR /root/bAbI-tasks-extended
