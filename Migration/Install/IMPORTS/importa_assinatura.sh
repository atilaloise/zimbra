#!/bin/bash
#############################################################
#### IMPORTA assinaturas a partir de  arquivos individuais###
#############################################################
#Authors: Atila Aloise de Almeida
#	
#e-mail: atilaloise@gmail.com
#	
#
#REQUISITOS: Estar no servidor novo| Locales pt_BR.UTF-8 configurados no
#.bash_profile do usuario zimbra
#
#MODO DE USO: após enviar as assinaturas exportadas para o novo servidor,
# (/srv/sign) rode esse script em /srv com o usuario root.
#
#Lista os arquivos de assinatura na pasta /srv/sign e armazena o output em uma
#variavel. faz um loop onde, para cada conta, extrai o email do
#nome do arquivo e armazena em uma variavel.
#Joga o conteudo do arquivo da assinatura exportada em uma variavel
#


#determina o caminho completo do zmprov
ZMPROV="/opt/zimbra/bin/zmprov"

#para cada arquivo na pasta SIGN, faça:
for ACCOUNTS  in $(ls sign) ; do
  #extrai do arquivo o e-mail e armazena na variavel
  MAIL=$(echo $ACCOUNTS | awk -F "assinatura-" '{print $2}')

  #Poe o dump da assinatura em uma variavel, ignorando altumas tags
  SIGNATURE="$(cat sign/$ACCOUNTS  | grep -v ^# | grep -v zimbraSignatureId | grep -v zimbraSignatureName | sed s/zimbraPrefMailSignatureHTML:/""/)"
  #Cria a assinatura nova para a conta de e-mail usando o dump da assinatura exportada
  zmprov csig $MAIL nova zimbraPrefMailSignatureHTML "$SIGNATURE"

done
