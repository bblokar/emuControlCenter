<?
/**
 * emuControlCenter language system file
 * ------------------------------------------
 * language:	fr (fran�ais)
 * author:	Scheibel Andreas - Traduit par Belin Cyrille
 * date:	2006/09/09
 * ------------------------------------------
 */
$i18n['popup'] = array(
	'rom_add_filechooser_title%s' =>
		"%s : localisation du chemin des ROMS",
	'rom_add_parse_title%s' =>
		"Ajouter des ROMS de %s",
	'rom_add_parse_msg%s%s' =>
		"Ajouter des ROMS de\n\n%s\n\ndu dossier et des sous-dossier(s)\n\n%s ?",
	'rom_add_parse_done_title' =>
		"Scan effectu�",
	'rom_add_parse_done_msg%s' =>
		"Scan de nouvelles ROMS de\n\n%s\n\neffectu� !",
	'rom_remove_title%s' =>
		"Effacer la liste de ROMS de %s",
	'rom_remove_msg%s' =>
		"Voulez-vous effacer la liste de ROMS de \n\"%s\" ?\n\nCette action supprimera toutes les ROMS s�lectionn�e de ecc. Ceci ne supprimera PAS les donn�es ou la/les ROMS du disque dur.",
	'rom_remove_done_title' =>
		"Effacement de la liste de ROMS effectu�",
	'rom_remove_done_msg%s' =>
		"Toutes les ROMS de %s sont supprim�es de la liste",
	'rom_remove_single_title' =>
		"Supprimer la ROM de la liste",
	'rom_remove_single_msg%s' =>
		"Voulez-vous supprimer de la liste\n\n%s ?\n\nCeci ne supprimera pas les donn�es de la ROM.",
	'rom_remove_single_dupfound_title' =>
		"ROM(S) en double trouv�es !!!",
	'rom_remove_single_dupfound_msg%d%s' =>
		"%d ROM(S) en double trouv�e(s)\n\nVoulez-vous supprimer tous les doublons de\n\n%s\n\n de la liste ?\n\nVoir l'aide pour plus d'informations !",
	'rom_optimize_title' =>
		"Nettoyer la base de donn�es",
	'rom_optimize_msg' =>
		"Voulez-vous nettoyer la base de donn�es des ROMS de ecc ?\n\nVous devez nettoyer la base de donn�es si vous avez d�plac� ou supprim� des ROMS de votre disque dur.\necc cherchera alors automatiquement leurs donn�es et les favoris associ�s, et les supprimera de la base de donn�es !\nCes options modifient seulement la base de donn�es.",
	'rom_optimize_done_title' =>
		"Nettoyage effectu�",
	'rom_optimize_done_msg%s' =>
		"La base de donn�es de la plateforme\n\n%s\n\nest maintenant nettoy�e !",
	'rom_dup_remove_title' =>
		"Supprimer les ROMS en double de la liste",
	'rom_dup_remove_msg%s' =>
		"Voulez-vous supprimer toutes les ROMS en double de\n\n%s\n\nde la liste ?\n\nCette op�ration travaille seulement dans le cadre de la liste des ROMS....\n\nCeci ne supprimera AUCUN fichier du disque dur !!!",
	'rom_dup_remove_done_title' =>
		"Suppression effectu�e",
	'rom_dup_remove_done_msg%s' =>
		"Tous les doublons de ROMS de\n\n%s\n\nont �t� supprim�s de la liste avec succ�s.",
	'rom_reorg_nocat_title' =>
		"Il n'y a aucune cat�gorie !",
	'rom_reorg_nocat_msg%s' =>
		"Vous avez assign� aucune cat�gorie aux ROMS\n\n%s !\n\nSVP utilisez la fonction Editer pour ajouter des cat�gories ou importer des donn�es !",
	'rom_reorg_title' =>
		"R�organiser vos ROMS sur le disque dur",
	'rom_reorg_msg%s%s%s' =>
		"------------------------------------------------------------------------------------------Cette option r�organisera vos ROMS sur le disque dur !!!\nSVP SUPPRIMEZ D'ABORD LES ROMS EN DOUBLE DE LA LISTE !!!\nLE MODE SELECTIONNE EST : #%s#\n------------------------------------------------------------------------------------------\n\nVoulez-vous r�organiser vos ROMS de\n\n%s\n\npar c�t�gorie dans le dossier principal d'ecc ? ecc organisera vos ROMS dans le dossier ecc sous\n\n%s/roms/organized/\n\nSVP v�rifiez s'il y a assez d'espace libre sur votre disque dur.\nVOULEZ-VOUS CONTINUER ? (A VOS RISQUES  :-) )",
	'rom_reorg_done_title' =>
		"R�organisation effectu�e",
	'rom_reorg_done__msg%s' =>
		"Regardez le dossier d'ecc au bout du chemin \n\n%s\n\npour valider la copie.",
	'db_optimize_title' =>
		"Nettoyage de la base de donn�es",
	'db_optimize_msg' =>
		"Voulez-vous nettoyer la base de donn�es ?\nCeci diminuera la taille physique de la base de donn�es d'emuControlCenter. Vous devriez le faire si vous scannez et supprimez souvent des ROMS avec emuControlCenter !\n\nCette op�ration g�lera l'application quelques secondes - SVP attendez ! :-)",
	'db_optimize_done_title' =>
		"Base de donn�es nettoy�e",
	'db_optimize_done_msg' =>
		"La base de donn�es d'ecc est nettoy� !",
	'export_esearch_error_title' =>
		"Aucune option eSearch s�l�ctionn�e",
	'export_esearch_error_msg' =>
		"Vous devez utilisez eSearch (recherche �tendue) pour utiliser cette fonction d'exportation. Ceci exportera le r�sultat de la recherche seulement que vous voyez dans la vue principale !",
	'dat_export_filechooser_title%s' =>
		"Choix du dossier pour sauvegarder le fichier de donn�es %s",	
	'dat_export_title%s' =>
		"Exportation du fichier de donn�es %s",
	'dat_export_msg%s%s%s' =>
		"Voulez-vous exporter un fichier de donn�es %s de la plateforme\n\n%s\n\ndans ce dossier ?\n\n%s",
	'dat_export_esearch_msg_add' =>
		"\n\necc utilisera votre s�lection eSearch pour exporter !",
	'dat_export_done_title' =>
		"Exportation effectu�e",
	'dat_export_done_msg%s%s%s' =>
		"Exportation du fichier de donn�es %s pour\n\n%s\n\ndans la cible\n\n%s\n\neffectu� !",
	'dat_import_filechooser_title%s' =>
		"Importation d'un fichier de donn�es %s",
	'rom_import_backup_title' =>
		"Cr�er une sauvegarde",
	'rom_import_backup_msg%s%s' =>
		"Voulez-vous cr�er une sauvegarde dans le dossier ecc-user de\n\n%s (%s)\n\navant que vous importiez de nouvelles donn�es ?",
	'rom_import_title' =>
		"Importer le fichier de donn�es",
	'rom_import_msg%s%s%s' =>
		"Voulez-vous vraiment importer des donn�es de la plateforme\n\n%s (%s)\n\ndu fichier de donn�es\n\n%s ?",
	'rom_import_done_title' =>
		"Importation effectu�e",
	'rom_import_done_msg%s' =>
		"Importation du fichier de donn�es de\n\n%s\n\neffectu�e !",
	'dat_clear_title%s' =>
		"EFFACER LA BASE DE DONNEES POUR %s",
	'dat_clear_msg%s%s' =>
		"VOULEZ-VOUS EFFACER TOUTES LES DONNEES POUR LES ROMS DE\n\n%s (%s) ?\n\nCeci effacera toutes les informations de la base de donn�es de ecc comme la categorie, le statut, les langues, etc... pour la plateforme s�lectionn�e ! A l'�tape suivante, VOUS POURREZ CREER UNE SAUVERGARDE DE CES INFORMATIONS (qui sera automatiquement enregistr�e dans le dossier ecc-user !).\n\nLa base de donn�es sera automatiquement nettoy�e !",
	'dat_clear_backup_title%s' =>
		"Sauvegarde de %s",
	'dat_clear_backup_msg%s%s' =>
		"Voulez-vous cr�er une sauvegarde de la plateforme\n\n%s (%s) ?",
	'dat_clear_done_title%s' =>
		"Effacement de la base de donn�es effectu�",
	'dat_clear_done_msg%s%s' =>
		"Toutes les donn�es des ROMS de\n\n%s (%s)\n\nsont supprim�es de la base de donn�es d'ecc !",
	'dat_clear_done_ifbackup_msg%s' =>
		"\n\necc a sauvegard� vos donn�es dans le dossier %s-User.",
	'emu_miss_title' =>
		"Erreur - Emulateur non trouv�",
	'emu_miss_notfound_msg%s' =>
		"L'�mulateur assign� \n\n%s \n\nn'a pas �t� trouv� !\nSVP Choisissez le chemin dans Menu/Configuration/Emulateurs.",
	'emu_miss_notset_msg' =>
		"Emulateur manquant !\n\nSVP ajoutez un �mulateur pour cette plateforme/extension ! SVP choisissez le chemin dans Menu/Configuration/Emulateurs.",
	'emu_miss_dir_msg%s' =>
		"Pas d'�mulateur ! (Seul un dossier est enregistr� !)\n\nSVP ajoutez un �mulateur pour cette plateforme/extension !\n\nSVP localisez l'ex�cutable de l'�mulateur (exe, bat, jar, etc...). Un chemin de dossier seul ne suffit pas !",
	'rom_miss_title' =>
		"Erreur - Aucune ROM trouv�e",
	'rom_miss_msg' =>
		"Le fichier s�lectionn� n'a pas �t� trouv� !\n\nSVP utilisez l'option 'Plateforme->Actualiser la liste des ROMS'.\nSVP choisissez aussi si vous utilisez des options comme 'Mode Escape' ou 'Mode 8.3 filename' conformes",
	'img_overwrite_title' =>
		"Remplacer l'image",
	'img_overwrite_msg%s%s' =>
		"L'image\n\n%s\n\nexiste d�j�.\n\nVoulez-vous vraiment remplacer cette image par\n\n%s ?",	
	'img_remove_title' =>
		"Supprimer l'image",
	'img_remove_msg%s' =>
		"Voulez-vous r�ellement supprimer l'image %s ?",
	'img_remove_error_title' =>
		"Erreur - Suppression d'image impossible",
	'img_remove_error_msg%s' =>
		"L'image %s ne peut pas �tre effac�e !",
	'conf_platform_update_title' =>
		"Sauvegarder l'INI de la plateforme",
	'conf_platform_update_msg%s' =>
		"Voulez-vous vraiment enregistrer les modifications de l'INI de la plateforme %s ?",
	'conf_platform_emu_filechooser_title%s' =>
		"Selectionnez un �mulateur pour l'extension '%s'",
	'conf_userfolder_notset_title' =>
		"ERREUR : Dossier user introuvable",
	'conf_userfolder_notset_msg%s' =>
		"Vous avez alt�r� la liste des chemins dans votre ecc_general.ini. Ce dossier n'existe pas.\n\nDois-je cr�er le dossier\n\n%s\n\npour vous ?\n\nSi vous voulez choisir un autre chemin, cliquez NON et utilisez \n'Options'->'Configuration'\npour cr�er votre dossier User !",
	'conf_userfolder_error_readonly_title' =>
		"ERREUR : Impossible de cr�er le dossier",
	'conf_userfolder_error_readonly_msg%s' =>
		"Le dossier %s ne peux pas �tre cr�� parce que vous avez s�lectionn� un chemin en lecture seule (CD ?).\n\nSi vous voulez choisir un autre chemin, cliquez OK et choisissez \n'Options'->'Configuration'\npour choisir votre dossier user !",
	'conf_userfolder_created_title' =>
		"Dossier User cr��",
	'conf_userfolder_created_msg%s%s' =>
		"Les sous-dossiers\n\n%s\n\nsont cr��s dans votre dossier User s�lectionn�\n\n%s",
	'conf_ecc_save_title' =>
		"Sauvegarder le GLOBAL-INI d'emuControlCenter",
	'conf_ecc_save_msg' =>
		"Ceci enregistrera vos changements dans ecc_global.ini.\n\nCeci cr�era aussi le dossier user choisi et tous les sous-dossiers.\n\nVoulez-vous continuer ?",
	'conf_ecc_userfolder_filechooser_title' =>
		"S�lectionnez le chemin pour vos donn�es User",
	'fav_remove_all_title' =>
		"Supprimer tous les favoris",
	'fav_remove_all_msg' =>
		"Voulez-vous vraiment supprimer TOUS les favoris ?",
	'maint_empty_history_title' =>
		'R�initialiser ecc history.ini',
	'maint_empty_history_msg' =>
		'Ceci videra le fichier ecc history.ini. Ce fichier enregistre toutes vos s�lections dans ecc comme les options (ex : Cacher les ROMS en double) et les chemins s�lectionn�s. Voulez-vous r�initialiser ce fichier ?',
	'sys_dialog_info_miss_title' =>
		"?? TITRE MANQUANT ??",
	'sys_dialog_info_miss_msg' =>
		"?? MESSAGE MANQUANT ??",
	'sys_filechooser_miss_title' =>
		"?? TITRE MANQUANT ??",
	'status_dialog_close' =>
		"\n\nVoulez-vous fermer le panneau d'affichage de l'�tat d'avancement du processus ?",
	'status_process_running_title' =>
		"Processus en cours",
	'status_process_running_msg' =>
		"Un autre processus est en cours.\nVous pouvez seulement d�marrer un autre processus comme scan/importation/exportation ! SVP attendez que le processus en cours se termine !",
	'meta_rating_add_error_msg' =>
		"Vous pouvez seulement voter une ROM qui a des donn�es enregistr�es.\n\nSVP utilisez Editer et enregistrez ces informations !",
	'maint_unset_ratings_title' =>
		"Supprimer les votes pour la plateforme",
	'maint_unset_ratings_msg' =>
		"Ceci r�initialisera tous les votes dans la base de donn�es... Voulez-vous continuer ?",
	'eccdb_title' =>
		"eccdb/romdb",
	'eccdb_statistics_msg%s%s%s%s%s' =>
		"eccdb - Statistiques :\n\n%s ajout�e(s),\n%s toujours en place,\n%s erreur(s),\n\n%s fichier(s) de donn�es trait�(s) !%s",
	'eccdb_webservice_post_msg' =>
		"eccdb/romdb - Fichier de base de donn�es :\n\nPour supporter la communaut� d'emuControlCenter, vous pouvez ajouter vos donn�es (titre, categorie, langues etc...) dans eccdb (Internet Database).\n\nCeci fonctionne comme le CDDB (CD DataBase) pour les CD de musique.\n\nSi vous confirmez ceci, ecc transf�rera automatiquement vos donn�es vers eccdb !\n\nVous devez �tre connect� sur Internet pour envoyer vos donn�es !!!\n\nApr�s 10 envois de donn�es, vous devez confirmer pour en transmettre plus !",
	'eccdb_error' =>
		"eccdb - Erreur :\n\nVous n'�tes peut-�tre pas connect� sur Internet... vous pouvez ajouter des donn�es dans eccdb seulement avec une connection Internet active !",
	'eccdb_no_data' =>
		"eccdb - Aucune information pouvant �tre ajout�e trouv�e :\n\nVous devez �diter des donn�es pour les ajouter dans eccdb. Utilisez le bouton Editer et esseyez de nouveau !",
		
	/* 0.9 FYEO 9 */
	'rom_dup_remove_msg_preview%s' =>
		"Cette option cherchera les ROMS en double dans votre base de donn�es et les affichera.\n\nVous pourrez ainsi les retrouver dans l'historique des t�ches (si activ�) dans le dossier ecc-logs !",
	
	/* 0.9.1 FYEO 3 */
	'img_remove_all_title' =>
		"Supprimer toutes le images ?",
	'img_remove_all_msg%s' =>
		"Ceci supprimera toutes les images de la ROM s�lectionn�e !\n\nSupprimer toutes les images de la ROM\n\n%s ?",
	
	/* 0.9.1 FYEO 6 */
	'sys_dialog_miss_title' =>
		"Confirmer",

	/* 0.9.2 WIP 11 */
	'parse_big_file_found_title' =>
		"Voulez-vous analyser ce fichier ?",
	'parse_big_file_found_msg%s%s' =>
		"FICHIER ENORME TROUVEE !!!\n\nLe jeu trouv�\n\nNom : %s\nTaille : %s\n\nest vraiment volumineux. Ceci peut prendre beaucoup de temps sans r�ponse d'emuControlCenter.\n\nVoulez-vous vraiment analyser ce fichier ?",

	/* 0.9.5 WIP 19 */
	'bookmark_added_title' =>
		"Favori sauvegard�",
	'bookmark_added_msg' =>
		"Ce m�dia a �t� ajout� aux favoris !",
	'bookmark_removed_single_title' =>
		"Favori supprim�",
	'bookmark_removed_single_msg' =>
		"Ce favori a �t� supprim� !",
	'bookmark_removed_all_title' =>
		"Favoris supprim�s",
	'bookmark_removed_all_msg' =>
		"Tous les favoris ont �t� supprim�s !",

);
?>