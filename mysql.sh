#!/bin/bash

verificar_arquivo() {
 	if [[ -f $arquivo ]]; then
                echo "Arquivo validado"
                if [[ $criar ]]; then
                        criar_usuarios
                elif [[ $alterar ]]; then
                        alterar_permissoes
                fi
        elif [[ $arquivo != "" ]]; then
        echo "Arquivo não existe"
        exit 1
        fi
}

criar_usuarios() {
cat $arquivo | while read nome email senha depto; do

        modelo="
	Nome:$nome
        Email:$email
        Senha:$senha
        Depto:$depto"

        echo "Usuário carregado:"
        echo "${modelo}"

	MYSQL_PWD=Teste@123 mysql -u root -e "CREATE USER '$nome'@'localhost' IDENTIFIED BY '$senha'";
	echo "Usuário criado no MYSQL"
	echo
	done
}

alterar_permissoes() {
cat $arquivo | while read nome email senha depto; do

        modelo="
	Nome:$nome
        Email:$email
        Senha:$senha
        Depto:$depto"

        echo "Usuário carregado:"
        echo "${modelo}"
	MYSQL_PWD=Teste@123 mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '$nome'@'localhost' WITH GRANT OPTION";
	echo "Permissões dadas ao usuário"
	echo	
	done
}

while getopts "hcaf:" OPT; do
	case "$OPT" in
		c) criar=true;;
		a) alterar=true;;
		f) arquivo=$OPTARG;;
		h) echo "Utiliza -f para validar e carregar o arquivo de usuários, -c para criar usuarios  e -a para alterar permissões."
	esac
done

verificar_arquivo
