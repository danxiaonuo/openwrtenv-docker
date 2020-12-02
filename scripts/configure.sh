wget -q https://build-scripts.project-openwrt.eu.org/init_build_environment.sh
sed -i 's/apt install/apt-get install/g' init_build_environment.sh
sed -i 's/apt clean/apt-get clean/g' init_build_environment.sh
sed -i 's/apt full-upgrade/apt-get full-upgrade/g' init_build_environment.sh
sed -i '/Chinese/d' init_build_environment.sh
chmod +x init_build_environment.sh
./init_build_environment.sh
rm init_build_environment.sh
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
