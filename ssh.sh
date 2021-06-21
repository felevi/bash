#!/bin/bash

acesso_comsenha() {
	sshpass -p "$senha" ssh $usuario@localhost
}

acesso_semsenha() {
	sshpass -p "felipe@2020" ssh $usuario@localhost
}

while getopts "hu:p:" OPT; do
	case "$OPT" in
		u) usuario=$OPTARG
		usuarios=true
		;;
		p) senha=$OPTARG
		senhas=true
		;;
		h) echo "Utilize -u informando o usuário caso queira logar sem senha, e -u usuario mais o -p para informar a senha."
	esac
done

if [[ $usuarios && $senhas ]]; then
	acesso_comsenha
elif [[ $usuarios ]]; then
	acesso_semsenha
fi
