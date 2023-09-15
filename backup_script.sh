#!/bin/bash

# Директория, в которую будет сохранен бэкап
archive_dir="/archive"

# Создаем директорию для архивов, если она не существует
mkdir -p "$archive_dir"

# Текущая дата и время в желаемом формате
date_formatted=$(date "+[%a %d %b %Y %H:%M:%S %Z]")

# Путь к лог-файлу
log_file="/home/bbtux/backup_log.txt"

# Функция для логирования
log() {
  echo "$date_formatted $1" >> "$log_file"
}

# Начало выполнения скрипта
log "Начало выполнения скрипта"

# Создаем архив домашней директории без начального '/'
tar -czf "$archive_dir/home_backup_$date.tar.gz" /home/bbtux/.

# Исключаем директорию, вызывающую ошибку в tar
tar -czf "$archive_dir/home_backup_$date.tar.gz" --exclude=/home/bbtux/.cache/tracker3/files /home/bbtux/.

# Копируем файл, если он существует
if [ -f "/etc/xrdp/xrdp.ini" ]; then
    cp /etc/xrdp/xrdp.ini "$archive_dir/xrdp_config_$date.ini"
else
    log "Файл /etc/xrdp/xrdp.ini не существует."
fi

# Создаем архив /var/log
tar -czf "$archive_dir/var_log_backup_$date.tar.gz" /var/log

# Завершение выполнения скрипта
log "Завершение выполнения скрипта"
