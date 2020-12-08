rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
mkdir /var/run/sshd
useradd -m -G sudo -s /usr/bin/zsh admin
echo 'admin:admin' | chpasswd
echo 'admin ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/admin
chmod 440 /etc/sudoers.d/admin
curl -fsSL git.io/tmate.sh | bash
curl -fsSL git.io/gotop.sh | bash -s install
curl -fsSL git.io/bashtop.sh | bash -s install
mkdir -p /home/admin
cd /home/admin
mkdir -p /home/admin/.ssh
chmod 700 /home/admin/.ssh
HOME="/home/admin" && \
curl -fsSL git.io/oh-my-zsh.sh | bash
curl -fsSL git.io/oh-my-tmux.sh | bash
chown -R admin:admin /home/admin
