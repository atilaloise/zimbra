#!/bin/bash
#Authors: Atila Aloise de Almeida
#		  Claudio Castelo
#e-mail: atilaloise@gmail.com
#		 claudio@castelonet.com.br
#
#Descrição: Esse script determina uma lista a ser deletada (caso ja exista) e cria novamente. A lista nao aparece no auto completar do zimbra.
# 	Armazena filtro de strings (prefixo) e exclui da lista de membros os endereços que correspondam ao prefixo. em seguida adiciona os membros na lista.
#
#
#Modo de uso (inserir no crontab para automatizaçao): 
#		Executar script como root 		
#
#TO DO LIST:
# - Melhorar utilizaçoa de variaveis para chavear a exibiçao da lista na GAL



list="mynewlist@mydomain.subdomain" #put here the address of the distribution list you want to create  ||| Ponha aqui o endereço da sua nova lista de distribuiçao

#delete the list || deletando a lista
/opt/zimbra/bin/zmprov ddl $list

echo "Lista apagada"

#Creating list again  ||| criando a lista novamente
/opt/zimbra/bin/zmprov cdl $list
echo "Lista recriada"

#Hiding list from auto complete  |||  escondendo a lista do auto completar 
/opt/zimbra/bin/zmprov mdl $list zimbraHideInGal TRUE
/opt/zimbra/bin/zmprov mdl $list zimbraMailStatus disabled
echo "Hide in GAL setado pois nao queremos que qualquer um veja a lista"


BLOCKED_GROUP1='(^yourstring)' #determine a group who doesn´t come to the list using prefixes ||| determinando quem nao entra na lista usando um prefixo
BLOCKED_GROUP2='(^string1|^string2)' #determine a second group who doesn´t come to the list using prefixes ||| determinando quem nao entra na lista usando um prefixo

#Get the mail list to include in the list ||| pegando lista de emails para incluir na lista
for WORD in `/opt/zimbra/bin/zmprov -l gaa tce.ro.gov.br |  grep -Ev $BLOCKED_GROUP2 | grep -Ev $BLOCKED_GROUP1`; do

#generating list inside a variable  || gerando a lista dentro da variavel
A=$A" "$WORD

done
echo "lista de emails criada"

# adding members to the list ||| Adicionando membros a lista
/opt/zimbra/bin/zmprov adlm $list $A
echo "Membros adicionados"