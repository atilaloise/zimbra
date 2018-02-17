##############################################
#### Personalização dos logotipos do zimbra###
##############################################
#Authors: Atila Aloise de Almeida
#e-mail: atilaloise@gmail.com
#
#
#REQUISITOS: Zimbra instalado e rodando com resolução de nomes correta
#MODO DE USO: Rodar script após os requisitos, utilizando o usuario zimbra
#Enviar imagem do logotipo com o nome loginlogo.png e logowebapp.png no path /opt/zimbra/jetty/webapps/zimbra/img



echo "Personalizando logotipos para o dominio"
# Troca logo da tela de login
zmprov modifyDomain yourdomain.com  zimbraSkinLogoLoginBanner https://mail.yourdomain.com /img/loginlogo.png
# Trocar logo da tela principal
zmprov modifyDomain yourdomain.com zimbraSkinLogoAppBanner https://mail.yourdomain.com/img/logowebapp.png
# Trocar url do logo apontando para o site do TCE
zmprov modifyDomain yourdomain.com zimbraSkinLogoURL https://www.yourdomain.com
