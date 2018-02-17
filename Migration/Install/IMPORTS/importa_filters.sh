#!/bin/bash
##################################################################
#### IMporta Filtros de e-mail a partir de arquivos individuais###
##################################################################
#Authors: Atila Aloise de Almeida
#e-mail: atilaloise@gmail.com
#
#REQUISITOS: Estar no servidor novo | Ter obtido dump de filtros com o script
#"exporta_filtros.sh" no servidor antigo
#
#
#MODO DE USO: com a pasta /srv/filtros contendo os filtros, já no servidor novo.
#copie esse script para a pasta /srv e o execute
#
#DESCRIÇÃO: faz um loop com o output da Listagem do diretorio onde estao os
#arquivos com os dumps dos filtros.
#Para cada arquivo, armazena seu conteudo em uma variavel, extrai o e-mail a
#partir do nome do arquivo, limpando seu path
# Provisiona filtros na conta do usuario usando o dump que estava no arquivo.



#Para cada arquivo listado no diretorio, faça:
for arquivo in `ls /srv/filtros/`
    do
      #armazena o dump do filtro em uma variavel
    	StringFiltro=`cat "/srv/filtros/$arquivo"`
      #Elimina o path e pega so o nome do arquivo e armazena na variavel
			CONTA=`echo $arquivo | cut -d "/" -f5`
        #Insere filtros na conta
        su - zimbra -c "zmprov ma $CONTA zimbraMailSieveScript '$StringFiltro'"

						echo "PROCESSANDO FILTROS DE  $CONTA"
	done


			echo "TODOS OS FILTROS FORAM IMPORTADOS"
