# Работа с ветками


## Введение

Про ветку и историю изменений.
Каждая новое изменение, коммит и ревизия основываются на последнем состоянии проекта.
В первом приближении мы получаем линейную историю изменений, ревизий и коммитов.
В командной работе над одним проектом одновременно и независимо трудятся несколько разработчиков.
В большинстве случаев их изменения не пересекаются, так как выполняются в различных модулях, файлах и функциях.
Изменения, которые необходимы для решения задач, могут быть большими, поэтому они состоят из нескольких отдельных коммитов.
В результате этого в системе возникают два варианта проекта, имеющие общую историю с момента начала работы и отличающиеся после него.
Эти варианты вместе с собственной историей называют ветками.
В конце концов разные варианты проекта должны быть объединены в один проект.
Это действие называется слиянием веток.


## Типы веток

*Основная ветка*.
Ветка, последнее состояние которой используется для новых изменений, и та, в которой собираются изменения от других участников проекта, называется основной (стволовой, главной).
От ревизий основной ветки требуется быть компилируемыми и успешно протестированными.
На это есть как минимум две причины.
Если разработчику попадается ревизия с нерабочей программой, то его работа встанет до момента исправления ошибки другим участником.
Если ошибку в основной ветке не исправить сразу, то это повлияет на работу всей команды.

Вторая причина, которая требует быть всем ревизиям основной ветки рабочей, это возможность применить метод "половинного деления" для поиска причины ошибки.
Чем больше объем кода, тем сложнее бывает найти причину ошибки.
Если ошибка ранее не было в программе, а появилась позже.
Методом можно воспользоваться если из ревизии основной ветки собирается и запускается программа.

*Функциональная ветка*.
Если задача объемная и не может быть решена одним коммитом ии есть вероятность сломать программу, то под решение задачи создается отдельная ветка, называемая функциональной.
Требования к ревизиям в ней менее строгие, чем в основной.
Хороший разработчик будет фиксировать только компилируемые изменения, но от полного тестирования программы обычно временно отказываются, перенеся его на позднее время.
Ошибки в программе стабилизируются последующими коммитами.
После того, как задача решается в функциональной ветке и изменения будут протестированы, их перенесут в основну ветку одним коммитом.

*Релизная ветка*.
Слово "release" переводится с английского как "выпускать на волю".
Релиз -- это финальная ревизия программы, которая подготавливается или готова для передачи пользователю.
В отличие от основной версии программы в релизной только исправляются ошибки.
Изменения, добавляющие новую функцию или изменяют структуры программы не происходят.
Для поддержки релиза создают отдельный вариант проекта в виде релизной ветки.
Из релизной ветки в основную забираются изменения, связанные с исправлением ошибок, но сама ветка остается с системе для поддержки пользователей старой версии программы.

## Слияние изменений и разрешение конфликтов

Бывает необходимым объединить результаты работы двух разработчиков, что называется слиянием изменений.
Слияние изменений возникает при объединении веток, а также при обновлении рабочего каталога до последней ревизии основной ветки.
при слиянии файлов не следует терять данные и не нарушить целостность проекта.
Операция слияния происходит автоматически (без вмешательства человека), если изменения не пересекаются, т.е. выполнены в разных файлах или в разных строках одного файла.
Конфликтом называют ситуацию, при которой изменения не могут быть слиты.
Для разрешения конфликта требуется внимание разработчика.
Когда невозможно автоматически сливать изменения (в двоичных файлах, пересекающихся изменениях, удаление и изменение).
Алгоритм слияния изменений.
Слияние выполняется для каждого файла.
Базовая, локальная и серверная ревизии.
Специальный инструмент `diff3`, `kdiff3`, `WinMerge`.
Разметки в объединяемых файлах.


## Контрольные вопросы

1.


## Упражнения

1.

