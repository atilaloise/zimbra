#################################################
#		SHELL SCRIPT PACK FOR USE IN ZIMBRA 	#
#################################################

Here are some scripts I use to manage zimbra.


In the folder "General" are the scripts that I use for backup, zimbra health check, creation of distribution lists, aliases, personalization of attributes of user accounts.

		* backup_zimbra.sh - script that backs up mailboxes with full and incremental options, besides deleting old backups.
		* check_zimbra.sh - Checks if zimbra services are running and restart zimbra if something is out of thin air.
		* create_list_somegroup.sh - Creates a distribution list based on a group of active directory users.
		* create_distribution_list_global.sh - Creates a global list of e-mails based on users of the active directory.

In the folder "migration" are the scripts that I use to migrate a zimbra server to a new "scratch".
	
	- Exports
		* export_signatures.sh - Exports signatures from all accounts.
		* export_filters.sh - Exports all email filters from user accounts.
		* export_distribution_lists.sh - Export distribution lists and their members, generating a script to import into the new server.

	-FIX
		* clean_signatures.sh - Deletes all signatures from all users. Useful for reversing imports with charset problems.

In the folder ¨Install¨ are the scripts that I use in new installations ¨from scratch¨.
		
		* generate_aliases.sh - Creates user aliases based on the active directory's "email" field.
		* ad_auto_provision.sh - Configures the Auto provisioning of users in zimbra from the active directory.
		* personalize_logo.sh - Customize logo on login and webmail.
		* change_send_as.sh - Set the prefix as prefix.
		* tunning_OS.sh - Alters operating system parameters to improve zimbra performance.
		* tunning_zimbra.sh - Alters zimbra configurations for performance improvement.

	- IMPORTS
		* import_signature.sh - Imports signatures (obtained through the script ¨ / Migration / EXPORTS / export_signatures.sh¨).
		* import_filters.sh - Import email filters (obtained through script ¨ / Migration / EXPORTS / export_filters.sh¨).

	- RESTORE
		* restore.sh - restores users' mailboxes from a full backup.


#################################################
#	PACK DE SHELL SCRIPTS PARA USO NO ZIMBRA 	#
#################################################

Aqui estão alguns scripts que uso para administrar o zimbra.

Na pasta ¨General¨ estão os scripts que uso para backup, checagem da saúde do zimbra, criação de listas de distribuiçao, aliases, personalização de atributos das contas de usuario.
		* backup_zimbra.sh - script que faz backup das mailboxes com opçao full e incremental, alem de apagar backups antigos.
		* check_zimbra.sh - Verifica se os serviços do zimbra estao rodando e reinicia o zimbra caso algo esteja fora do ar.
		* create_list_somegroup.sh - Cria uma lista de distribuição baseada em um grupo de usuarios do active directory.
		* create_distribution_list_global.sh - Cria lista global de e-mails baseado nos usuarios do active directory.

Na pasta ¨Migration¨ estão os scripts que utilizo para migrar um servidor zimbra para um novo ¨from scratch¨.
	- Exports
		* export_signatures.sh - Exporta as assinaturas de todas as contas.
		* export_filters.sh - Exporta todos os filtros de  e-mail das contas dos usuários.
		* export_distribution_lists.sh - Exporta as listas de distribuiçao e seus membros, gerando um script para importação no servidor novo.

	-FIX
		* clean_signatures.sh - Apaga todas assinaturas de todos os usuários. Util para reverter importaçoes com problemas de charset.

Na pasta ¨Install¨ estão os scripts que utilizo em novas instalações ¨from scratch¨.
		* generate_aliases.sh - Cria alias de usuário baseado no campo ¨email¨ do active directory.
		* ad_auto_provision.sh - Configura o Auto provisionamento de usuarios no zimbra a partir do active directory.
		* personalize_logo.sh - Personaliza logotipo no login e no webmail.
		* change_send_as.sh - Configura o alias como pref e-mail.
		* tunning_OS.sh - Altera parametros do sistema operacional para melhoria de desempenho do zimbra.
		* tunning_zimbra.sh - Altera configuraçõs do zimbra para melhoria de desempenho.

	- IMPORTS
		* import_signature.sh - Importa assinaturas (obtidas através do script ¨/Migration/EXPORTS/export_signatures.sh¨).
		* import_filters.sh - Importa filtros de e-mail (obtidos através do script ¨/Migration/EXPORTS/export_filters.sh¨).

	- RESTORE
		* restore.sh - restaura mailboxes dos usuarios a partir de um backup full.


