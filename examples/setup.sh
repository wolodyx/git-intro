#!/bin/bash

sudo apt-get -y install git-all gitk
sudo apt -y install vim tmux rcs git-gui curl tree
sudo apt -y install kdiff3

# Install lazygit.
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

mkdir projects

# Хранилища больших проектов для учебных целей.
git clone https://gitlab.kitware.com/cmake/cmake.git projects/cmake
git clone https://gitlab.com/libeigen/eigen.git projects/eigen

# Формируем тестовые хранилища с конфликтами слияния.
mkdir conflicts
cd conflicts
curl -L --output extract-conflicts.sh https://raw.githubusercontent.com/wolodyx/git-intro/main/examples/extract-conflicts.sh
./extract-conflicts.sh $HOME/projects/cmake
./extract-conflicts.sh $HOME/projects/eigen
rm -f extract-conflicts.sh


# Install sublime-merge
# Install VSCode

