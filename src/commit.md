# Фиксация изменений


## Введение

Прежде чем начать фиксировать изменения в файлах, необходимо познакомиться с состояниями файлов, наблюдения и управления ими.
Это осуществляется командами `git status` и `git add`.


## Состояния файлов

Познакомимся с состояниями файлов, в которых они могут быть для Git.
Научимся видеть эти состояния командой `git status`.

<!-- Отслеживаемые и неотслеживаемые файлы -->
Git интересуют файлы в рабочем каталоге, но не за его пределами.
Интерес выражается в том, что в последующем пользователю будет предложено добавить изменения в них в историю хранилища.
Все файлы в рабочем каталоге делятся на *отслеживаемые* (tracked) и *неотслеживаемые* (untracked).
К отслеживаемым файлам относятся те, которые до этого присутствовали в ревизии, из которой извлечена рабочая копия.
Недавно созданные файлы, еще не попавшие в историю или индекс (который мы рассмотрим ниже), будут относится к категории неотслеживаемых.

```{figure} ./images/file-states.png
```

<!-- Неотслеживаемые файлы и артефакты сборки -->
В процессе работы над проектом в рабочем каталоге появляются новые файлы, например, сгенерированные системой сборки, компилятором, тестовой системой, архиватором.
Сюда входят объектные, исполняемые, временные и архивные файлы.
Эти файлы производны от исходных кодов, сценариев сборки и представляют краткосрочный интерес.
Их еще называют *артефактами сборки*.
Даже если их удалить из файловой системы, они могут быть повторно получены пересборкой программы.
Считается хорошей практикой держать артефакты сборки в отдельном каталоге, как например в `CMake`.
Но система сборки `Make` создает артефакты рядом с файлами исходным кодом, что засоряет рабочий каталог.

<!-- Файл `.gitignore` -->
Таким образом, все неотслеживаемые файлы можно разделить на две категории:
* новые файлы, добавляемые в скором времени в следующую ревизию;
* игнорируемые, путь в хранилище которым закрыт навсегда.

Чтобы файлы из первой категории не потерялись среди многочисленных файлов второй, в Git добавлены списки игнорируемых файлов и каталогов.
Они перечисляются в файле `.gitignore` в формате регулярных выражений.
Сам файл располагается в корне рабочего каталога.
Содержимое этого файла зависит от используемого языка программирования, библиотек и инструментов.
Разработчики GitHub в открытом проекте [gitignore](https://github.com/github/gitignore) собрали примеры этих файлов с привязкой к используемым программным технологиям.

<!-- Отслеживаемые файлы -->
Отслеживаемые файлы составляют проект программы и основу для следующей ревизии.
Они в свою очередь делятся на три части:
* зафиксированные;
* измененные;
* проиндексированные.

```{figure} ./images/file-states-flow.png
```

<!-- Зафиксированный и измененный файлы -->
После клонирования и последующего извлечения рабочей копии все файлы в рабочем каталоге относятся к зафиксированным.
Если отредактировать зафиксированный файл, то он перейдет в измененное состояние.
Если откатить изменения у измененного файла, то он перейдет обратно в зафиксированное состояние.

<!-- Проиндексированный файл -->
Индексированные файлы предназначены для включения изменений в историю.
По-другому, индексированный файл рассматривается как измененный файл, помещенный в специальную область, называемую *индексом*.
Индекс -- это область, дополнительная к рабочей копии и хранилищу.
Физически она расположена внутри хранилища, не передается и не клонируется.

```{figure} ./images/git-index.png
```

```{note}
Файл, помещенный в индекс, уже не является измененным.
Но если после индексации файл изменить еще раз, то он одновременно будет измененным и проиндексированным.
```

<!-- `git status` и состояние файлов -->
Состояние файлов в рабочем каталоге показывает команда `git status`.
В примере ниже она показывает, что файл `LampServer.cpp` изменен и неотслеживаются файлы из каталога `build/`.

``` console
skt@home:~/MyProjects/RemoteLamps$ git status
На ветке main
Ваша ветка обновлена в соответствии с «origin/main».

Изменения, которые не в индексе для коммита:
  (используйте «git add <файл>…», чтобы добавить файл в индекс)
  (используйте «git restore <файл>…», чтобы отменить изменения в рабочем каталоге)
	изменено:      LampServer.cpp

Неотслеживаемые файлы:
  (используйте «git add <файл>…», чтобы добавить в то, что будет включено в коммит)
	build/

нет изменений добавленных для коммита
(используйте «git add» и/или «git commit -a»)
```

<!-- Компактный вывод команды `git status` -->
Кроме состояний файлов, команда также подсказывает как изменить эти состояния.
На первых порах эти подсказки помогают, но в будущем многословность только мешают.
Компактный вывод делает опция `-s` (`--short`) ("short" переводится с английского как "короткий").

``` console
skt@home:~/MyProjects/RemoteLamps$ git status -s
M  LampServer.cpp
?? build/
```

<!-- Переход в следующий раздел -->
Как переводить файл из одного состояния в другой узнаем ниже.


## Управление состоянием файлов

<!-- Откат изменений в файле -->
Для изменения текстового файла достаточно воспользоваться редактором.
Откатить изменения и вернуть содержимое файла в начальное состояние позволяет команда `git restore`.

<!-- Помещение измененного файла в индекс -->
Команда `git add` помещает фиксируемые файлы в индекс, еще говорят -- индексирует файлы.
Эта же команда применима и к неотслеживаемым файлам, чтобы превратить их в историю.

<!-- Исключение файла из индекса -->
Команда `git restore` с опцией `--staged` исключает файл из индекса.

<!-- Удаление фиксированных файлов -->
На практике возникает ситуация, когда нужно удалить зафиксированный файл.
Например, если файл с исходным кодом больше не используется или по ошибке был зафиксирован ненужный файл.
Системная утилита `rm` удаляет файл из файловой системы.
После такого удаления файл отметится как измененный с пометкой "удалено" в выводе команды `git status`.
Команда `git add` проиндексирует измененный (удаленный) файл, чтобы в последующем зафиксировать его в истории.
Последовательность эффектов от `rm` и `git add` повторяет команда `git rm`, которая удалит файл и сразу поместит его в индекс.
Git защищает данные от потери и ограничивает случайное удаление измененных файлов.
Удаляемый файл должен быть фиксированным.
Если это не так, то придется отменить изменения или передать команде удаления опцию `--force` или `--cached`.

<!-- Шаблоны в аргументах -->
Команды `git restore`, `git add`, `git rm` выше мы использовали только одним аргументом-файлом.
На практике приходится оперировать несколькими файлами.
Вызывать команду для каждого файла по отдельности утомительно и не эффективно.
Есть два способа, чтобы обойти эту ситуацию:
1) передать несколько аргументов;
2) использовать регулярные выражения в аргументах.

Так, команда `git add *.c` добавляет в индекс все файлы в текущем каталоге с расширением `.c`, а команда `git rm **/*.log` удалит во всех вложенных каталогах зафиксированные файлы с расширением `.log`.

<!-- Перемещение фиксированных файлов -->
Следующая операция, кроме удаления -- это перемещение файлов, которая также реализует переименование.
Перемещение файлов и каталогов выполняет системная утилита `mv`.
Состояние перемещенного файла команда `git status` показывается как изменение файла с пометкой "удалено" и появление неотслеживаемого файла.
После индексации обоих файлов, Git обнаружит и покажет перемещение.

```console
bob@pc:~/projects/repo$ mv main.c main.cpp
bob@pc:~/projects/repo$ git status -s
 D main.c
?? main.cpp
bob@pc:~/projects/repo$ git add main.c
main.cpp
bob@pc:~/projects/repo$ git status -s
R  main.c -> main.cpp
```

Команда `git mv` объединяет в себе функции утилиты `mv` и команды `git add`.
Она перемещает файлы и сразу добавляет информацию об этом в индекс.
Тот же самый эффект выше можно было бы достигнуть командой `git mv main.c main.cpp`.

<!-- Переход в следующий раздел -->
Цель этого раздела -- подготовить индекс для последующей фиксации.
Следующий раздел покажет нам как выполнить фиксацию.


## Фиксация изменений

Команда `git commit` фиксирует изменения в хранилище, добавляя во внутреннюю базу данных запись, называемую *коммитом*.
С коммитом связан следующий набор данных:
* изменения в файлах (будут взяты из индекса);
* сообщение, описывающее изменения (будет установлено при фиксации);
* дата и время фиксации (будут взяты из системы);
* имя и электронная почта автора изменений (были указаны при настройке Git).

```{figure} ./images/commit-structure.png
```

```{warning}
Локальное системное время должно быть синхронизировано с мировым, чтобы не возникло противоречий в данных при обмене изменениями с другим хранилищем.
```

```{warning}
Фиксация завершится с ошибкой, если ранее при настройке Git не указали имя и электронную почту пользователя.
Они были заданы при [настройке Git](config.md).
```

Будем считать, что индекс не пуст.
Зафиксируем изменения, вызвав команду `git commit`.
Команда откроет текстовый файл примерно со следующим содержимым:

```text

# Пожалуйста, введите сообщение коммита для ваших изменений. Строки,
# начинающиеся с «#» будут проигнорированы, а пустое сообщение
# отменяет процесс коммита.
#
# Текущая ветка: main
# Изменения, которые будут включены в коммит:
#       переименовано: main.c -> main.cpp
#
# Неотслеживаемые файлы:
#       text.cpy
#
```

<!-- Опция `-m` -->
Если описание коммита однострочное, то его быстрее передать команде через опцию `-m`:
```
git commit -m "Описание изменений"
```

<!-- Фиксация изменений без добавления в индекс -->
Фиксации предваряет подготовка индекса.
Команда `git commit` проиндексирует все измененные файлы автоматически, если ей передать опцию `-a` (`--all`).

<!-- Просмотр изменений перед коммитом -->
В больших и организованных проектах обращают особое внимание на сообщение и содержание коммитов.
Для этого вводят соглашения об оформлении коммитов, которым должны следовать все участники проекта.
Одно из важных требований гласит, что коммит должен содержать конкретное завершенное изменение, касающееся одной задачи.
Из него само собой вытекает четкое сообщение коммита, которое упрощает участникам изучение проекта.
Из того факта, что работа над задачей завершилась, еще не следует, что все измененные файлы пригодны для фиксации.
Если исходить из описания задачи, например "Исправление ошибки ...", то изменения в виде добавления новой строки и переименования переменных входят в задачу "Рефакторинг ...".
Изменения распределяются по нескольким коммитам.
И вот здесь особую роль играет просмотр содержания фиксируемых файлов.
Это возможно опцией `-v` (`--verbose`), когда сообщение набирается в редакторе (без опции `-m`): `git commit -v`.

```

# Пожалуйста, введите сообщение коммита для ваших изменений. Строки,
# начинающиеся с «#» будут проигнорированы, а пустое сообщение
# отменяет процесс коммита.
#
# Текущая ветка: main
# Изменения, которые будут включены в коммит:
#       изменено:      main.cpp
#
# Неотслеживаемые файлы:
#       text.cpy
#
# ------------------------ >8 ------------------------
# Не изменяйте или удаляйте строку выше этой.
# Всё, что ниже — будет проигнорировано.
diff --git a/main.cpp b/main.cpp
index ad5fe9b..ff4f753 100644
--- a/main.cpp
+++ b/main.cpp
@@ -1,7 +1,20 @@
 #include <iostream>

+void usage()
+{
+       printf("usage hello [--name UserName]\n");
+}
+
 int main(int argc, char** argv)
 {
+       for(int i = 1; i < argc; ++i)
+       {
+               if(strcmpn(argv[i],"--help",6) == 0)
+               {
+                       usage();
+                       return 0;
+               }
+       }
        return 0;
 }
```


## Дополнительные источники

* [A collection of .gitignore templates](https://github.com/github/gitignore)
* [Соглашение о коммитах](https://www.conventionalcommits.org/ru/v1.0.0/)
* [How to Write a Git Commit Message](https://cbea.ms/git-commit/)
