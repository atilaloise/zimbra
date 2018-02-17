#!/bin/bash
#Authors: Atila Aloise de Almeida
#		  Claudio Castelo
#e-mail: atilaloise@gmail.com
#		 castelo@castelonet.com.br
#
#Descrição: Este script armazena os ¨paths¨ da instalação do zimbra, a data do dia anterior, o diretório de armazenamento dos backups,
# a data de hoje, a data de ontem, a ¨query¨ a ser passada na ¨restURL¨ e o tempo de retençao dos backups.
#
#Função ¨cleanOldBackups¨:
#			Esta funçao busca arquivos antigos de acordo com a quantidade de dias determinados na variavel ¨KEEP¨ e apaga estes arquivos.
#
#Modo de uso (inserir no crontab para automatizaçao dos backups): 
# 		Este script pode ser rodado com ou sem parâmetros.
#		Caso rode sem parametros, o script apenas apaga os backups antigos
#		Caso rode com o parametro ¨--full¨, o script faz o backup full de todas as contas do zimbra
#		Caso rode com o parâmetro ¨--diff¨, o script faz apenas o backup diario de todas as contas do zimbra
#
#
#TO DO LIST:
# - Inserir o backup de assinaturas
# - Backup das listas de distribuição e seus membros
# - Backup das configurações de compartilhamentos

ZHOME=/opt/zimbra       #Zimbra installation Path ||| caminho da instalaçao do zimbra
ZBACKUP=/opt/zimbra/backup 		#Zimbra backup folder Path ||| 	Pasta onde devem ser armazenados os backups
ZCONFD=$ZHOME/conf 				#Zimbra conf Path 		||| Caminho para pasta de confs do zimbra
ZDUMPDIR=$ZBACKUP/mailbox/$DATE # Path to save backups named by date ||| Pasta de backup nomeada por data
ZMBOX=/opt/zimbra/bin/zmmailbox 	#Path to zmmailbox binnary  ||| Caminho do binário zmmailbox
ZMPROV=/opt/zimbra/bin/zmprov 		#Path to zmprov binnary  ||| Caminho do binário zmprov
TODAY=`date --date='today' +"%m/%d/%Y"` 	# Get today date  ||| Pega data de hoje
YESTERDAY=`date --date='1 days ago' +"%m/%d/%Y"` 	#Get yesterday date ||| Pega data de ontem
QUERY="query=after:$YESTERDAY"				#Assemble query to get yesterday backups ||| Monta query para fazer backup so do dia anterior
KEEP=30 				# Days to keep backups  ||| Dias para manter os backups


###########################
### DECLARING FUNCTIONS ###
###########################
# Cleaning old backups
# apagando backups antigos.

function cleanOldBackups (){

	echo Cleaning backups older than $KEEP days.

		for old in `find $ZBACKUP -type d -mtime $KEEP`
do

/bin/rm -rf $old

done
}

########################
### END OF FUNCTIONS ###
########################

case $1 in
 --full)
	# BACKUP FULL
	if [ ! -d $ZDUMPDIR-full ]; then
	mkdir -p $ZDUMPDIR-full
	fi
	echo " Running zmprov ... "
	       for mbox in `$ZMPROV -l gaa | grep -Ev '(sync|admin|virus|spam|ham|galsync)'`
	do
	echo " Generating files from backup $mbox ..."
	       $ZMBOX -z -m $mbox getRestURL "//?fmt=tgz" > $ZDUMPDIR-full/$mbox.tgz
	done

cleanOldBackups
    	;;

 --diff)
	# BACKUP DIFFERENCIAL
	if [ ! -d $ZDUMPDIR-diff ]; then
	mkdir -p $ZDUMPDIR-diff
	fi
	echo " Running zmprov ... "
	       for mbox in `$ZMPROV -l gaa | grep -Ev '(sync|admin|virus|spam|ham|galsync)'`
	do
	echo " Generating files from backup $mbox ..."
		mkdir -p $ZDUMPDIR-diff
	       $ZMBOX -z -m $mbox getRestURL "//?fmt=tgz&$QUERY" > $ZDUMPDIR-diff/$mbox.tgz
	done
cleanOldBackups
    	;;
 
 *)
cleanOldBackups
	exit 1
esac