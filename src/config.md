# Работа с настройками


<!-- Знакомим себя с Git -->
Перед первым использованием Git на машине вам необходимо представить себя.
Для этого ей необходимо передать ваше имя и адрес электронной почты, выполнив следующие две команды, предварительно вписав туда свои персональные данные:

``` bash
git config --global user.name "Иванов Иван"
git config --global user.email "mail@example.com"
```

<!-- Про команду `git config` -->
Настройки представляют набор имен переменных с заданным значением, сохраненных в конфигурационных файлах.
Команда `git config` отвечает за работу с настройками: задает переменным значение или выводит их на экран.
В командах выше переменным с именами `user.name` и `user.email` заданы значения `Иванов Иван` и `mail@example.com` соответственно.

<!-- Уровни настроек -->
Опция `--global` указывает, что настройки глобальные и оказывают влияние на все хранилища конкретного пользователя.
В противоположность к глобальным существуют локальные (опция `--local`) и системные (опция `--system`) настройки.
Локальные настройки действуют только на конкретное хранилище, а системные -- на всех пользователей в многопользовательской машине.

```{figure} images/ConfigLevels.png
```

<!-- Переопределение настроек -->
Одна и та же опция может быть задана на нескольких уровнях.
В этом случае глобальные настройки переопределяют системные, а локальные переопределяют все остальные.

<!-- Где хранятся настройки? -->
Настройки сохраняются в конфигурационных файлах.
В зависимости от уровня, файлы различаются.
Так, системные настройки хранятся в файле `/etc/gitconfig`, глобальные в `~/.gitconfig` или `~/.config/git/config`, а локальные в `.git/config` в каталоге хранилища.

<!-- Установка настройки core.editor в vim на системном уровне -->
Давайте зададим настройку `core.editor` в значение `vim` на системном уровне.
Таким нехитрым образом мы навяжем всем пользователям машины редактор Vim для написания многострочных сообщений для команды `git commit`.
На примере ниже можно увидеть, что системную настройку можно изменить только воспользовавшись правами суперпользователя.
```console
bob@pc:~$ git config --system core.editor vim
error: could not lock config file /etc/gitconfig: Отказано в доступе
bob@pc:~$ sudo git config --system core.editor vim
[sudo] пароль для bob:
bob@pc:~$
```

<!-- Установка настройки на локальном уровне -->
Давайте установим настройку `advice.addIgnoredFile` в значение `false` на локальном уровне.
Эта логическая переменная по умолчанию установлена в истину (`true`).
Из-за нее каждый раз при добавлении всех измененных файлов (командой `git add *`) в индекс на экране выводится сообщение о том, что при действии игнорируются пути, перечисленные в файле `.gitignore`.
И там же предлагает отключить эту подсказку, воспользовавшись командой `git config advice.addIgnoredFile false`.
Заметим, что если уровень настройки не задан явно в команде, то подразумевается что она локальная.
```console
bob@pc:~/projects/git-intro$ git add *
Следующие пути игнорируются одним из ваших файлов .gitignore:
_build
подсказка: Use -f if you really want to add them.
подсказка: Turn this message off by running
подсказка: "git config advice.addIgnoredFile false"
```

<!-- Просмотр настроек -->
Команда `git config --list` выводит на экран список явно установленных пользователем переменных.
Если указать опцию `--show-origin`, то перед каждой переменную будет указано название конфигурационного файла, в котором оно присутствует.

```console
bob@pc:~/projects/git-intro$ git config --list
core.editor=vim
user.email=mail@example.com
user.name=Иван Иванов
credential.helper=store
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
advice.addignoredfile=false
```

```console
bob@pc:~/projects/git-intro$ git config --list --show-origin
file:/etc/gitconfig     core.editor=vim
file:/home/bob/.gitconfig       user.email=mail@example.com
file:/home/bob/.gitconfig       user.name=Иван Иванов
file:/home/bob/.gitconfig       credential.helper=store
file:.git/config        core.repositoryformatversion=0
file:.git/config        core.filemode=true
file:.git/config        core.bare=false
file:.git/config        core.logallrefupdates=true
file:.git/config        advice.addignoredfile=false
```

Если нужно посмотреть определенную переменную, то ее имя указывают в командной строке:
Чтобы увидеть значение `user.name` выполните команду `git config user.name`.

```{note}
Полный список переменных, поддерживаемых Git, можно вывести на экран командой `git help --config`.
Тот же самый список с подробным описанием доступен в справочной странице `git-config(1)` в подразделе "Variables" раздела "CONFIGURATION FILE".
```

<!--
```
подсказка: Using 'master' as the name for the initial branch. This default branch name
подсказка: is subject to change. To configure the initial branch name to use in all
подсказка: of your new repositories, which will suppress this warning, call:
подсказка: 
подсказка: 	git config --global init.defaultBranch <name>
подсказка: 
подсказка: Names commonly chosen instead of 'master' are 'main', 'trunk' and
подсказка: 'development'. The just-created branch can be renamed via this command:
подсказка: 
подсказка: 	git branch -m <name>
```

git config --global init.defaultBranch main

-->

