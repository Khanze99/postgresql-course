## Что такое `psql`?

`psql` — это интерактивный терминальный клиент для работы с базами данных PostgreSQL. Он позволяет выполнять SQL-запросы, управлять базами данных и т.д.

---

## 1. Установка на macOS

### Способ 1: Через Homebrew (рекомендуется)

1. Установите Homebrew (если ещё не установлен):
    `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
2. Установите PostgreSQL:
    `brew install postgresql`
3. Проверьте установку:
    `psql --version`

### Способ 2: Через официальный установщик

1. Скачайте установщик с [официального сайта PostgreSQL](https://www.postgresql.org/download/macosx/).
2. Запустите скачанный файл и следуйте инструкциям.
3. После установки `psql` будет доступен в терминале.

---

## 2. Установка на Windows

### Способ 1: Через установщик (рекомендуется)

1. Скачайте установщик с [официального сайта](https://www.postgresql.org/download/windows/).
2. Запустите установщик:
    - Выберите компоненты: **PostgreSQL Server** и **Command Line Tools**(обязательно для `psql`).
    - Задайте пароль для суперпользователя `postgres`.
    - Завершите установку.
3. Добавьте путь в переменную `PATH` (если не добавилось автоматически):
    - Путь к `psql` обычно: `C:\Program Files\PostgreSQL\<версия>\bin`
    - Как добавить в `PATH`:
        - Правый клик по "Этот компьютер" → "Свойства" → "Дополнительные параметры системы" → "Переменные среды" → в "Переменные системы" найдите `PATH` и отредактируйте, добавив путь.
4. Проверьте установку в командной строке (cmd):

### Способ 2: Через WSL (Windows Subsystem for Linux)

Если у вас включён WSL (например, Ubuntu):

1. Откройте терминал WSL.
2. Обновите пакеты:
    `sudo apt update`
3. Установите PostgreSQL
    `sudo apt install postgresql-client`
4. Проверьте:
    `psql --version`

---

## 3. Установка на Linux (Ubuntu/Debian)

1. Обновите пакеты:
    `sudo apt update`
2. Установите клиент PostgreSQL:
    `sudo apt install postgresql-client`
3. Проверьте:
    `psql --version`

---

## Как подключиться к базе данных через `psql`?

После установки используйте команду:

psql -h <хост> -p <порт> -U <пользователь> -d <база_данных>

psql -h localhost -p 5432 -U postgres -d mydb