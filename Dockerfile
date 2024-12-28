FROM debian:12.6

ENV UBUNTU_CODENAME=jammy

# 安装基础工具
RUN apt update && \
    apt install -y --no-install-recommends wget gpg python3-pip ansible python3-venv && \
    # 安装 Ansible 的 GPG key
    wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg && \
    # 添加 Ansible 的源
    echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | tee /etc/apt/sources.list.d/ansible.list && \
    apt update && \
    # 创建虚拟环境并激活
    python3 -m venv /opt/venv && \
    # 使用虚拟环境的 pip 安装所需 Python 包
    /opt/venv/bin/pip install --no-cache-dir --upgrade pip && \
    /opt/venv/bin/pip install --no-cache-dir "pywinrm[credssp]" requests && \
    # 清理 apt 缓存和无用的包
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# 设置虚拟环境的 PATH
ENV PATH="/opt/venv/bin:$PATH"
