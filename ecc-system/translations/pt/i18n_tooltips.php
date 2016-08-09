﻿<?
/**
 * emuControlCenter language system file
 * ------------------------------------------
 * language:	pt (portuguese)
 * author:	traduzido por rodrigo 'namnam' almeida
 * date:	2009/01/23
 * ------------------------------------------
 */
$i18n['tooltips'] = array(
	// -------------------------------------------------------------
	// tooltips
	// -------------------------------------------------------------
	'opt_auto_nav' =>
		"Atualização automática enquanto navega",
	'opt_hide_nav_null' =>
		"Mostrar/Esconder plataformas sem roms",
	'opt_hide_dup' =>
		"Mostrar/Esconder roms duplicadas",
	'opt_hide_img' =>
		"Mostrar/Esconder imagens",
	'search_field_select' =>
		"Escolha um critério de pesquisa",
	'search_operator' =>
		"Escolha um operador de pesquisa ([ = EQUAL] [ | OR ] [ + AND])",
	'search_rating' =>
		"Mostrar somente roms avaliadas abaixo ou igualmente a seleção",
	'optvis_mainlistmode' =>
		"Trocar entre lista detalhada (imagens) e lista simples",
		
	/* 0.9.7 WIP 01 */

	'nbMediaInfoStateRatingEvent' =>
		"Clique para add sua avaliação pessoal do jogo",
	'nbMediaInfoNoteEvent' =>
		"Mostrar anotações pessoais para este jogo",
	'nbMediaInfoReviewEvent' =>
		"Mostrar resenha para este jogo",
	'nbMediaInfoBookmarkEvent' =>
		"Add / Remover dos favoritos",
	'nbMediaInfoAuditStateEvent' =>
		"Mostrar auditoria para roms multiarquivos",
	'nbMediaInfoMetaEvent' =>
		"Editar metadados para este jogo",

	/* 0.9.7 WIP 14 */

	'opt_only_disk' =>
		"Mostrar apenas a mídia principal",

	/* 0.9.7 WIP 16 */
	'optionContextOnlyDiskAll' =>
		"Mostrar todas as roms",
	'optionContextOnlyDiskOne' =>
		"Mostrar apenas a primeira mídia da rom",
	'optionContextOnlyDiskOnePlus' =>
		"Mostrar primeira mídia + mídias desconhecidas",

	/* 1.11 BUILD 8 */
	// # TOP-ROM
	'menuTopRomAddNewRomTooltip' =>
		"This will add roms for the selected platform!",
	'mTopRomOptimizeTooltip' =>
		"Optimize the ecc-Database for the selected platform e.g. if you move/remove files at your harddrive",
	'mTopRomRemoveDupsTooltip' =>
		"This will remove all duplicate roms from your ecc database",
	'mTopRomRemoveRomsTooltip' =>
		"Remove all roms of the selected platform from the ecc-database",		
	'mTopDatImportRcTooltip' =>
		"You can import Romcenter Datfiles (*.dat) into ecc. You have to select the right platform! RC-Datfiles contain the filename, checksum and metainfos assigned to the filename. emuControlCenter will strip this informations and automaticlly create ecc-metadata!",
	// # TOP-EMU
	'mTopEmuConfigTooltip' =>
		"Change the emulator assigned to the selected platform",
	// # TOP-DAT
	'mTopDatImportEccTooltip' =>
		"Import emuControlCenter Datfiles (*.ecc) into ecc. If you have selected a platform, only roms for this platform will be imported! ecc-datfile-format has extended metainformations like categories, developer, state, languages aso.",
	'mTopDatImportCtrlMAMETooltip' =>
		"Import CTRL MAME Datfiles (*.dat) into ecc.",
	'mTopDatImportRcTooltip' =>
		"Import Romcenter Datfiles (*.dat) into ecc. You have to selected the right platform! RC-Datfiles contains the filename, checksum and metainfos assigned to the filename. emuControlCenter will strip this informations and automaticlly create ecc-metadata!",		
	'mTopDatExportEccFullTooltip' =>
		"This will export all your meta-data of the selected platform to a Datfile (plaintext).",
	'mTopDatExportEccUserTooltip' =>
		"This will export only the data modified by you of the selected platform to a Datfile (plaintext).",
	'mTopDatExportEccEsearchTooltip' =>
		"This will export only the search result of eSearch meta-data of the selected platform to a Datfile (plaintext).",
	'mTopDatClearTooltip' =>
		"Clear data from DATfiles of the selected platform!",
	// # TOP-OPTIONS
	'mTopOptionDbVacuumTooltip' =>
		"Internal function to cleanup and shrink the database.",	
	'mTopOptionCreateUserFolderTooltip' =>
		"This will create all ecc user-folders like emus, roms, exports aso. Use this option, if you have created a new platform!",
	'mTopOptionCleanHistoryTooltip' =>
		"This will clean up the ecc history.ini. Ecc stores data like selected Directories, selected Options aso. in this file.",
	'mTopOptionBackupUserdataTooltip' =>
		"This will backup all your userdata like notes, highscore and time played to an XML file",
	'mTopOptionCreateStartmenuShortcutsTooltip' =>
		"This will create ECC shortcuts in the windows startmenu",
	'mTopOptionConfigTooltip' =>
		"This will open the configuration window of ECC",
	// # TOP-TOOLS
	'mTopToolEccGtktsTooltip' =>
		"Select various GTK themes to use with ECC, you can make a nice combination when used with proper ECC themes.",	
	'mTopToolEccDiagnosticsTooltip' =>
		"This will diagnose and give you information about your ECC installation.",
	'mTopDatDFUTooltip' =>
		"Manually update your DATfiles from MAME DAT.",
	'mTopAutoIt3GUITooltip' =>
		"This will open KODA where you can create end export your own AutoIt3 GUI for use with scripts if needed.",
	'mTopImageIPCTooltip' =>
		"Create imagepacks of your platforms, so you can share it easily with us.",
	// # TOP-DEVELOPER
	'mTopDeveloperSQLTooltip' =>
		"This will open a SQL browser wich you can use to view and edit the ECC database (for experts only, make sure you create a backup of your changes bacause it can be overwritten with a ECC update!)",
	'mTopDeveloperGUITooltip' =>
		"This will open the GLADE GUI editor where you can edit and adjust the ECC GUI (for experts only, make sure you create a backup of your changes bacause it can be overwritten with a ECC update!)",
	// # TOP-UPDATE
	'mTopUpdateEccLiveTooltip' =>
		"This will check if there are updates available for ECC.",
	// # TOP-SERVICES
	'mTopServicesKameleonCodeTooltip' =>
		"This will open a window where you can enter the kameleon code to use ECC services. (registered forum members)",
	// # TOP-HELP
	'mTopHelpWebsiteTooltip' =>
		"This will open the ECC website in your internetbrowser.",
	'mTopHelpForumTooltip' =>
		"This will open the ECC support forum in your internetbrowser.",
	'mTopHelpDocOfflineTooltip' =>
		"This will open the ECC documentation locally.",
	'mTopHelpDocOnlineTooltip' =>
		"This will open the ECC documentation site in your internetbrowser.",
	'mTopHelpAboutTooltip' =>
		"This will pop-up the ECC about box.",
);
?>