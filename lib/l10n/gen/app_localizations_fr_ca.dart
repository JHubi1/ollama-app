// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

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
}