# Управление версиями

<!-- Что такое проект -->
Прежде чем перейти к управлению версиями внимательно посмотрим на то, версией чего собираемся управлять.
Программное обеспечение собирается из исходных кодов по инструкциям, заложенным в сценариях сборки.
Состояние программы, которое редактирует программист -- это набор текстовых файлов.
Все эти файлы образуют *проект программы* и располагаются в *каталоге проекта*.
Если файлов много, то они группируются по подкаталогам в зависимости от назначения.

Пройдите по [ссылке](https://gitlab.com/libeigen/eigen) к исходным кодам проекта Eigen.
Eigen -- это открытая библиотека C++ для работы с объектами линейной алгебры как векторов и матриц и функций для решения систем уравнений.
Обратите внимание на следующие каталоги:
* `bench`, бенчмарки -- тесты, оценивающие производительность основных функций;
* `cmake`, сценарии CMake, используемые для сборки библиотеки;
* `doc`, документация к классам и функциям библиотеки;
* `test`, модульные тесты.

```{figure} ./images/eigen-screenshot.png
```

<!-- Что такое хранилище -->
Git хранит не сами файлы проекта, а их изменения.
По серии изменений она способна восстановить состояние файлов на любой момент времени.
Изменения хранятся в специальной базе данных, называемой *хранилищем*.
Иногда его называют *репозиторием*.
Для конечного пользователя внутреннее строение хранилища интереса не представляет, так как взаимодействие с ним происходит посредством команд.
Фактически, хранилище -- это каталог с файлами под управлением Git.
В нем содержится история изменений файлов, настройки, указатели на ревизии типа ветки и теги, промежуточные состояния некоторых команд.

<!-- Извлечение рабочей копии -->
Для пользователя Git интерес представляют файлы проекта.
Их следует *извлечь* из хранилища.
Извлеченные файлы называют *рабочей копией*, и они располагаются в *рабочем каталоге*.

```{figure} ./images/worktree.png
```

<!-- Фиксация изменений в хранилище -->
В ходе работы над проектом рабочая копия будет изменена.
Когда работа близится к логическому завершению, изменения заносятся в хранилище, т.е. *фиксируются* в нем.
После фиксации в хранилище появляется запись, называемая *коммитом*.
Коммит -- это зафиксированный набор изменений.
Действие по фиксации еще называют *сделать коммит*, *закоммитить*, *зафиксировать изменения* или *внести изменения*.
Получившаяся после коммита версия проекта называется *ревизией*.

<!-- Удаленное хранилище -->
Каждый участник команды должен иметь доступ к проекту, а именно к его хранилищу.
Для этого хранилище выкладывают на сервер.
Через него происходит обмен изменениями.
У хранилища есть адрес, по которому к нему обращаются.
Процесс получения копии хранилища называют *клонированием*.
Клонируемое хранилище называют *удаленным*, а получившуюся копию -- *локальным*.

```{figure} ./images/local-remote-repo.png
```

<!-- Каталог хранилища -->
Обратим внимание, что в распределенной СКВ, к которой относится Git, нет различий между хранилищами одного проекта.
Локальное хранилище есть полная копия удаленного, но отличаются они функциями.
Удаленное хранилище используют для обмена результатами работы, а локальное хранилище -- для изменений проекта.

```{note}
Локальное хранилище располагается в каталоге с проектом и имеет название `.git`, а удаленное называют по имени проекта и добавляют расширение `.git`.
Точка в начале имени файла или каталога показывает, что в системе UNIX он скрытый и не будет показан стандартными средствами.
```

<!-- Проталкивание и получение изменений из удаленного хранилища -->
Как только разработчик решает поставленную перед ним задачу, он превращает изменения в проекте в коммиты в хранилище.
Затем коммиты *проталкиваются* (отправляют, выкладывают) в удаленное хранилище.
Это действие также называют как "запушить" -- русская калька от английского "push".
Другие участники процесса забирают изменения из удаленного хранилища.
В отличие от клонирования, здесь происходит загрузка только недостающих коммитов.

<!-- Ветка -->
Каждое следующее изменение, оформленное в виде коммита, основывается на последнем состоянии проекта.
В итоге мы получаем линейную историю изменений.
Что произойдет если, несколько участников разработки попробуют одновременно выложить свои изменения?
Если это произойдет, то на сервере будут доступны несколько последних ревизий одного проекта.
Ситуация, когда в хранилище есть необъединенные коммиты, разрешена.
В итоге формируются *ветки* -- альтернативные пути развития проекта с общей историей.

```{figure} ./images/branch.png
```

<!-- Слияние веток -->
Если в хранилище несколько веток, то перед участниками разработки встаёт вопрос: какой из последних ревизий взять за основу для развития проекта?
Чтобы такого не происходило, среди нескольких веток выделяют *основную*, на которую опираются при работе остальные.
Остальные изменения, если они хотят стать частью проекта, должны быть интегрированы в основную ветку.
Объединение изменений в одной ревизии называют *слиянием изменений (веток)*

<!-- Автоматическое и ручное слияние изменений -->
В большинстве случаев изменения от разных участников не пересекаются, так как выполняются в различных модулях, файлах и функциях.
Это позволяет сливать изменения автоматически, что происходит часто.
Если изменения пересекаются, например одна и та же строка была изменена по разному, то слияние производится вручную.
Тот, кто выполняет слияние, выбирает одно из двух изменений или объединяет их.

