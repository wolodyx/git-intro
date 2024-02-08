# Настройка рабочего окружения


<!-- Рабочее окружение Ubuntu -->
Для выполнения упражнений нам понадобится настроенное рабочее окружение Ubuntu.
В учебных классах оно доступно в виде виртуальной машины VirtualBox с названием "ubuntu-22.04".
Дома вы можете настроить ее самостоятельно, установив Ubuntu последней версии и поставив пакеты следующими командами:
```bash
sudo apt -y install vim tmux rcs git-gui
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
```

