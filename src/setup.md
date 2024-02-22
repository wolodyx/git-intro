# Настройка рабочего окружения

<!-- Проверка и установка Git -->
Для прохождения учебного модуля понадобится рабочая машина с установленной Git.
Проверим ее присутствие на машине.
Выполните команду `git --version` в терминале.
Если программа доступна в системе, то на экране терминала отобразится сообщение о версии, иначе об отсутствии команды.
```console
bob@pc:~$ git --version
git version 2.34.1
```

Для прохождения лекции необходима Git версии не ниже `2.23`, начиная с которой доступна команда `git restore`.
На декабрь 2024 года на [официальном сайте](https://git-scm.org) доступна версия 2.43.0.

<!-- Установка Git в Ubuntu и Windows -->
В Ubuntu программу установим из менеджера пакетов `APT`.
Дополнительно к утилитам командной строки, также установим `gitk` -- простой графический интерфейс к Git.
``` bash
sudo apt-get -y install git-all gitk
```

Для Windows доступна специальная сборка [gitforwindows](https://gitforwindows.org/).
Она содержит в себе портированную в Windows интерпретатор `bash`, интеграцию с рабочим столом и простой графический интерфейс.

<!-- lazygit -->
Также установим клиент lazygit, реализующий псевдографический интерфейс.
Проект с программой доступна по [ссылке](https://github.com/jesseduffield/lazygit).
Там же содержатся инструкции по ее установке на различные ОС.

<!-- Рабочее окружение Ubuntu -->
Для выполнения упражнений нам понадобится настроенное рабочее окружение Ubuntu.
В учебных классах оно доступно в виде виртуальной машины VirtualBox с названием "ubuntu-22.04".
Дома вы можете настроить ее самостоятельно, установив Ubuntu последней версии и поставив пакеты следующими командами:
```bash
sudo apt -y install vim tmux rcs git-gui curl tree
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
```

<!--
Дополнительно установить:
* sublime-merge;
* VSCode.
-->

