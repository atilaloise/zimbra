
###################################################
#### Integração e auto provisionamento de contas###
###################################################
#Authors: Atila Aloise de Almeida
#e-mail: atilaloise@gmail.com
#
#
#Configura a integração do zimbra no active directory para o domínio do TCE.ro.gov.br
#bem como o auto provisionamento de todas as contas de e-mail para os usuarios existentes.
#Mapeia atributos do usuario no ad com o LDAP do zimbra, como o nome de exibição,
#filtra a busca para apenas usuarios que tenham e-mail cadastrado no ad
#
#REQUISITOS: tuning_OS.sh | tuning_zimbra.sh
#MODO DE USO: Rodar script após os requisitos, utilizando o usuario zimbra
#				Voce so precisa rodar esse script uma vez


echo "Integrando ZIMBRA COM O DOMINIO"
#Modo EAGER consulta o ad em um espaço de tempo determinado e provisiona contas que existem no ad e nao existem no Zimbra
zmprov md yourdomain.subdomain zimbraAutoProvMode EAGER
#Define quantas contas serão provisionadas a cada consulta ao ad
zmprov md yourdomain.subdomain zimbraAutoProvBatchSize 60
#Define o intervalo em que as consultas ao ad ocorrerão
zmprov ms $(zmhostname) zimbraAutoProvPollingInterval 15s
#Define qual dominio terá consultas agendadas para auto provisionamento
zmprov ms $(zmhostname) +zimbraAutoProvScheduledDomains yourdomain.subdomain
#define o endereço do servidor AD
zmprov md yourdomain.subdomain zimbraAutoProvLdapURL "ldap://192.168.0.x:3268"
#Define o usuário que autentica no ad para obter as contas
zmprov md yourdomain.subdomain zimbraAutoProvLdapAdminBindDn "CN=Administrator,CN=Users,DC=yourdomain,DC=local"
#Define a senha do usuario que autentica no ad para obter as contas
zmprov md yourdomain.subdomain zimbraAutoProvLdapAdminBindPassword 'P@ssW0rd'
#Define base de busca no domínio do ad, neste caso, percorre a base toda
zmprov md yourdomain.subdomain zimbraAutoProvLdapSearchBase "DC=yourdomain,DC=local"
#define mapeamento dos atributos do ad com o ldap do zimbra
zmprov md yourdomain.subdomain zimbraAutoProvAccountNameMap sAMAccountName
zmprov md yourdomain.subdomain +zimbraAutoProvAttrMap givenName=givenName
zmprov md yourdomain.subdomain +zimbraAutoProvAttrMap sn=sn
zmprov md yourdomain.subdomain +zimbraAutoProvAttrMap displayName=displayName
#Define que a busca deve pegar apenas usuarios com o campo "e-mail" do ad preenchido
zmprov md yourdomain.subdomain zimbraAutoProvLdapSearchFilter "(&(objectCategory=user)(mail=*))"