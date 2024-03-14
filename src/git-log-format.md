# Формат вывода коммитов

<!-- STEP: Введение -->
В этом разделе рассмотрим опции команды `git log`, которые настраивают отображаемый текст на экране.

* выбор одного из вариантов стандартного отображения (опции `--oneline`, `--format` со значениями `short`, `full`, `oneline`, ...);
* настройка собственного формата отображения (опция `--format="..."`);
* включение дополнительной информации (опции `--patch` и `--stat`);
* вывод относительной даты (опция `--relative-date`).


<!-- STEP: Опция `--format=<type>` -->
Существуют различные варианты отображения информации о коммите на экране, которые могуг быть выбраны опцией `--format=type`, где `type` имеет одно из следующих значений:
* `oneline`
* `short`
* `full`
* `fuller`
* `reference`
* `email`
* `raw`
* `medium`

Формат `--format=oneline`, как вытекает из названия, выводит информацию о коммите компактно одной строкой, содержащей только хеш-сумму и сообщение коммита.
Однострочный вывод также доступен опцией `--oneline`, но только в этом случае хеш коммита дан в сокращенном виде.

``` text
317d080fd9d7d66955e4bc2055a08b4edb044cf1 (HEAD -> main, origin/main, origin/HEAD) Исправлена утечка серверного сокета
8e36f074fb3374c6d0007c934765d3f6a17d955e Закрытие клиентских сокетов на стороне сервера
ea3a417d17049d6b450a0076d82898f964213b6c Автоматическое закрытие клиента при потере связи с сервером
```

Формат `--format=short` расширяет предыдущий вывод информацией об авторе коммита.

``` text
commit 317d080fd9d7d66955e4bc2055a08b4edb044cf1 (HEAD -> main, origin/main, origin/HEAD)
Author: wolodyx <wolodyx@yandex.ru>

    Исправлена утечка серверного сокета
```

Опции `--format=full` и `--format=fuller` добавляют поля об авторе и коммитере соответственно.


<!-- STEP: Опция `--format` с собственным форматом -->
Опция `--format` дополнительно предлагает возможность задания собственного формата:
`git log --format=format:"строка формата"`
В строке формата указывают опции, которые при выводе заменяются полями коммита.
Вот некоторые из них:

| Опция |         Описание         |
|-------|--------------------------|
|  %H   | Хеш коммита              | 
|  %h   | Сокращенный хеш коммита  | 
|  %an  | Имя автора               | 
|  %ae  | Электронная почта автора | 
|  %ad  | Дата автора              | 
|  %s   | Содержание               | 

Введем собственный компактный формат отображения, где в одной строке указаны имя автора и сообщение, разделенные символами `==>`.
Применим команду к хранилищу проекта [json](https://github.com/nlohmann/json.git) от пользователя [nlohmann](https://github.com/nlohmann).

``` console
skt@home:~/MyProjects/json$ git log --format=format:"%an ==> %s"
Raphael Grimm ==> Prevent memory leak when exception is thrown in adl_serializer::to_json (#3901)
dependabot[bot] ==> ⬆️ Bump future from 0.18.2 to 0.18.3 in /docs/mkdocs (#3934)
Joyce ==> Refactor amalgamation workflow to avoid dangerous use of pull_request_target (#3969)
Sergei Trofimovich ==> custom allocators: define missing 'rebind' type (#3895)
theevilone45 ==> Fix typo in test.cmake (#3951)
Arsen Arsenović ==> tests/unit-iterators2: use std::ranges::equals for range comparisons (#3950)
haadfida ==> removed lgtm badge and added Cirrus CI badge (#3937)
Florian Segginger ==> Change 2022 to 2023 (#3932)
Raphael Grimm ==> Fix CI issues (#3906)
Finkman ==> PrettyPrinter: Check if match is valid before accessing group (#3920)
Niels Lohmann ==> Try old MinGW script (#3892)
Niels Lohmann ==> Upgrade Python packages (#3891)
Niels Lohmann ==> Fix warning about moved from object (#3889)
Niels Lohmann ==> Remove a magic number (#3888)
Niels Lohmann ==> Add migration guide (#3887)
Niels Lohmann ==> Clang 15 (#3876)
:
```

