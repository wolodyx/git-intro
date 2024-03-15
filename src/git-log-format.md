# Отображение коммитов

<!-- STEP: Введение -->
В этом разделе рассмотрим опции команды `git log`, которые настраивают содержимое коммитов на экране.
Мы научимся:
* выбирать один из вариантов отображения (опции `--oneline`, `--format` со значениями `short`, `full`, `oneline`, ...);
* настраивать собственный формат отображения (опция `--format="форматная строка"`);
* включать дополнительную информацию о коммите (опции `--patch` и `--stat`);
* выводить относительные даты (опция `--relative-date`).


<!-- STEP: Опция `--format=<type>` -->
Существуют различные варианты отображения коммита на экране.
Вариант указывает опция `--format=type`, где `type` имеет одно из следующих значений: `oneline`, `short`, `full`, `fuller`, `reference`, `email`, `raw`, `medium`.
По умолчанию, Git использует `medium`.

Формат, заданный опцией`--format=oneline`, как вытекает из названия, выводит сообщение о коммите одной строкой.
Строка состоит из идентификатора и заголовка описания:
```
0d933fc0d9bb7bdaed1997c0ae06567115242f74 Ninja: Update showIncludes prefix detection for clang-cl 18
```
Компактный однострочный вывод за счет усечения до 10 цифр идентификатора дает опция `--oneline`:
```
0d933fc0d9 Ninja: Update showIncludes prefix detection for clang-cl 18
```
Похожее однострочное представление выводит формат `--format=reference`.
Оно используется для человекочитаемой ссылки к описаниям других коммитов.
Ссылка состоит из укороченного до 10 цифр идентификатора и заключенных в круглые скобки заголовка сообщения и даты.
```
0d933fc0d9 (Ninja: Update showIncludes prefix detection for clang-cl 18, 2024-02-06)
```
Остальные предопределенные форматы (`short`, `full`, `fuller`, `email`, `raw`, `medium`) многострочные.

Формат `--format=short` расширяет предыдущий вывод информацией об авторе коммита: его имени и электронной почте.
Уже информация не помещается в одну строчку и каждое поле помещается в отдельную строку.
``` % --format=short
commit 0d933fc0d9bb7bdaed1997c0ae06567115242f74
Author: Martin Storsjö <martin@martin.st>

    Ninja: Update showIncludes prefix detection for clang-cl 18
```

Формат `medium` добавляет к формату `short` дату и время создания коммита, а описание коммита содержит уже дополнительно к заголовку тело.
Данный формат `git log` выбирает по умолчанию.

```{figure} ./images/git-log-medium.png
```

Формат `full` убирает из формата `medium` запись о дате и времени, оставляя остальное неизменным.
% --format=full
```
commit 0d933fc0d9bb7bdaed1997c0ae06567115242f74
Author: Martin Storsjö <martin@martin.st>
Commit: Brad King <brad.king@kitware.com>

    Ninja: Update showIncludes prefix detection for clang-cl 18
    
    Since commit LLVM/Clang commit `5523fefb01c2` ([clang][lex] Use
    preferred path separator in includer-relative lookup, 2023-09-08), part
    of the upcoming 18.x release, the output format of the showIncludes flag
    has changed, where it now prints paths with double backslashes:
    
        Note: including file: .\\foo.h
    
    Previously, we expected to see the path name in the form "./foo.h".
    
    Extend the regex to match a path name starting with `.\`, in addition to
    the existing matched patterns.
```

Формат `fuller` добавляет к формату `medium` информацию о коммитере и время принятия коммита в хранилище.
% --format=fuller
```
commit 0d933fc0d9bb7bdaed1997c0ae06567115242f74
Author:     Martin Storsjö <martin@martin.st>
AuthorDate: Tue Feb 6 23:58:44 2024 +0200
Commit:     Brad King <brad.king@kitware.com>
CommitDate: Wed Feb 7 09:38:14 2024 -0500

    Ninja: Update showIncludes prefix detection for clang-cl 18
    
    Since commit LLVM/Clang commit `5523fefb01c2` ([clang][lex] Use
    preferred path separator in includer-relative lookup, 2023-09-08), part
    of the upcoming 18.x release, the output format of the showIncludes flag
    has changed, where it now prints paths with double backslashes:
    
        Note: including file: .\\foo.h
    
    Previously, we expected to see the path name in the form "./foo.h".
    
    Extend the regex to match a path name starting with `.\`, in addition to
    the existing matched patterns.
```

Формат `email` подготавливает описание коммита к отправке по почте из командной строки.
% --format=email
```
From 0d933fc0d9bb7bdaed1997c0ae06567115242f74 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Martin=20Storsj=C3=B6?= <martin@martin.st>
Date: Tue, 6 Feb 2024 23:58:44 +0200
Subject: [PATCH] Ninja: Update showIncludes prefix detection for clang-cl 18

Since commit LLVM/Clang commit `5523fefb01c2` ([clang][lex] Use
preferred path separator in includer-relative lookup, 2023-09-08), part
of the upcoming 18.x release, the output format of the showIncludes flag
has changed, where it now prints paths with double backslashes:

    Note: including file: .\\foo.h

Previously, we expected to see the path name in the form "./foo.h".

Extend the regex to match a path name starting with `.\`, in addition to
the existing matched patterns.
```

Формат `raw` выводит описание коммита во внутреннем представлении.
Здесь видим, что появился поле `parent` -- указатель на родительский коммит.
Поле `tree` -- это внутренний объект Git, который содержит изменения.
``` % --format=raw
commit 0d933fc0d9bb7bdaed1997c0ae06567115242f74
tree a35cd4850c3d520af1a3b21d626a1a576a640327
parent a88acb0a419d184102c65ee9456950f2cea1cc71
author Martin Storsjö <martin@martin.st> 1707256724 +0200
committer Brad King <brad.king@kitware.com> 1707316694 -0500

    Ninja: Update showIncludes prefix detection for clang-cl 18
    
    Since commit LLVM/Clang commit `5523fefb01c2` ([clang][lex] Use
    preferred path separator in includer-relative lookup, 2023-09-08), part
    of the upcoming 18.x release, the output format of the showIncludes flag
    has changed, where it now prints paths with double backslashes:
    
        Note: including file: .\\foo.h
    
    Previously, we expected to see the path name in the form "./foo.h".
    
    Extend the regex to match a path name starting with `.\`, in addition to
    the existing matched patterns.
```


<!-- STEP: Опция `--format="форматная строка"` -->
Опция `--format` дополнительно предлагает возможность задания собственного формата вывода:
`git log --format=format:"строка формата"`
Строка формата содержит символы:
* заменителя, замещаемых полями коммита при выводе;
* управления цветом;
* управления положением курсора;

Вот некоторые из заменителей:

| Заменители |     Описание        |
|-------|--------------------------|
|  %H   | хеш коммита              | 
|  %h   | сокращенный хеш коммита  | 
|  %an  | имя автора               | 
|  %ae  | электронная почта автора | 
|  %ad  | дата создания коммита автором | 
|  %s   | заголовок описания       | 
|  %b   | тело описания            | 

Введем собственный компактный формат отображения, где в одной строке указаны имя автора и сообщение, разделенные символами `==>`.
Применим команду к хранилищу проекта [json](https://github.com/nlohmann/json.git) от пользователя [nlohmann](https://github.com/nlohmann).

``` console
skt@home:~/projects/json$ git log --format=format:"%an ==> %s"
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
:
```


<!-- STEP: Опция `--stat` -->
Опция `--stat` выводит статистику коммита.
В нее входят список затронутых файлов и количества добавленных и удаленных строк.



<!-- STEP: Опция `--patch` -->



<!-- STEP: Опция `--relative-date` -->

