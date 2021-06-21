criar_usuarios() {
	cat $arquivo | while read nome email senha depto; do

	modelo="
	Nome:$nome
	Email:$email
	Senha:$senha
	Depto:$depto"

	echo "Usuário carregado"
	echo "${modelo}"

	addgroup $depto
	useradd -m -d /home/$nome -p $senha -s /bin/bash -g $depto $nome

	echo "Usuário criado com sucesso"
	done
}

bloquear_usuarios() {
        cat $arquivo | while read nome email senha depto; do

        modelo="Nome:$nome
        Email:$email
        Senha:$senha
        Depto:$depto"

        echo "Usuário carregado"
        echo "${modelo}"

        usermod -L $nome

        echo "Usuário bloqueado com sucesso"
	done
}

verificar_arquivo() {
	if [[ -f $arquivo ]]; then
        	echo "Arquivo validado"
		if [[ $criar ]]; then
			criar_usuarios
		elif [[ $bloquear ]]; then
			bloquear_usuarios
		fi
	elif [[ $arquivo != "" ]]; then
	echo "Arquivo não existe"
        exit 1
	fi
}

while getopts "hcbf:" OPT; do
	case "$OPT" in
		c) criar=true;;
		b) bloquear=true;;
		f) arquivo=$OPTARG;;
		h) echo "Utilize -f para validar e carregar o arquivo de usuários, -c para criar e -b para bloquear."
	esac	
done

if [[ $criar && $bloquear ]]; then
	echo " -c -b não podem ser utilizados juntos." 
	exit 1
fi

verificar_arquivo
