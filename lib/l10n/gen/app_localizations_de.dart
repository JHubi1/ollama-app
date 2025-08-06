// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Ollama';

  @override
  String get optionNewChat => 'Neuer Chat';

  @override
  String get optionSettings => 'Einstellungen';

  @override
  String get optionInstallPwa => 'Webapp installieren';

  @override
  String get optionNoChatFound => 'Keine Chats gefunden';

  @override
  String get tipPrefix => 'Tipp: ';

  @override
  String get tip0 => 'Bearbeite Nachrichten durch langes Tippen';

  @override
  String get tip1 => 'Lösche Nachrichten durch Doppeltippen';

  @override
  String get tip2 => 'Das Thema kann in den Einstellungen geändert werden';

  @override
  String get tip3 => 'Wähle ein multimodales Modell zum Anhängen von Bildern';

  @override
  String get tip4 => 'Chats werden automatisch gespeichert';

  @override
  String get deleteChat => 'Löschen';

  @override
  String get renameChat => 'Umbenennen';

  @override
  String get takeImage => 'Bild Aufnehmen';

  @override
  String get uploadImage => 'Bild Hochladen';

  @override
  String get notAValidImage => 'Kein gültiges Bild';

  @override
  String get imageOnlyConversation => 'Nur Bild Unterhaltung';

  @override
  String get messageInputPlaceholder => 'Nachricht';

  @override
  String get tooltipAttachment => 'Anhang hinzufügen';

  @override
  String get tooltipSend => 'Senden';

  @override
  String get tooltipSave => 'Speichern';

  @override
  String get tooltipLetAIThink => 'Lass KI denken';

  @override
  String get tooltipAddHostHeaders => 'Host-Header festlegen';

  @override
  String get tooltipReset => 'Aktuellen Chat zurücksetzen';

  @override
  String get tooltipOptions => 'Optionen anzeigen';

  @override
  String get noModelSelected => 'Kein Modell ausgewählt';

  @override
  String get noHostSelected =>
      'Kein Host ausgewählt, öffne zum Auswählen die Einstellungen';

  @override
  String get noSelectedModel => '<selektor>';

  @override
  String get newChatTitle => 'Unbenannter Chat';

  @override
  String get modelDialogAddModel => 'Hinzufügen';

  @override
  String get modelDialogAddPromptTitle => 'Neues Modell hinzufügen';

  @override
  String get modelDialogAddPromptDescription =>
      'Das kann entweder ein normaler Name (z.B. \'llama3\') oder Name und Tag (z.B. \'llama3:70b\') sein.';

  @override
  String get modelDialogAddPromptAlreadyExists => 'Modell existiert bereits';

  @override
  String get modelDialogAddPromptInvalid => 'Ungültiger Modellname';

  @override
  String get modelDialogAddAllowanceTitle => 'Proxy erlauben';

  @override
  String get modelDialogAddAllowanceDescription =>
      'Ollama App muss überprüfen, ob das eingegebene Modell gültig ist. Dafür senden wir normalerweise eine Webanfrage an die Ollama-Modellliste und überprüfen den Statuscode, aber da gerade der Webclient verwendet wird, können wir das nicht direkt tun. Stattdessen sendet die App die Anfrage an eine andere API, gehostet von JHubi1, um dies für uns zu überprüfen.\nDies ist eine einmalige Anfrage und wird nur gesendet, wenn du ein neues Modell hinzufügst.\nIhre IP-Adresse wird mit der Anfrage gesendet und kann bis zu zehn Minuten gespeichert werden, um Spamming mit potenziell schädlichen Absichten zu verhindern.\nWenn du zustimmst, wird deine Auswahl für die Zukunft gespeichert; wenn nicht, wird nichts gesendet und das Modell wird nicht hinzugefügt.';

  @override
  String get modelDialogAddAllowanceAllow => 'Erlauben';

  @override
  String get modelDialogAddAllowanceDeny => 'Ablehnen';

  @override
  String modelDialogAddAssuranceTitle(String model) {
    return '$model hinzufügen?';
  }

  @override
  String modelDialogAddAssuranceDescription(String model) {
    return 'Durch Drücken von \'Hinzufügen\' wird das Modell \'$model\' direkt vom Ollama-Server auf deinen Host heruntergeladen.\nJe nach Internetverbindung kann dies eine Weile dauern. Der Vorgang kann nicht abgebrochen werden.\nWenn die App während des Downloads geschlossen wird, wird der Download fortgesetzt, wenn du den Namen erneut in den Modelldialog eingibst.';
  }

  @override
  String get modelDialogAddAssuranceAdd => 'Hinzufügen';

  @override
  String get modelDialogAddAssuranceCancel => 'Abbrechen';

  @override
  String get modelDialogAddDownloadPercentLoading => 'lade Fortschritt';

  @override
  String modelDialogAddDownloadPercent(String percent) {
    return 'Download bei $percent%';
  }

  @override
  String get modelDialogAddDownloadFailed => 'Getrennt, versuche es erneut';

  @override
  String get modelDialogAddDownloadSuccess => 'Download erfolgreich';

  @override
  String get deleteDialogTitle => 'Chat löschen';

  @override
  String get deleteDialogDescription =>
      'Bist du sicher, dass du fortfahren möchtest? Dies wird alle Erinnerungen dieses Chats löschen und kann nicht rückgängig gemacht werden.\nUm diesen Dialog zu deaktivieren, besuche die Einstellungen.';

  @override
  String get deleteDialogDelete => 'Löschen';

  @override
  String get deleteDialogCancel => 'Abbrechen';

  @override
  String get dialogEnterNewTitle => 'Gib bitte einen neuen Titel ein';

  @override
  String get dialogEditMessageTitle => 'Nachricht bearbeiten';

  @override
  String get settingsTitleBehavior => 'Verhalten';

  @override
  String get settingsDescriptionBehavior =>
      'Ändere das Verhalten der KI nach deinen Wünschen.';

  @override
  String get settingsTitleInterface => 'Oberfläche';

  @override
  String get settingsDescriptionInterface =>
      'Bearbeite das Aussehen und Verhalten von Ollama App.';

  @override
  String get settingsTitleVoice => 'Voice';

  @override
  String get settingsDescriptionVoice =>
      'Voice Mode aktivieren und Spracheinstellungen anpassen.';

  @override
  String get settingsTitleExport => 'Exportieren';

  @override
  String get settingsDescriptionExport =>
      'Exportiere und importiere deinen Chat-Verlauf.';

  @override
  String get settingsTitleAbout => 'Über';

  @override
  String get settingsDescriptionAbout =>
      'Suche nach Updates und erfahre mehr über Ollama App.';

  @override
  String get settingsSavedAutomatically =>
      'Einstellungen werden automatisch gespeichert';

  @override
  String get settingsExperimentalAlpha => 'alpha';

  @override
  String get settingsExperimentalAlphaDescription =>
      'Diese Funktion befindet sich im Alpha-Status und funktioniert möglicherweise nicht wie beabsichtigt oder erwartet.\nKritische Probleme und/oder dauerhafte kritische Schäden am Gerät und/oder den verwendeten Diensten können nicht ausgeschlossen werden.\nBenutzung auf eigene Gefahr. Keine Haftung seitens des App-Autors.';

  @override
  String get settingsExperimentalAlphaFeature =>
      'Alpha-Funktion, halte, um mehr zu erfahren';

  @override
  String get settingsExperimentalBeta => 'beta';

  @override
  String get settingsExperimentalBetaDescription =>
      'Diese Funktion befindet sich im Beta-Test und funktioniert möglicherweise nicht wie beabsichtigt oder erwartet.\nWeniger schwerwiegende Probleme können auftreten oder auch nicht. Schäden sollten nicht kritisch sein.\nVerwendung auf eigene Gefahr.';

  @override
  String get settingsExperimentalBetaFeature =>
      'Beta-Funktion, halte, um mehr zu erfahren';

  @override
  String get settingsExperimentalDeprecated => 'veraltet';

  @override
  String get settingsExperimentalDeprecatedDescription =>
      'Diese Funktion ist veraltet und wird in einer zukünftigen Version entfernt werden.\nEs funktioniert möglicherweise nicht wie beabsichtigt oder erwartet. Benutzung auf eigenes Gefahr.';

  @override
  String get settingsExperimentalDeprecatedFeature =>
      'Veraltete Funktion, halte, um mehr zu erfahren';

  @override
  String get settingsHost => 'Host';

  @override
  String get settingsHostValid => 'Gültiger Host';

  @override
  String get settingsHostChecking => 'Host wird Überprüft';

  @override
  String settingsHostInvalid(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': 'Ungültige URL',
        'host': 'Ungültiger Host',
        'timeout': 'Request Fehlgeschlagen. Server Fehler',
        'ratelimit': 'Zu viele Anfragen',
        'other': 'Request Fehlgeschlagen',
      },
    );
    return 'Fehler: $_temp0';
  }

  @override
  String get settingsHostHeaderTitle => 'Host-Header festlegen';

  @override
  String get settingsHostHeaderInvalid =>
      'Der eingegebene Text ist kein gültiges Header-JSON-Objekt';

  @override
  String settingsHostInvalidDetailed(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url':
            'Die eingegebene URL ist ungültig. Es handelt sich nicht um ein standardisiertes URL-Format.',
        'other':
            'Der eingegebene Host ist ungültig. Er kann nicht erreicht werden. Bitte überprüfe den Host und versuche es erneut.',
      },
    );
    return '$_temp0';
  }

  @override
  String get settingsSystemMessage => 'Systemnachricht';

  @override
  String get settingsUseSystem => 'Systemnachricht verwenden';

  @override
  String get settingsUseSystemDescription =>
      'Deaktiviere das Setzen der obigen Systemnachricht und benutze stattdessen die des Modells. Kann nützlich für Modelle mit Model-Files sein';

  @override
  String get settingsDisableMarkdown => 'Markdown deaktivieren';

  @override
  String get settingsBehaviorNotUpdatedForOlderChats =>
      'Verhaltenseinstellungen werden nicht für ältere Chats aktualisiert';

  @override
  String get settingsShowModelTags => 'Model-Tags anzeigen';

  @override
  String get settingsPreloadModels => 'Modelle vorladen';

  @override
  String get settingsResetOnModelChange => 'Zurücksetzen bei Modelländerung';

  @override
  String get settingsRequestTypeStream => 'Stream';

  @override
  String get settingsRequestTypeRequest => 'Request';

  @override
  String get settingsGenerateTitles => 'Titel generieren';

  @override
  String get settingsEnableEditing => 'Nachrichtenbearbeitung aktivieren';

  @override
  String get settingsAskBeforeDelete => 'Vor Löschung des Chats fragen';

  @override
  String get settingsShowTips => 'Tipps in der Seitenleiste anzeigen';

  @override
  String get settingsKeepModelLoadedAlways => 'Modell immer geladen lassen';

  @override
  String get settingsKeepModelLoadedNever => 'Modell nicht dauerhaft laden';

  @override
  String get settingsKeepModelLoadedFor =>
      'Bestimmte Modell-Ladedauer festlegen';

  @override
  String settingsKeepModelLoadedSet(String minutes) {
    return 'Modell für $minutes Minuten geladen behalten';
  }

  @override
  String get settingsTimeoutMultiplier => 'Timeout Multiplikator';

  @override
  String get settingsTimeoutMultiplierDescription =>
      'Wähle den Multiplikator aus, der auf jeden Timeout-Wert in der App angewendet wird. Kann bei einer langsamen Internetverbindung oder einem langsamen Host nützlich sein.';

  @override
  String get settingsTimeoutMultiplierExample => 'Z.b. Nachrichten-Timeout:';

  @override
  String get settingsEnableHapticFeedback => 'Haptisches Feedback aktivieren';

  @override
  String get settingsMaximizeOnStart => 'Maximiert starten';

  @override
  String get settingsBrightnessSystem => 'System';

  @override
  String get settingsBrightnessLight => 'Hell';

  @override
  String get settingsBrightnessDark => 'Dunkel';

  @override
  String get settingsThemeDevice => 'Gerät';

  @override
  String get settingsThemeOllama => 'Ollama';

  @override
  String get settingsTemporaryFixes => 'Temporäre Interface Korrekturen';

  @override
  String get settingsTemporaryFixesDescription =>
      'Temporäre Korrekturen für Interface-Probleme aktivieren.\nDrücke lange auf die einzelnen Optionen, um mehr zu erfahren.';

  @override
  String get settingsTemporaryFixesInstructions =>
      'Aktiviere keine dieser Einstellungen, solltest du nicht wissen, was sie machen! Die gegebene Lösung funktioniert möglicherweise nicht wie erwartet.\nSie können nicht als final gesehen werden und sollten nicht als dieses bewertet werden. Probleme können auftreten.';

  @override
  String get settingsTemporaryFixesNoFixes => 'Keine Korrekturen verfügbar';

  @override
  String get settingsVoicePermissionLoading => 'Lade Sprachberechtigungen ...';

  @override
  String get settingsVoiceTtsNotSupported => 'Sprachausgabe nicht unterstützt';

  @override
  String get settingsVoiceTtsNotSupportedDescription =>
      'Sprachausgabedienste sind nicht für die ausgewählte Sprache verfügbar. Wähle eine andere Sprache im Sprachwähler, um diese wieder zu aktivieren.\nAndere Dienste, wie Spracherkennung und KI-Denken werden noch immer wie gewohnt funktionieren, doch die Interaktion könnte möglicherweise nicht gleich fließend sein.';

  @override
  String get settingsVoicePermissionNot => 'Berechtigungen nicht erteilt';

  @override
  String get settingsVoiceNotEnabled => 'Voice Mode nicht aktiviert';

  @override
  String get settingsVoiceNotSupported => 'Voice-Modus wird nicht unterstützt';

  @override
  String get settingsVoiceEnable => 'Voice-Modus aktivieren';

  @override
  String get settingsVoiceNoLanguage => 'Keine Sprache ausgewählt';

  @override
  String get settingsVoiceLimitLanguage => 'Auf gewählte Sprache beschränken';

  @override
  String get settingsVoicePunctuation => 'KI Satzzeichen aktivieren';

  @override
  String get settingsExportChats => 'Chats exportieren';

  @override
  String get settingsExportChatsSuccess => 'Chats erfolgreich exportiert';

  @override
  String get settingsImportChats => 'Chats importieren';

  @override
  String get settingsImportChatsTitle => 'Importieren';

  @override
  String get settingsImportChatsDescription =>
      'Der folgende Schritt importiert die Chats aus der ausgewählten Datei. Dadurch werden alle aktuell verfügbaren Chats überschrieben.\nMöchtest du fortfahren?';

  @override
  String get settingsImportChatsImport => 'Importieren und Löschen';

  @override
  String get settingsImportChatsCancel => 'Abbrechen';

  @override
  String get settingsImportChatsSuccess => 'Chats erfolgreich importiert';

  @override
  String get settingsExportInfo =>
      'Diese Optionen ermöglichen es dir, deinen Chat-Verlauf zu exportieren und zu importieren. Dies kann nützlich sein, wenn du deinen Chat-Verlauf auf ein anderes Gerät übertragen oder deinen Chat-Verlauf sichern möchtest';

  @override
  String get settingsExportWarning =>
      'Mehrere Chatverläufe werden nicht zusammengeführt! Du verlierst deinen aktuellen Chatverlauf, wenn du einen neuen importierst';

  @override
  String get settingsUpdateCheck => 'Nach Updates suchen';

  @override
  String get settingsUpdateChecking => 'Suchen nach Updates ...';

  @override
  String get settingsUpdateLatest => 'Du verwendest die neueste Version';

  @override
  String settingsUpdateAvailable(String version) {
    return 'Update verfügbar (v$version)';
  }

  @override
  String get settingsUpdateRateLimit => 'Kann nicht überprüfen, API-Limit';

  @override
  String get settingsUpdateIssue => 'Ein Problem ist aufgetreten';

  @override
  String get settingsUpdateDialogTitle => 'Neue Version verfügbar';

  @override
  String get settingsUpdateDialogDescription =>
      'Eine neue Version von Ollama ist verfügbar. Möchtest du sie jetzt herunterladen und installieren?';

  @override
  String get settingsUpdateChangeLog => 'Versionshinweise';

  @override
  String get settingsUpdateDialogUpdate => 'Aktualisieren';

  @override
  String get settingsUpdateDialogCancel => 'Abbrechen';

  @override
  String get settingsCheckForUpdates => 'Beim Öffnen nach Updates suchen';

  @override
  String get settingsGithub => 'GitHub';

  @override
  String get settingsReportIssue => 'Einen Fehler melden';

  @override
  String get settingsLicenses => 'Lizenzen';

  @override
  String settingsVersion(String version) {
    return 'Ollama App v$version';
  }
}
