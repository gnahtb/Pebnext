FROM randomdude/gcc-cross-x86_64-elf

RUN apt-get update 
RUN apt-get upgrade -y
RUN apt-get install -y grub-common grub-pc-bin xorriso
RUN apt-get install -y nasm 

VOLUME /workspace
WORKDIR /workspace