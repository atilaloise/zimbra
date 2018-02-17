################################################
#### Tuning de sistema para instalação zimbra###
################################################
#Authors: Atila Aloise de Almeida
#e-mail: atilaloise@gmail.com
#
#Insere valores na configuração do sistema operacional que fazem com que
#o desempenho do protocolo TCP-IP e o uso de swap fiquem otimizado para
#o funcionamento do zimbra
#
#Modo de uso: rodar script logo após instalação e atualização do sistema com usuario ROOT
# antes de instalar o zimbra
#


echo "vm.swappness = 0" >> /etc/sysctl.conf
echo "net.ipv4.tcp_fin_timeout = 15" >> /etc/sysctl.conf
echo "net.ipv4.tcp_tw_reuse = 1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_tw_recycle = 1" >> /etc/sysctl.conf
