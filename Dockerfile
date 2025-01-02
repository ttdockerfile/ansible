FROM debian:12.6

ENV UBUNTU_CODENAME=jammy

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources && apt update && \
    apt install wget gpg -y && \
    wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | tee /etc/apt/sources.list.d/ansible.list && \
    apt update && apt install python3-pip ansible -y && \
    apt clean && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip -i https://mirrors.ustc.edu.cn/pypi/simple --break-system-packages && \
    pip3 install "pywinrm[credssp]" -i https://mirrors.ustc.edu.cn/pypi/simple --break-system-packages && \
    pip3 install requests -i https://mirrors.ustc.edu.cn/pypi/simple --break-system-packages

# 安装 ansible.windows 集合
RUN ansible-galaxy collection install ansible.windows
