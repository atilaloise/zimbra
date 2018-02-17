##########################
#### Tuning do  zimbra####
##########################
#Authors: Atila Aloise de Almeida
#e-mail: atilaloise@gmail.com
#
#
#Personaliza parametros no zimbra para que o serviço suporte altos volumes de
#requisição.
#
#Modo de uso: Rodar logo após a instalação do zimbra com o usuario ZIMBRA
# Os valores devem ser alterados de acordo com a demanda do sistema

echo "Tunando o zimbra"

#Suportar 500 requisições http
zmprov ms $(zmhostname) zimbraHttpNumThreads 500
#suportar 300 requisições pop3
zmprov ms $(zmhostname) zimbraPop3NumThreads 300
#suportar 500 requisições IMAP
zmprov ms $(zmhostname) zimbraImapNumThreads 500
#suportar 40 requisições de entrega local
zmprov ms $(zmhostname) zimbraLmtpNumThreads 40
#Reserva 4 gb de memoria ram para o java
zmlocalconfig -e mailboxd_java_heap_size=4096
