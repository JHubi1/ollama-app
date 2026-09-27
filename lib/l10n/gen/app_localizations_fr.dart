// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Ollama';

  @override
  String get optionNewChat => 'Nouveau chat';

  @override
  String get optionSettings => 'Paramètres';

  @override
  String get optionInstallPwa => 'Installer l\'appli Web';

  @override
  String get optionNoChatFound => 'Aucun chat trouvé';

  @override
  String get tipPrefix => 'Astuce : ';

  @override
  String get tip0 => 'Modifiez les messages en appuyant longuement dessus';

  @override
  String get tip1 => 'Supprimez les messages en appuyant deux fois dessus';

  @override
  String get tip2 => 'Vous pouvez changer le thème dans les paramètres';

  @override
  String get tip3 => 'Choisissez un modèle multimodal pour insérer des images';

  @override
  String get tip4 => 'Les chats sont enregistrés automatiquement';

  @override
  String get deleteChat => 'Supprimer';

  @override
  String get renameChat => 'Renommer';

  @override
  String get takeImage => 'Prendre une image';

  @override
  String get uploadImage => 'Téléverser une image';

  @override
  String get notAValidImage => 'Image non valide';

  @override
  String get imageOnlyConversation => 'Conversation d\'images seulement';

  @override
  String get messageInputPlaceholder => 'Message';

  @override
  String get tooltipAttachment => 'Ajouter une pièce jointe';

  @override
  String get tooltipSend => 'Envoyer';

  @override
  String get tooltipSave => 'Enregistrer';

  @override
  String get tooltipLetAIThink => 'Laisser l\'IA réfléchir';

  @override
  String get tooltipAddHostHeaders => 'Ajouter des en-têtes d\'hôte';

  @override
  String get tooltipReset => 'Réinitialiser le chat actuel';

  @override
  String get tooltipOptions => 'Afficher les options';

  @override
  String get noModelSelected => 'Aucun modèle sélectionné';

  @override
  String get noHostSelected => 'Aucun hôte sélectionné, ouvrez les paramètres pour en choisir un';

  @override
  String get noSelectedModel => '<sélecteur>';

  @override
  String get newChatTitle => 'Chat sans nom';

  @override
  String get modelDialogAddModel => 'Ajouter';

  @override
  String get modelDialogAddPromptTitle => 'Ajouter un nouveau modèle';

  @override
  String get modelDialogAddPromptDescription => 'Il peut s\'agir soit d\'un nom simple (p. ex. « llama3 »), soit d\'un nom et d\'un tag (p. ex. « llama3:70b »).';

  @override
  String get modelDialogAddPromptAlreadyExists => 'Le modèle existe déjà';

  @override
  String get modelDialogAddPromptInvalid => 'Nom de modèle non valide';

  @override
  String get modelDialogAddAllowanceTitle => 'Autoriser le proxy';

  @override
  String get modelDialogAddAllowanceDescription => 'Ollama App doit vérifier si le modèle saisi est valide. Pour ce faire, nous envoyons normalement une requête Web à la liste de modèles d\'Ollama et vérifions le code d\'état, mais comme vous utilisez le client Web, nous ne pouvons pas le faire directement. À la place, l\'appli enverra la requête à une autre API, hébergée par JHubi1, pour vérifier pour nous.\nIl s\'agit d\'une requête unique, envoyée seulement lorsque vous ajoutez un nouveau modèle.\nVotre adresse IP sera envoyée avec la requête et pourrait être conservée jusqu\'à dix minutes pour prévenir le spam à des fins potentiellement nuisibles.\nSi vous acceptez, votre choix sera mémorisé pour l\'avenir ; sinon, rien ne sera envoyé et le modèle ne sera pas ajouté.';

  @override
  String get modelDialogAddAllowanceAllow => 'Autoriser';

  @override
  String get modelDialogAddAllowanceDeny => 'Refuser';

  @override
  String modelDialogAddAssuranceTitle(String model) {
    return 'Ajouter $model ?';
  }

  @override
  String modelDialogAddAssuranceDescription(String model) {
    return 'En appuyant sur « Ajouter », le modèle « $model » sera téléchargé directement du serveur Ollama vers votre hôte.\nCela peut prendre un certain temps selon votre connexion Internet. L\'action ne peut pas être annulée.\nSi l\'appli est fermée pendant le téléchargement, celui-ci reprendra si vous entrez de nouveau le nom dans la boîte de dialogue d\'ajout de modèle.';
  }

  @override
  String get modelDialogAddAssuranceAdd => 'Ajouter';

  @override
  String get modelDialogAddAssuranceCancel => 'Annuler';

  @override
  String get modelDialogAddDownloadPercentLoading => 'récupération de la progression';

  @override
  String modelDialogAddDownloadPercent(String percent) {
    return 'Téléchargement à $percent %';
  }

  @override
  String get modelDialogAddDownloadFailed => 'Déconnecté, réessayez';

  @override
  String get modelDialogAddDownloadSuccess => 'Téléchargement réussi';

  @override
  String get deleteDialogTitle => 'Supprimer le chat';

  @override
  String get deleteDialogDescription => 'Êtes-vous sûr de vouloir continuer ? Cette action effacera toute la mémoire de ce chat et ne pourra pas être annulée.\nPour désactiver cette boîte de dialogue, allez dans les paramètres.';

  @override
  String get deleteDialogDelete => 'Supprimer';

  @override
  String get deleteDialogCancel => 'Annuler';

  @override
  String get dialogEnterNewTitle => 'Entrez un nouveau titre';

  @override
  String get dialogEditMessageTitle => 'Modifier le message';

  @override
  String get settingsTitleBehavior => 'Comportement';

  @override
  String get settingsDescriptionBehavior => 'Modifiez le comportement de l\'IA à votre goût.';

  @override
  String get settingsTitleInterface => 'Interface';

  @override
  String get settingsDescriptionInterface => 'Modifiez l\'apparence et le comportement d\'Ollama App.';

  @override
  String get settingsTitleVoice => 'Voix';

  @override
  String get settingsDescriptionVoice => 'Activez le mode vocal et configurez les réglages de la voix.';

  @override
  String get settingsTitleExport => 'Exportation';

  @override
  String get settingsDescriptionExport => 'Exportez et importez votre historique de chats.';

  @override
  String get settingsTitleAbout => 'À propos';

  @override
  String get settingsDescriptionAbout => 'Vérifiez les mises à jour et apprenez-en plus sur Ollama App.';

  @override
  String get settingsSavedAutomatically => 'Les paramètres sont enregistrés automatiquement';

  @override
  String get settingsExperimentalAlpha => 'alpha';

  @override
  String get settingsExperimentalAlphaDescription => 'Cette fonctionnalité est en version alpha et peut ne pas fonctionner comme prévu ou attendu.\nDes problèmes critiques et/ou des dommages critiques permanents à l\'appareil et/ou aux services utilisés ne peuvent pas être exclus.\nUtilisez à vos propres risques. L\'auteur de l\'appli n\'assume aucune responsabilité.';

  @override
  String get settingsExperimentalAlphaFeature => 'Fonctionnalité alpha, maintenez pour en savoir plus';

  @override
  String get settingsExperimentalBeta => 'bêta';

  @override
  String get settingsExperimentalBetaDescription => 'Cette fonctionnalité est en version bêta et peut ne pas fonctionner comme prévu ou attendu.\nDes problèmes moins graves peuvent survenir ou non. Les dommages ne devraient pas être critiques.\nUtilisez à vos propres risques.';

  @override
  String get settingsExperimentalBetaFeature => 'Fonctionnalité bêta, maintenez pour en savoir plus';

  @override
  String get settingsExperimentalDeprecated => 'obsolète';

  @override
  String get settingsExperimentalDeprecatedDescription => 'Cette fonctionnalité est obsolète et sera retirée dans une version future.\nElle peut ne pas fonctionner comme prévu ou attendu. Utilisez à vos propres risques.';

  @override
  String get settingsExperimentalDeprecatedFeature => 'Fonctionnalité obsolète, maintenez pour en savoir plus';

  @override
  String get settingsHost => 'Hôte';

  @override
  String get settingsHostValid => 'Hôte valide';

  @override
  String get settingsHostChecking => 'Vérification de l\'hôte';

  @override
  String settingsHostInvalid(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': 'URL non valide',
        'host': 'Hôte non valide',
        'auth': 'Échec de l\'authentification',
        'timeout': 'Échec de la requête. Problèmes de serveur',
        'ratelimit': 'Trop de requêtes',
        'other': 'Échec de la requête',
      },
    );
    return 'Problème : $_temp0';
  }

  @override
  String get settingsHostHeaderTitle => 'Définir l\'en-tête d\'hôte';

  @override
  String get settingsHostHeaderInvalid => 'Le texte saisi n\'est pas un objet JSON d\'en-tête valide';

  @override
  String settingsHostInvalidDetailed(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': 'L\'URL que vous avez saisie n\'est pas valide. Utilisez une URL complète commençant par http:// ou https:// — par exemple http://localhost:11434 pour un serveur Ollama local, ou https://ollama.com pour Ollama Cloud. N\'ajoutez pas de barre oblique finale ni de chemin /api.',
        'host': 'L\'hôte que vous avez saisi n\'est pas valide. Il est impossible de le joindre. Vérifiez l\'hôte et réessayez.',
        'auth': 'Le serveur a refusé la requête (401/403). Si vous vous connectez à Ollama Cloud (https://ollama.com), entrez votre clé d\'API dans le champ de jeton ci-dessous — vous pouvez la créer ou la copier à https://ollama.com/keys — puis enregistrez-la. Si vous utilisez un serveur auto-hébergé, vérifiez l\'en-tête Authorization configuré pour l\'hôte.',
        'other': 'L\'hôte que vous avez saisi n\'est pas valide. Il est impossible de le joindre. Vérifiez l\'hôte et réessayez.',
      },
    );
    return '$_temp0';
  }

  @override
  String get settingsApiTokenInvalid => 'Jeton d\'API refusé';

  @override
  String get settingsApiTokenInvalidDetailed => 'Le jeton d\'API a été refusé par le serveur (401/403). Vérifiez qu\'il est copié exactement comme affiché à https://ollama.com/keys — une nouvelle clé peut être créée sur cette page — puis enregistrez-le de nouveau. Le jeton doit être défini tant que l\'hôte est https://ollama.com.';

  @override
  String get settingsApiTokenVerified => 'Jeton d\'API enregistré et vérifié';

  @override
  String get settingsApiToken => 'Jeton d\'API Ollama Cloud';

  @override
  String get settingsApiTokenHint => 'Collez le jeton depuis ollama.com';

  @override
  String get tooltipShowToken => 'Afficher le jeton';

  @override
  String get tooltipHideToken => 'Masquer le jeton';

  @override
  String voiceLanguageInstruction(String language) {
    return 'Vous devez écrire dans la langue suivante : $language !';
  }

  @override
  String get settingsSystemMessage => 'Message système';

  @override
  String get settingsUseSystem => 'Utiliser le message système';

  @override
  String get settingsUseSystemDescription => 'Désactive la définition du message système ci-dessus et utilise plutôt celui du modèle. Peut être utile pour les modèles avec des fichiers de modèle';

  @override
  String get settingsDisableMarkdown => 'Désactiver le markdown';

  @override
  String get settingsBehaviorNotUpdatedForOlderChats => 'Les paramètres de comportement ne sont pas mis à jour pour les anciens chats';

  @override
  String get settingsShowModelTags => 'Afficher les tags des modèles';

  @override
  String get settingsPreloadModels => 'Précharger les modèles';

  @override
  String get settingsResetOnModelChange => 'Réinitialiser au changement de modèle';

  @override
  String get settingsRequestTypeStream => 'Flux';

  @override
  String get settingsRequestTypeRequest => 'Requête';

  @override
  String get settingsGenerateTitles => 'Générer les titres';

  @override
  String get settingsEnableEditing => 'Modification des messages';

  @override
  String get settingsAskBeforeDelete => 'Demander avant de supprimer un chat';

  @override
  String get settingsShowTips => 'Afficher les astuces dans la barre latérale';

  @override
  String get settingsKeepModelLoadedAlways => 'Garder le modèle toujours chargé';

  @override
  String get settingsKeepModelLoadedNever => 'Ne pas garder le modèle chargé';

  @override
  String get settingsKeepModelLoadedFor => 'Définir une durée spécifique de chargement du modèle';

  @override
  String settingsKeepModelLoadedSet(String minutes) {
    return 'Garder le modèle chargé pendant $minutes minutes';
  }

  @override
  String get settingsTimeoutMultiplier => 'Multiplicateur de délai d\'attente';

  @override
  String get settingsTimeoutMultiplierDescription => 'Choisissez le multiplicateur appliqué à chaque valeur de délai d\'attente dans l\'appli. Peut être utile avec une connexion Internet lente ou un hôte lent.';

  @override
  String get settingsTimeoutMultiplierExample => 'P. ex. le délai d\'attente des messages :';

  @override
  String get settingsEnableHapticFeedback => 'Activer le retour haptique';

  @override
  String get settingsMaximizeOnStart => 'Démarrer agrandi';

  @override
  String get settingsBrightnessSystem => 'Système';

  @override
  String get settingsBrightnessLight => 'Clair';

  @override
  String get settingsBrightnessDark => 'Sombre';

  @override
  String get settingsThemeDevice => 'Appareil';

  @override
  String get settingsThemeOllama => 'Ollama';

  @override
  String get settingsTemporaryFixes => 'Correctifs temporaires de l\'interface';

  @override
  String get settingsTemporaryFixesDescription => 'Activez des correctifs temporaires pour les problèmes d\'interface.\nMaintenez longuement les options individuelles pour en savoir plus.';

  @override
  String get settingsTemporaryFixesInstructions => 'N\'activez aucun de ces paramètres à moins de savoir ce que vous faites ! Les solutions proposées peuvent ne pas fonctionner comme attendu.\nElles ne peuvent pas être considérées comme définitives ou jugées comme telles. Des problèmes peuvent survenir.';

  @override
  String get settingsTemporaryFixesNoFixes => 'Aucun correctif disponible';

  @override
  String get settingsVoicePermissionLoading => 'Chargement des autorisations de voix ...';

  @override
  String get settingsVoiceTtsNotSupported => 'Synthèse vocale non prise en charge';

  @override
  String get settingsVoiceTtsNotSupportedDescription => 'Les services de synthèse vocale ne sont pas pris en charge pour la langue sélectionnée. Choisissez une autre langue dans le volet des langues pour les réactiver.\nLes autres services, comme la reconnaissance vocale et la réflexion de l\'IA, continueront de fonctionner comme d\'habitude, mais l\'interaction pourrait être moins fluide.';

  @override
  String get settingsVoicePermissionNot => 'Autorisations non accordées';

  @override
  String get settingsVoiceNotEnabled => 'Mode vocal non activé';

  @override
  String get settingsVoiceNotSupported => 'Mode vocal non pris en charge';

  @override
  String get settingsVoiceEnable => 'Activer le mode vocal';

  @override
  String get settingsVoiceNoLanguage => 'Aucune langue sélectionnée';

  @override
  String get settingsVoiceLimitLanguage => 'Limiter à la langue sélectionnée';

  @override
  String get settingsVoicePunctuation => 'Activer la ponctuation par l\'IA';

  @override
  String get settingsExportChats => 'Exporter les chats';

  @override
  String get settingsExportChatsSuccess => 'Chats exportés avec succès';

  @override
  String get settingsImportChats => 'Importer les chats';

  @override
  String get settingsImportChatsTitle => 'Importer';

  @override
  String get settingsImportChatsDescription => 'L\'étape suivante importera les chats du fichier sélectionné. Cette action remplacera tous les chats actuellement disponibles.\nVoulez-vous continuer ?';

  @override
  String get settingsImportChatsImport => 'Importer et effacer';

  @override
  String get settingsImportChatsCancel => 'Annuler';

  @override
  String get settingsImportChatsSuccess => 'Chats importés avec succès';

  @override
  String get settingsExportInfo => 'Cette option vous permet d\'exporter et d\'importer votre historique de chats. Cela peut être utile si vous voulez transférer votre historique de chats vers un autre appareil ou en faire une copie de sauvegarde';

  @override
  String get settingsExportWarning => 'Plusieurs historiques de chats ne seront pas fusionnés ! Vous perdrez votre historique de chats actuel si vous en importez un nouveau';

  @override
  String get settingsUpdateCheck => 'Rechercher des mises à jour';

  @override
  String get settingsUpdateChecking => 'Recherche de mises à jour ...';

  @override
  String get settingsUpdateLatest => 'Vous utilisez la version la plus récente';

  @override
  String settingsUpdateAvailable(String version) {
    return 'Mise à jour disponible (v$version)';
  }

  @override
  String get settingsUpdateRateLimit => 'Impossible de vérifier, limite de requêtes de l\'API dépassée';

  @override
  String get settingsUpdateIssue => 'Un problème est survenu';

  @override
  String get settingsUpdateDialogTitle => 'Nouvelle version disponible';

  @override
  String get settingsUpdateDialogDescription => 'Une nouvelle version d\'Ollama est disponible. Voulez-vous la télécharger et l\'installer maintenant ?';

  @override
  String get settingsUpdateChangeLog => 'Journal des modifications';

  @override
  String get settingsUpdateDialogUpdate => 'Mettre à jour';

  @override
  String get settingsUpdateDialogCancel => 'Annuler';

  @override
  String get settingsCheckForUpdates => 'Rechercher des mises à jour à l\'ouverture';

  @override
  String get settingsGithub => 'GitHub';

  @override
  String get settingsReportIssue => 'Signaler un problème';

  @override
  String get settingsLicenses => 'Licences';

  @override
  String settingsVersion(String version) {
    return 'Ollama App v$version';
  }
}