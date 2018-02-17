#!/bin/bash
###########################################################
#### Exporta Filtros de e-mail para arquivos individuais###
###########################################################
#AUTOR: Atila Aloise de almeida
#E-MAIL: atila.aloise@tce.ro.gov.br
#VERSÃO; 1.0
#
#REQUISITOS: Estar no servidor que será migrado
#
#MODO DE USO: criar pasta de trabalho do script (mkdir /srv/filtros).
#copie esse script para a pasta /srv e o execute
#
##DESCRIÇÃO: Obtem a lista de contas do zimbra, e para cada conta, faz dump dos filtros.
#Armazena esse dump em um arquivo temporario, elimina a primeira linha do arquivos
# e em seguida exclui a primeira parte da segunda linha, e ja coloca o novo dump
#no arquivo definitivo (cujo nome é o endereço de e-mail) dentro da pasta de
#trabalho
#Ao termino da execução do script, envie a pasta "/srv/filtros" para o novo servidor e
#execute o script de importação

clear
			echo "OBTENDO contaS DE USUARIO..."

#Obtem lista de usuarios do zimbra
USERS=`su - zimbra -c 'zmprov -l gaa | sort'`;

#Para cada usuario, faça:
		for conta in $USERS; do

              #Obtem o dump dos filtros e joga em um arquivo temporario
							filter=`su - zimbra -c "zmprov ga $conta zimbraMailSieveScript" > /tmp/$conta`

              #remove a primeira linha do dump, pois ela nao tem utilidade na importação
              sed -i -e "1d" /tmp/$conta

              #Remove o texto inicial do dump, pois ele nao tem utilidade na importação. Em seguida joga o dump "FILTRADO" no arquivo definitivo da pasta de trabalho
							sed 's/zimbraMailSieveScript: //g' /tmp/$conta > filtros/$conta

              #remove arquivo temporario
							rm /tmp/$conta

										echo "EXPORTANDO FILTROS DE $conta..."
		done
										echo "TODOS OS FILTROS FORAM EXPORTADOS"
