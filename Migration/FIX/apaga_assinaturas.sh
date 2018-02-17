#!/bin/bash
########################################################################
#### Apaga assinaturas importadas pelo script "importa_assinatura.sh"###
########################################################################
#Authors: Atila Aloise de Almeida
#		  
#e-mail: atilaloise@gmail.com
#
#
#REQUISITOS: Estar no servidor novo| Locales pt_BR.UTF-8 configurados no
#.bash_profile do usuario zimbra
#
#MODO DE USO: Caso haja algum problema com as assinaturas importadas (charset ou
# outro), rode o script para apaga-las

#Le os arquivos de assinaturas importadas e as exclui



for CONTAS  in $(ls sign) ; do MAIL=$(echo $CONTAS | awk -F "assinatura-" '{print $2}'); zmprov dsig $MAIL nova; done
