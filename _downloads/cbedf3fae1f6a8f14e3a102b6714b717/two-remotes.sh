rm -rf remote-1.git remote-2.git local-1 local-2

# Создаем удаленное хранилище `remote-1.git`
git init --bare --initial-branch=main remote-1.git

# Клонируем хранилище `remote-1.git` в локальное `local-1`.
# Добавляем файл main.c с функцией `main()`.
# Отправляем изменение в удаленное хранилище.
git clone ./remote-1.git local-1
cd local-1
cat > main.c << EOL
main()
{
    return 0;
}
EOL
git add main.c
git commit -m "Main function implementation"
git push
cd ..

# Делаем копию (форк) удаленного хранилища `remote-1.git`: `remote-2.git`.
git clone --bare ./remote-1.git remote-2.git

# Клонируем `remote-2.git` в локальное `local-2`.
# Заменяем строку `main()` на `int main()`
# Отправляем изменение в удаленное хранилище `remote-2.git`.
git clone ./remote-2.git local-2
cd local-2
sed -i '1s/main()/int main()/' main.c
git commit -a -m "Add return type of main function"
git push
cd ..

# В хранилище `local-1` в файле `main.c` строку
# `main()` заменяем на `main(int argc, char** argv)`.
# Отправляем изменение в удаленное хранилище `remote-1.git`.
cd local-1
sed -i '1s/main()/main(int argc, char** argv)/' main.c
git commit -a -m "Add arguments of main function"
git push

# Забираем изменения из удаленного хранилища `remote-2.git` в локальное `local-1`.
# Сливаем удаленную ветку `remote-2/main` с локальной веткой `main`, разрешив конфликт слияния.
# Отправляем изменения в удаленное хранилище `remote-1.git`.
git remote add remote-2 ../remote-2.git
git remote -v
git log --oneline --all --graph
git fetch remote-2
git log --oneline --all --graph
git merge remote-2/main # ???
cat > main.c << EOL
int main(int argc, char** argv)
{
    return 0;
}
EOL
git add main.c
git commit -m "Merge remote-tracking branch 'remote-2/main'"
git push origin

