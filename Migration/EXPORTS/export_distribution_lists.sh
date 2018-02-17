#!/bin/bash
#############################################################################
#### Exporta lista de distribuição e membros, gerando script de importação###
#############################################################################
#Authors: Atila Aloise de Almeida
#		  Claudio Castelo
#e-mail: atilaloise@gmail.com
#		 claudio@castelonet.com.br
#
#
# #DESCRIÇÃO: Cria o diretorio "listas" dentro da pasta de trabalho do script
# determina pasta de trabalho como /srv/export_dl
#
#Pega todas as listas de distribuição do zimbra, armazena em uma variavel
#temporaria no loop WHILE
#
#Para cada lista obtida, insere o comando de provisionamento com o nome da lista
#em um arquivo temporario com o nome da lista
#
# Obtém os membros da lista de distribuição e armazena em um arquivo temporario
# com o "nome da lista.tmp"
#
#Extrai apenas o endereço do membro da lista e para cada membro gera o comando
#de inserção do membro na lista e o inclui no final do arquivo com o nome da
#lista
#
#Apaga o arquivo temporario q continha a lista de MEMBROS
#
#Quando o loop acaba, joga tudo que foi criado dentro dos arquivos com nomes de
#lista, para um arquivo unico que sera usado para importação das listas no novo
# SERVIDOR
#
# Remove arquivos criados anteriormente, deixando so o script de importação;
#
#
#REQUISITOS: Estar no servidor que será migrado.
#
#MODO DE USO: criar pasta de trabalho do script (mkdir /srv/export_dl).
#copie esse script para a pasta de trabalho e o execute
#
#Ao termino da execução do script, envie o arquivo gerado
#"importa_listas_e_membros.sh" para o novo servidor e execute nele para importar
#as listas e membros
#


mkdir /srv/export_dl/listas
workdir=/srv/export_dl/lista

/opt/zimbra/bin/zmprov gadl | while read lista; #para cada lista de distribuição
do
   echo "/opt/zimbra/bin/zmprov cdl $lista" > $workdir/$lista #######insere o comando de criação da lista, com o nome da lista em um arquivo que será usado como script para provisionar o novo servidor
   /opt/zimbra/bin/zmprov gdl $lista | grep zimbraMailForwardingAddress >  $workdir/$membroslista.tmp #######pega os membros da lista de distribuição e poe em um arquivo temporario
   cat $workdir/$membroslista.tmp | sed 's/zimbraMailForwardingAddress: //g' |  ######le o arquivo temporário e extrai o email do membro da lista
   
   while read member; do
     echo "/opt/zimbra/bin/zmprov adlm $listname $member" >> $workdir/$lista #####gera o comando de inserção de membro no arquivo que será usado como script para provisionar o novo servidor
   done
   
   /bin/rm $workdir/$listname.tmp
done


##################
##TEST THIS LOOP ##
####################
for i in ´ls $workdir´ do
cat i >> importa_listas_e_membros.sh #####AGRUPA TUDO QUE FOI GERADO ACIMA
rm i #apaga os arquivos com nome das listas
done