#!/bin/bash
#################################################################
#### Criando Alias para contas, usando e-mail cadastrado no ad###
#################################################################
#Authors: Atila Aloise de Almeida
#		  Claudio Castelo
#e-mail: atilaloise@gmail.com
#		 claudio@castelonet.com.br
#
#
#DESCRIÇAO: Esse script consulta o AD e armazena o conteúdo do campo "e-mail" em uma lista (new_mail_list.lst)
# Em seguida ele compara os valores da lista nova com a lista antiga (old_mail_list.lst) e armazena em uma variavel (NEWMAILS)
# Para cada e-mail novo, o script cria um alias para cada conta do ad de acordo com a conta existente.
#
#
#
#REQUISITOS: Zimbra instalado e rodando com resolução de nomes correta, usuarios já provisionados
#MODO DE USO: criar pasta de trabalho do script (mkdir /srv/cria_alias).
# dentro da pasta de trabalho do script, crie o arquivo old_mail_list.lst (touch /srv/cria_alias/old_mail_list.lst)
#copie esse script para a pasta de trabalho e o execute
#
# Após criar os alias, ele altera o "from" padrão de todos os usuarios para o e-mail com nome amigavel criado no campo e-mail do AD.
#
#MANTER ESSE SCRIPT NO CRONTAB PARA QUE SEJA TUDO FEITO AUTOMATICAMENTE

#Declarando as variaveis iniciais juntamente com seus valores
SERVER="192.0.0.x"    #ip address from Active directory ||| Ip do AD
DOMAIN="dc=yourdomain,dc=subdomain"   #define domain to be consulted  ||| define dominio a ser consultado
DOMAINFQDN="yourdomain.subdomain"
LOGIN="yourdomain\\queryuser"		#define user with query permissions  ||| Define usuario com permissao de consulta
PASSWORD="P@ssW0rd"					#define password for user   |||   Define senha do usuario


#Creating list with users from active directory  |||  cria lista com e-mails cadastrados no ad
#if your zimbra dont have auto provision, use this and comment the next line ||| se seu zimbra nao tem auto provisionamento, use a linha abaixo e comente a posterior
#ldapsearch -z max -LLL -x -b $DOMAIN -D $LOGIN -h $SERVER -p 389 -w $PASSWORD mail | grep -v ^# | grep mail: | cut -d: -f2 | sed 's/^ //' > new_mail_list.lst
########################
#TEST THIS COMMAND!!####
########################
/opt/zimbra/bin/zmprov -l gaa tce.ro.gov.br  > new_mail_list.lst


#armazena os e-mails novos do ad em uma variavel, baseado em uma lista criada na ultima vez q o script foi rodado
NEWMAILS=`diff old_mail_list.lst new_mail_list.lst | grep \> | sed 's/> //g'`

#Realiza um loop para cada e-mail armazenado na variavel "NEWMAILS"
    for mails in $NEWMAILS
              do
#Cria um alias usando o ZMPROV, preenchendo os valores utilizando a busca no ad com o e-mail, obtendo a user do colaborador e substituindo o DOMAIN local pelo DOMAIN externo, em seguida preenche o atributo com o nome do alias de email.
/opt/zimbra/bin/zmprov aaa "`ldapsearch -LLL -x -h $SERVER -p 3268 -b "$DOMAIN" -D "$LOGIN" -w $PASSWORD mail\=$mails samaccountname | grep sAMAccountName | awk '{print $2}' | sed  's/$/@tce.ro.gov.br/'`" $mails

      #fim do loop
          done

#copia o conteudo da lista nova para o arquivo de lista antiga, que será utilizado para comparação na próxima vez que o script rodar
cp new_mail_list.lst old_mail_list.lst



echo "Gerando lista de usuarios"
LISTA=`/opt/zimbra/bin/zmprov -l gaa -v tce.ro.gov.br | grep uid: | grep '[0-9]'|grep -Ev '(spam|gal|virus|granteeId)' |cut -d : -f2`

# Inicia loop para cada conta do zimbra
for user in $LISTA
     do
#Cadastra e-mail amigavel como "from alternativo" para a conta em voga no loop
/opt/zimbra/bin/zmprov ma $user zimbraPrefFromAddress "`ldapsearch -LLL -x -h $SERVER -p 3268 -b "$DOMAIN" -D "$LOGIN" -w $PASSWORD samaccountname\=$user mail | grep $DOMAINFQDN | awk '{print $2}'`"
#Determina o from com email amigavel por padrao
/opt/zimbra/bin/zmprov ma $user zimbraPrefFromAddressType "sendAs"
#fim do loop
        done