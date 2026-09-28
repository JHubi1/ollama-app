// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// The translations for French, as used in Canada (`fr_CA`).
class AppLocalizationsFrCa extends AppLocalizationsFr {
  AppLocalizationsFrCa() : super('fr_CA');

  @override
  String get messageInputPlaceholder => 'Message';

  @override
  String get optionNewChat => 'Nouveau clavardage';

  @override
  String get optionNoChatFound => 'Aucun clavardage trouvé';

  @override
  String get tip4 => 'Les clavardages sont enregistrés automatiquement';

  @override
  String get tooltipReset => 'Réinitialiser le clavardage actuel';

  @override
  String get newChatTitle => 'Clavardage sans nom';

  @override
  String get modelDialogAddPromptDescription => 'Il peut s\'agir soit d\'un nom simple (p. ex. « llama3 »), soit d\'un nom et d\'une étiquette (p. ex. « llama3:70b »).';

  @override
  String get modelDialogAddAllowanceTitle => 'Autoriser le serveur mandataire';

  @override
  String get modelDialogAddAllowanceDescription => 'Ollama App doit vérifier si le modèle saisi est valide. Pour ce faire, nous envoyons normalement une requête Web à la liste de modèles d\'Ollama et vérifions le code d\'état, mais comme vous utilisez le client Web, nous ne pouvons pas le faire directement. À la place, l\'appli enverra la requête à une autre API, hébergée par JHubi1, pour vérifier pour nous.\nIl s\'agit d\'une requête unique, envoyée seulement lorsque vous ajoutez un nouveau modèle.\nVotre adresse IP sera envoyée avec la requête et pourrait être conservée jusqu\'à dix minutes pour prévenir le pourriellage à des fins potentiellement nuisibles.\nSi vous acceptez, votre choix sera mémorisé pour l\'avenir; sinon, rien ne sera envoyé et le modèle ne sera pas ajouté.';

  @override
  String modelDialogAddAssuranceDescription(String model) {
    return 'En appuyant sur « Ajouter », le modèle « $model » sera téléchargé directement du serveur Ollama vers votre hôte.\nCela peut prendre un certain temps selon votre connexion Internet. L\'action ne peut pas être annulée.\nSi l\'appli est fermée pendant le téléchargement, celui-ci reprendra si vous entrez de nouveau le nom dans le dialogue d\'ajout de modèle.';
  }

  @override
  String get deleteDialogTitle => 'Supprimer le clavardage';

  @override
  String get deleteDialogDescription => 'Êtes-vous sûr de vouloir continuer ? Cette action effacera toute la mémoire de ce clavardage et ne pourra pas être annulée.\nPour désactiver ce dialogue, allez dans les paramètres.';

  @override
  String get settingsDescriptionExport => 'Exportez et importez votre historique de clavardages.';

  @override
  String get settingsBehaviorNotUpdatedForOlderChats => 'Les paramètres de comportement ne sont pas mis à jour pour les anciens clavardages';

  @override
  String get settingsAskBeforeDelete => 'Demander avant de supprimer un clavardage';

  @override
  String get settingsShowModelTags => 'Afficher les étiquettes des modèles';

  @override
  String get settingsEnableHapticFeedback => 'Activer la rétroaction haptique';

  @override
  String get settingsMaximizeOnStart => 'Démarrer maximisé';

  @override
  String get settingsExportChats => 'Exporter les clavardages';

  @override
  String get settingsExportChatsSuccess => 'Clavardages exportés avec succès';

  @override
  String get settingsImportChats => 'Importer les clavardages';

  @override
  String get settingsImportChatsDescription => 'L\'étape suivante importera les clavardages du fichier sélectionné. Cette action remplacera tous les clavardages actuellement disponibles.\nVoulez-vous continuer ?';

  @override
  String get settingsImportChatsSuccess => 'Clavardages importés avec succès';

  @override
  String get settingsExportInfo => 'Cette option vous permet d\'exporter et d\'importer votre historique de clavardages. Cela peut être utile si vous voulez transférer votre historique de clavardages vers un autre appareil ou en faire une copie de sauvegarde';

  @override
  String get settingsExportWarning => 'Plusieurs historiques de clavardages ne seront pas fusionnés ! Vous perdrez votre historique de clavardages actuel si vous en importez un nouveau';

  @override
  String get settingsDescriptionAccessibility => 'Énoncé d\'accessibilité, résultats de tests et façon de signaler un problème.';

  @override
  String get accessibilityStatementTitle => 'Énoncé d\'accessibilité';

  @override
  String get accessibilityCommitmentIntro => 'Ollama doit être utilisable par des personnes de toutes capacités, dans chaque langue que nous offrons. La commande vocale, les lecteurs d\'écran, la navigation au clavier et le rendu à contraste élevé sont des façons à part entière d\'utiliser cette appli — non des ajouts de dernière minute.';

  @override
  String get accessibilityCommitmentDetails => 'Concrètement, cela signifie : chaque contrôle interactif porte un nom que les lecteurs d\'écran annoncent (y compris l\'état du mode vocal), les boutons conservent une cible tactile minimale de 48dp, le focus clavier suit l\'ordre visuel de l\'interface, les messages d\'état sont annoncés pendant qu\'ils changent, et l\'interface demeure utilisable à de grandes tailles de texte ainsi que dans les thèmes clair et sombre.';

  @override
  String get accessibilityConformanceStatus => 'Cette appli est conçue pour se conformer aux Règles pour l\'accessibilité des contenus Web (WCAG) 2.2 de niveau AA. La conformité n\'a pas été certifiée de façon indépendante par un tiers; elle repose sur nos propres tests automatisés. Lorsque c\'est faisable, nous allons au-delà du niveau AA et appliquons des mesures WCAG AAA, qui sont énumérées ci-dessous.';

  @override
  String get accessibilityAaaMeasures => 'Le texte principal utilise un contraste de 21:1 dans les deux thèmes (le niveau AAA exige 7:1), le texte secondaire atténué utilise un contraste de 10:1 ou mieux, les couleurs d\'état de réussite et d\'avertissement atteignent le contraste AAA dans les deux thèmes, et le texte d\'erreur du thème sombre atteint le contraste AAA. Le niveau AAA exige en outre des mesures peu pratiques dans une appli de clavardage de cette taille (par exemple un contraste de 7:1 sur absolument tout le texte et des limites de niveau de lecture); nous visons donc le niveau AA comme garantie et considérons ces mesures AAA comme des bonifications.';

  @override
  String get accessibilityAodaTitle => 'Loi de 2005 sur l\'accessibilité pour les personnes handicapées de l\'Ontario (AODA)';

  @override
  String get accessibilityAodaText => 'La Loi de 2005 sur l\'accessibilité pour les personnes handicapées de l\'Ontario (AODA) exige que les produits numériques respectent les WCAG 2.0/2.1 de niveau AA. La cible WCAG 2.2 de niveau AA de cette appli atteint et dépasse ce seuil de référence. Les rétroactions sur l\'accessibilité sont bienvenues au moyen du formulaire de contact de cette page, conformément à l\'exigence de l\'AODA de rendre accessibles les voies de rétroaction.';

  @override
  String get accessibilityStandardsEuropeText => 'Dans l\'Union européenne, la norme harmonisée EN 301 549 définit les exigences d\'accessibilité des TIC de la Loi européenne sur l\'accessibilité, qui renvoie aux WCAG 2.1 de niveau AA. La cible WCAG 2.2 de niveau AA de cette appli couvre ces exigences et appuie les obligations européennes d\'accessibilité applicables à compter du 28 juin 2025.';

  @override
  String get accessibilityStandardsUsText => 'Aux États-Unis, l\'Americans with Disabilities Act (ADA) constitue le seuil de référence général en matière de non-discrimination, et la Section 508 du Rehabilitation Act exige les WCAG 2.0 de niveau AA pour la technologie du gouvernement fédéral (la Section 504 impose des obligations semblables aux programmes financés). La cible WCAG 2.2 de niveau AA de cette appli atteint et dépasse ces seuils de référence.';

  @override
  String get accessibilityKnownIssuesTitle => 'Limites connues';

  @override
  String get accessibilityKnownIssues => 'Les boutons de la barre de titre de la fenêtre de bureau (réduire, agrandir, fermer) sont fournis par l\'intégration du système d\'exploitation et ne sont pas accessibles dans l\'arborescence du lecteur d\'écran de l\'appli. La bibliothèque de clavardages affiche une petite partie de son propre texte d\'interface, qui pourrait ne pas encore être offert dans toutes les langues. En mode vocal, le texte de la réponse s\'estompe près du bord de l\'écran, et les très longues lignes de clavardage peuvent être tronquées par des points de suspension lorsque la taille du texte du système est augmentée de façon marquée.';

  @override
  String accessibilityLastValidated(String version) {
    return 'Les vérifications automatisées ont été validées pour la dernière fois avec Ollama App v$version.';
  }

  @override
  String get accessibilityTestsTitle => 'Résultats de tests';

  @override
  String get accessibilityTestsPass => 'Réussite';

  @override
  String get accessibilityTestLabeledTapTarget => 'Les cibles tactiles portent des étiquettes pour lecteur d\'écran';

  @override
  String get accessibilityTestAndroidTapTarget => 'Les cibles tactiles mesurent au moins 48x48dp (recommandation Android)';

  @override
  String get accessibilityTestIosTapTarget => 'Les cibles tactiles mesurent au moins 44x44dp (recommandation iOS)';

  @override
  String get accessibilityTestSemanticsPresent => 'Des étiquettes pour lecteur d\'écran existent pour tous les contrôles personnalisés';

  @override
  String get accessibilityContactIntro => 'Utilisez ce formulaire pour demander des renseignements sur l\'accessibilité, demander une résolution ou signaler un obstacle à l\'accessibilité. Votre signalement est préparé sous forme de message que vous pouvez envoyer par courriel ou sous forme de problème public sur GitHub.';

  @override
  String get accessibilityFormEmail => 'Courriel (facultatif)';

  @override
  String get accessibilityFormDescriptionHint => 'Que tentiez-vous de faire, et qu\'est-ce qui vous a empêché d\'y parvenir ?';

  @override
  String get accessibilityFormErrorDescription => 'Veuillez décrire le problème avant d\'envoyer.';

  @override
  String get accessibilityFormErrorEmail => 'Veuillez entrer une adresse courriel valide ou laisser le champ vide.';


  @override
  String get tooltipResetChat => 'Réinitialiser le clavardage actuel';

  @override
  String get tooltipVoiceSettings => 'Ouvrir les paramètres de la voix';

  @override
  String get accessibilityVoiceOrbListening => 'Le mode vocal est à l\'écoute. Touchez pour cesser l\'écoute.';

  @override
  String get accessibilityVoiceOrbSpeaking => 'La réponse est en train d\'être lue à voix haute. Touchez pour arrêter.';

  @override
  String get accessibilityVoiceOrbThinking => 'L\'IA prépare une réponse. Touchez pour annuler.';

  @override
  String get accessibilityWelcomePage1 => 'Bienvenue dans Ollama. Ce processus d\'accueil présente trois courtes images.';

  @override
  String get accessibilityWelcomePage2 => 'Page d\'accueil 2 sur 3. L\'image montre comment choisir un modèle et commencer un clavardage.';

  @override
  String get accessibilityWelcomePage3 => 'Page d\'accueil 3 sur 3. L\'image montre où trouver les paramètres et le mode vocal.';

  @override
  String get accessibilitySummaryConformance => 'Cette appli vise les WCAG 2.2 de niveau AA et applique des bonifications de niveau AAA. Certaines fonctionnalités présentent des limites, décrites dans chaque section.';

  @override
  String get accessibilitySectionContactSummary => 'Signalez un problème d\'accessibilité par courriel ou sur GitHub. Nous répondons à tous les signalements.';

  @override
  String get accessibilitySupportLevelCompliantWithLimitations => 'Conforme avec des limites';
}