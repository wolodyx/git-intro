# Клонирование хранилища

<!-- О команде `git clone` -->
Команда `git clone` клонирует хранилище, адрес которого передано в качестве аргумента команды.
Вторым, необязательным, аргументом выступает имя рабочего каталога.

<!-- Пример клонирования удаленного репозитория -->
Склонируем хранилище проекта MPICH, расположенного по адресу `https://github.com/pmodels/mpich.git`.
```console
bob@pc:~/projects$ git clone https://github.com/pmodels/mpich.git
Клонирование в «mpich»...
remote: Enumerating objects: 250143, done.
remote: Counting objects: 100% (3214/3214), done.
remote: Compressing objects: 100% (1278/1278), done.
remote: Total 250143 (delta 2145), reused 2749 (delta 1933), pack-reused 246929
Получение объектов: 100% (250143/250143), 86.52 МиБ | 5.65 МиБ/с, готово.
Определение изменений: 100% (194822/194822), готово.
bob@pc:~/projects$ ls mpich/
autogen.sh  confdb        contrib       COPYRIGHT  examples  Makefile.am  mpich-doxygen.in  RELEASE_NOTES  test
CHANGES     configure.ac  CONTRIBUTING  doc        maint     modules      README.vin        src
```

Команда создала в текущем каталоге каталог `mpich`, название которого совпало с названием удаленного хранилища в аргументе-адресе (после исключения расширения `.git`).
Если перед клонированием такой **непустой** каталог существовал, то команда завершилась бы с ошибкой.
Чтобы склонировать хранилище в другой рабочий каталог, его имя передается в команду аргументом после адреса:
``` bash
git clone https://github.com/pmodels/mpich.git mpich2
```
Если каталога с таким именем не существует, то он будет создан.
Если он существует, то он должен быть пустым.
Чтобы склонировать хранилище в текущий пустой каталог, передают аргумент `.`, обозначающий текущий каталог:
``` bash
mkdir mpich
cd mpich
git clone https://github.com/pmodels/mpich.git .
```

```{warning}
Часто точку (обозначение текущего каталога) в конце команды не замечают.
Или ее не видят или думают, что она обозначает конец предложения.
```

<!-- Клонирование только части истории -->
Большие проекты клонируются долго и нагружают сеть.
Большую часть передаваемых данных занимает история.
При медленной скорости загрузки или ограниченного трафика мы готовы пожертвовать частью истории в пользу быстрой загрузки.
Опция `--depth` (переводится с английского как "глубина") принимает целое число -- количество последних коммитов, которые будут загружены.
```
git clone --depth=1 https://github.com/pmodels/mpich.git
```

При клонировании, сервер не потребовал у нас логина и пароля.
Это произошло потому, что мы обращались к *публичному хранилищу*.
Проекты с открытым исходным кодом размещают в публичных хранилищах.
В противоположность им, *приватные хранилища* разрешают доступ к своим содержимым только авторизированным пользователям.

<!-- Адрес удаленного хранилища -->
Адрес удаленного хранилища подчиняется общему шаблону.
В нем можно выделить:
* протокол;
* имя git-сервера;
* имя пользователя, управляющего хранилищем;
* имя хранилища.

`[протокол]://[имя git-сервера]/[имя пользователя]/[имя хранилища]`

<!-- Про протокол -->
Протокол задает способ приема и передачи данных и аутентификацию пользователя.
Git поддерживает четыре протокола: http, ssh, локальный (file) и git-протокол, из которых популярны первые три.

<!-- Имя сервера -->
Примерами имен git-серверов могут быть:
* `github.com`;
* `gitlab.com`;
* `gitlab.company.ru`;

<!-- Имя пользователя и хранилища -->
То, что хранилище размещено в пространстве пользователя, позволяет использовать совпадающие имена проектов для разных пользователей.

```{figure} ./images/repo-address.png
```

<!--
% Чистое хранилище
Удаленному хранилищу не нужна рабочая копия, поэтому оно состоит только из каталога с хранилищем.
Хранилище, не требующее извлечения рабочей копии, называют также *чистым* (bare).
Удаленные хранилища являются чистыми.
-->

