# Чистим рабочий каталог сценария.
rm -rf remote.git local-1 local-2

# Создаем удаленное хранилище
git init --bare --initial-branch=main remote.git

# Клонируем первое локальное хранилище,
# добавляем пустой файл main.c
# и отправляем его в удаленное хранилище.
git clone ./remote.git local-1
cd local-1
touch main.c
git add main.c
git commit -m "Add empty main.c file"
git push
cd ..

# Клонируем второе локальное хранилище,
# реализуем функцию main
# и отправляем изменения в удаленное хранилище.
git clone ./remote.git local-2
cd local-2
cat > main.c << EOL
main()
{
    return 0;
}
EOL
git commit -a -m "Main function implementation"
git push
cd ..

# Интегрируем в первое локальное хранилище изменения из удаленного хранилища.
# Добавляем в функцию main тип возвращаемого значения.
# Отправляем изменения в удаленное хранилище.
cd local-1
git pull
sed -i '1s/main()/int main()/' main.c
git commit -a -m "Add return type of main function"
git push
cd ..

# Во втором локальном хранилище в функцию main добавляем аргументы.
# Фиксируем изменения и пытаемся отправить коммит в удаленное хранилище.
# Потерпев неудачу в отправке, забираем изменения из удаленного хранилища, сливаемся с ними, разрешив конфликт.
# После этого успешно отправляем изменения в удаленное хранилище.
cd local-2
sed -i '1s/main()/main(int argc, char** argv)/' main.c
git commit -a -m "Add arguments of main function"
git push # ???
git fetch
git merge origin/main # ???
cat > main.c << EOL
int main(int argc, char** argv)
{
    return 0;
}
EOL
git add main.c
git commit -m "Merge remote-tracking branch 'origin/main'"
git push

