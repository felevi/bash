#!/bin/bash

sshpass -p "felipe@2020" ssh felipe@localhost ps aux > log.txt;

while getopts "ch" OPT; do
	case "$OPT" in
	c) crontab -l | { cat; echo "15 * * * * log_ssh.sh"; } | crontab -;;
	h) echo "Caso seja a primeira execução, usar -c para adicionar regra no crontab."
	esac
done
