FROM python:3

ARG USERNAME=bob
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt-get update

RUN    groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

RUN pip install jupyter-book
RUN apt-get install -y inotify-tools

USER $USERNAME

