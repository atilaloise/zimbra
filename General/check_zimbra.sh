#!/bin/bash
#Authors: Atila Aloise de Almeida
#		  Claudio Castelo
#e-mail: atilaloise@gmail.com
#		 claudio@castelonet.com.br
#
#Descrição: Este script verifica se algum serviço do zimbra não está rodando. Caso algum serviço estiver com o status
# ¨not runnig¨ ou ¨stopped¨, ele restarta o zimbra.
#
#Modo de uso (adicionar ao crontab para verificaçao automatica):
#			- Rodar script como root
#
#TO DO LIST:
# - Enviar por e-mail que serviços estao parados e se o restart resolveu
# - Reiniciar apenas o serviço que está parado.


/etc/init.d/zimbra status | grep -i "not running"
if [ $? != 1 ]; then
	/etc/init.d/zimbra restart
else
	echo > /dev/null
fi 
/etc/init.d/zimbra status | grep -i stopped
if [ $? != 1 ]; then
	/etc/init.d/zimbra restart
else
	echo > /dev/null
fi 