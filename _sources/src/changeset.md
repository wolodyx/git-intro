# Набор изменений

<!-- Введение в раздел -->
В предыдущих уроках мы использовали термин "изменения" в контексте работы над файлами проекта.
Изменения фиксировали, передавали, забирали.
Отсюда вытекает, что изменение -- это не только результат редактирования файлов и файловой системы, но и некая переносимая сущность.
В этом разделе мы разберем эту сущность и узнаем, как ее представляют в памяти компьютера.

<!-- Изменение файловой системы -->
Изменения в проекте сводятся к изменениям файлов и подкаталогов проекта.
Они претерпевают следующие модификации:
1) редактирование содержимого файла;
2) добавление нового файла (каталога);
3) удаление существующего файла (каталога);
4) перемещение и переименование файла (каталога).
5) редактирование атрибутов файла;

<!-- Структура файла -->
Далее покажем, что вышеперечисленные модификации сводятся к нескольким простым операциям.
Для этого посмотрим на структуру файла с точки зрения файловой системы.
Файл состоит из двух частей: содержимого и метаданных.
Имя и атрибуты файла относятся к метаданным.

```{figure} ./images/file-structure.png
```


## Операции над файловой системой

<!-- Базовые операции над ФС -->
В хранилище Git каталога как отдельного объекта не существует.
Он является производной от имени файла.
Имя файла указывается относительно рабочего каталога, где символы "/" разделяют имена файловых объектов.
Каталог появится в рабочей копии, если он указан в имени извлекаемого файла.
Модификации каталогов (добавление, удаление, перемещение и переименование) сводятся к манипулированию с именами находящихся в них файлов.
Файл с именем `/src/changeset.md` показывает, что файл `changeset.md` расположен внутри каталога `src/` в корневом каталоге проекта `/`.
Отсюда следует, что:
* добавление каталога есть добавление файла, в имени которого присутствует имя каталога;
* удаление каталога есть удаление всех файлов этого каталога;
* перемещение каталога сводится к переименованию каталога (смотри ниже);
* переименование каталога есть переименование всех файлов этого каталога.

```{note}
В хранилище Git не бывает пустых каталогов.
Любой каталог должен содержать хотя бы один файл.
```

Перемещение и переименование файла сводятся к изменению имени файла, которое в свою очередь сводится к удалению и добавлению файла с тем же содержимым, но с другим именем.
В результате получается, что операции #2, #3, #4 из списка выше сводятся **к удалению и добавлению новых файлов** или **редактированию имен существующих файлов**.

Модификация #5 "Редактирование атрибутов файла" сводится, как вытекает из названия, к редактированию поля с атрибутами файла.


## Редактирование файлов

<!-- Короткие строки -->
Файлы проекта программы автоматически обрабатываются утилитами командной строки для получения исполняемых файлов.
Поэтому содержимое файла обладают определенной синтаксической структурой, на которую указывает расширение файла.
Нарушение структуры приводит к ошибкам автоматической обработки, что не желательно.
Разработчики визуализируют структуру, разбивая текст на строки и выравнивая элементы пробельными символами.
Это делает содержимое более наглядной и удобочитаемой, оставаясь при этом автоматически обрабатываемой.
Последствия такого форматирования -- это короткие строки.
Для удобства сопровождения, строки должны быть как можно короче, чтобы поместиться на экран.
Иногда их ограничивают длиной до 80, 100 или 120 символов, чтобы они могли размещаться на экранах текстовых терминалов.

<!-- Строка как минимальный элемент для отслеживания изменений -->
Формально, строка -- это последовательность печатных и пробельных символов, завершаемых управляющим символом конца строки.
Изменения в тексте рассматривают на уровне строк и выделяют добавление и удаление строки.
Редактирование строки сводится как последовательному удалению старой строки и добавлению новой.

<!-- Размещение предложений в отдельных строках -->
Отслеживание изменений через строки крайне не удобен, если они слишком длинные.
Это актуально для плоского текста (plain text), структура которого предполагает существование предложений и абзацев.
В одну строку помещают заголовки и абзацы, а уже при просмотре размер строк автоматически подгоняется под ширину экрана.
Исправление даже одного символа покажет замену всего абзаца.
Обойти это возможно, если использовать идею [семантического переноса строк](https://rhodesmill.org/brandon/2012/one-sentence-per-line/), в которой предложения разбивают на несколько строк, где каждая из строк несет целостную мысль.

<!-- Изменение двоичных файлов -->
Строки характерны только для текстовых файлов, но не для двоичных.
Структура двоичного файла не предполагает существования "двоичных строк" и общепризнанных символов-разделителей.
Поэтому изменение в двоичном файле (изображении, аудио- или видеофайлах) сводится к замещению всего содержимого новым.


## Патч

<!-- Что такое патч -->
Различия между двумя версиями текстовых файлов представлены перечислением добавленных и удаленных строк.
Представление различий в файлах в формате, удобном для автоматической обработки компьютером, называется *патчем*.
Патч можно применить (внести изменения в старую версию файла), откатить (вернуть старую версию файла) и просмотреть (какие строки были изменены).

<!-- Этимология слова -->
Слово "патч" -- калька от английского "patch", что в переводится на русский как "заплатка".
Слово применительно к программам появилось в эпоху первых компьютеров, когда машинный код программы записывался на перфорированной бумаге -- перфокартах и перфолентах.
Вместо того, чтобы заново пробивать исправленную программу, заменялась карта из стопки или вклеивался новый кусок взамен неверного в ленту.
Этот новый кусок бумаги и назывался патчем, т.е. заплаткой.

<!-- Преимущества патча -->
Альтернативой патчу будет хранение новой версии программы.
По сравнению с этим способом, патч имеет следующие преимущества:
* требует намного меньше памяти для представления;
* указывает на различия в файлах;
* позволяет разделить большое обновление на небольшие независимые части, применимые выборочно;
* позволяет откатить внесенные им изменения;
* применим до некоторой степени к файлам и после внесения в них других изменений.


## Структура патча

<!-- Универсальный формат патча -->
Структура патча в универсальном формате состоит из заголовка и последовательно идущих за ним измененных фрагментов.
В заголовке размещается информация о сравниваемых файлах: оригинального и модифицированного.
Путь к оригинальному файлу предваряется символами `---`, а модифицированному -- `+++`.
В той же строке за именами могут следовать дополнительные свойства файлов -- временная метка, атрибуты файла.

<!--
Измененные фрагменты содержат удаленные, добавленные и незатронутые соседние строки, также называемые контекстными.
-->
Измененный фрагмент начинается со строки об информации о диапазоне и последующей за ним строками: удаленными, добавленными и незатронутыми.
Информация о диапазоне фрагмента имеет формат `@@ -l,s +l,s @@`.
Под `-l` обозначен номер первой строки фрагмента в оригинальном файле, а под `+l` -- номер в модифицированном.
Числа `-s` и `+s` показывают количество строк во фрагментах оригинального и модифицированного файлов.
Во фрагменте удаленная строка отмечается символом `-`, добавленная -- `+`, а незатронутая -- пробелом.
Если отображение позволяет работать с цветом, то символы или фон удаленных и добавленных строк окрашиваются красным и зеленым соответственно.
Кроме удаленных и добавленных, во фрагментах присутствуют незатронутые строки.
Они заполняют промежутки между первыми двумя типами строк и показывают контекст, в котором были произведены изменения.
Поэтому их еще называют *контекстными строками* или просто *контекстом*.
Сверху и снизу фрагмент дополняется еще тремя контекстными строками.
Если между измененными строками идут подряд три и более незатронутые строки, то измененные строки попадут в разные фрагменты.
По фрагменту из патча можно восстановить фрагмент как оригинального, так и модифицированного файла.
Фрагмент оригинального файла составляют удаленные и незатронутые строки, а измененного файла -- добавленные и незатронутые.
Контекстные строки улучшают читаемость патча, а также позволяют применять патч к модифицированному оригинальному файлу, если фрагмент был сдвинут, а контекст при этом сохранился.

Ниже представлен пример патча, полученного командой `git diff`.

``` diff
diff --git a/Commands.cpp b/Commands.cpp
index d1b70b0..69313a5 100644
--- a/Commands.cpp
+++ b/Commands.cpp
@@ -11,19 +11,33 @@ CmdType Command::GetType() const
 }
 
 
-Command Cmd_Hello()
+Command Command::Hello()
 {
   return Command(CmdType_Hello);
 }
 
-Command Cmd_On()
+Command Command::On()
 {
   return Command(CmdType_On);
 }
 
 
-bool SendCommand(int sd, const Command& cmd)
+Command Command::Off()
+{
+  return Command(CmdType_Off);
+}
+
+
+Command Command::Color(ColorType clr)
+{
+  std::vector<char> value(1);
+  value[0] = static_cast<char>(clr);
+  return Command(CmdType_Color, value);
+}
+
+
+bool Command::Send(int sd, const Command& cmd)
 {
   std::vector<char> buf(3+cmd.value.size());
   buf[0] = static_cast<char>(cmd.type);
@@ -35,7 +49,13 @@ bool SendCommand(int sd, const Command& cmd)
 }
 
 
-Command RecieveCommand(int sd)
+bool Command::operator!() const
+{
+  return type == CmdType_Empty;
```

В одном выводе или файле могут следовать последовательно несколько патчей, представляя таким образом изменения в более чем в одном файле.
