#!/bin/bash

# Caminho para o script monitor_fedora.sh
SCRIPT_PATH="/path/to/your/monitor_fedora.sh"

# Adicione uma entrada cron para executar o script todos os dias às 12:00
(crontab -l 2>/dev/null; echo "0 12 * * * $SCRIPT_PATH") | crontab -
