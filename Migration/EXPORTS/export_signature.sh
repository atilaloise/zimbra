#!/bin/bash
#####################################################
#### Exporta assinaturas para arquivos individuais###
#####################################################
#Authors: Atila Aloise de Almeida
#e-mail: atilaloise@gmail.com
#
#
#REQUISITOS: Estar no servidor que será migrado| Locales pt_BR.UTF-8 configurados no
#.bash_profile do usuario zimbra
#
#MODO DE USO: criar pasta de trabalho do script (mkdir /srv/exporta_assinaturas).
#copie esse script para a pasta de trabalho e o execute
#
#Ao termino da execução do script, envie a pasta "/srv/sign" para o novo servidor e
#execute o script de importação


#!/bin/bash
mkdir sign
# Obtemos uma lista de todas as contas do servidor
ZMPROV="/opt/zimbra/bin/zmprov"

#inicio do loop: para cada conta existente no zimbra, faça:
for MAIL in $($ZMPROV -l gaa | sort);   do

  #obtem um dump da assinatura e joga em um arquivo "assinatura-conta@tce.ro.gov.br"
    $ZMPROV gsig $MAIL  > sign/assinatura-$MAIL
done
