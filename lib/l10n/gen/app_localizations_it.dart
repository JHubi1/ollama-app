// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Ollama';

  @override
  String get optionNewChat => 'Nuova Chat';

  @override
  String get optionSettings => 'Impostazioni';

  @override
  String get optionInstallPwa => 'Installa Webapp';

  @override
  String get optionNoChatFound => 'Nessuna Chat trovata';

  @override
  String get tipPrefix => 'Suggerimento: ';

  @override
  String get tip0 => 'Modifica il messaggio tenendo premuto su di esso';

  @override
  String get tip1 => 'Elimina il messaggio premendo due volte su di esso';

  @override
  String get tip2 => 'Puoi cambiare il tema dalle impostazioni';

  @override
  String get tip3 =>
      'Seleziona un modello multimodale per inserire le immagini';

  @override
  String get tip4 => 'Le chat sono state automaticamente salvate';

  @override
  String get deleteChat => 'Elimina';

  @override
  String get renameChat => 'Rinomina';

  @override
  String get takeImage => 'Seleziona immagine';

  @override
  String get uploadImage => 'Carica immagine';

  @override
  String get notAValidImage => 'Immagine non valida';

  @override
  String get imageOnlyConversation => 'Conversazione di sole immagini';

  @override
  String get messageInputPlaceholder => 'Messaggio';

  @override
  String get tooltipAttachment => 'Aggiungi allegato';

  @override
  String get tooltipSend => 'Invia';

  @override
  String get tooltipSave => 'Salva';

  @override
  String get tooltipLetAIThink => 'Lasciamo che sia IA a pensare';

  @override
  String get tooltipAddHostHeaders => 'Aggiungi host headers';

  @override
  String get tooltipReset => 'Reimposta la chat corrente';

  @override
  String get tooltipOptions => 'Mostra opzioni';

  @override
  String get noModelSelected => 'Nessun modello selezionato';

  @override
  String get noHostSelected =>
      'Nessun host selezionato, apri le impostazioni per farlo';

  @override
  String get noSelectedModel => '<modelli>';

  @override
  String get newChatTitle => 'Chat senza nome';

  @override
  String get modelDialogAddModel => 'Aggiungi';

  @override
  String get modelDialogAddPromptTitle => 'Aggiungi nuovo modello';

  @override
  String get modelDialogAddPromptDescription =>
      'Questo può essere un nome normale (ad es. \'llama3\') o nome e tag (ad es. \'llama3:70b\').';

  @override
  String get modelDialogAddPromptAlreadyExists => 'Il modello esiste già';

  @override
  String get modelDialogAddPromptInvalid => 'Nome del modello non valido';

  @override
  String get modelDialogAddAllowanceTitle => 'Abilita Proxy';

  @override
  String get modelDialogAddAllowanceDescription =>
      'Ollama App deve controllare se il modello inserito è valido. Per questo, normalmente inviamo una richiesta web alla lista dei modelli Ollama e controlliamo il codice di stato, ma perché stai usando il web client, non possiamo farlo direttamente. Invece, l\'app invierà la richiesta a un altro api, ospitato da JHubi1, per eseguire il controllo.\nQuesta è una richiesta verrà inviata solo quando aggiungi un nuovo modello.\nIl tuo indirizzo IP verrà inviato con la richiesta e potrebbe essere memorizzato per un massimo di dieci minuti per evitare lo spamming con potenziali intenzioni nocive.\nSe accetti, la tua selezione sarà ricordata in futuro; in caso contrario, non verrà inviato nulla e il modello non verrà aggiunto.';

  @override
  String get modelDialogAddAllowanceAllow => 'Consenti';

  @override
  String get modelDialogAddAllowanceDeny => 'Nega';

  @override
  String modelDialogAddAssuranceTitle(String model) {
    return 'Aggiungi $model?';
  }

  @override
  String modelDialogAddAssuranceDescription(String model) {
    return 'Premendo \'Aggiungi\' scaricherà il modello \'$model\' direttamente dal server Ollama al tuo host.\nQuesto può richiedere un po\' di tempo a seconda della tua connessione internet. L\'azione non può essere annullata.\nSe l\'app è chiusa durante il download, riprenderà se inserisci di nuovo il nome nella finestra del modello.';
  }

  @override
  String get modelDialogAddAssuranceAdd => 'Aggiungi';

  @override
  String get modelDialogAddAssuranceCancel => 'Annulla';

  @override
  String get modelDialogAddDownloadPercentLoading => 'Caricamento in corso';

  @override
  String modelDialogAddDownloadPercent(String percent) {
    return 'scarica al $percent%';
  }

  @override
  String get modelDialogAddDownloadFailed => 'Disconnesso, riprova';

  @override
  String get modelDialogAddDownloadSuccess =>
      'Download completato con successo';

  @override
  String get deleteDialogTitle => 'Elimina Chat';

  @override
  String get deleteDialogDescription =>
      'Sei sicuro di voler continuare? Tale operazione cancellerà tutta questa chat e non potrà essere annullata.\nPer disattivare questa finestra di dialogo, vai alle impostazioni.';

  @override
  String get deleteDialogDelete => 'Elimina';

  @override
  String get deleteDialogCancel => 'Annulla';

  @override
  String get dialogEnterNewTitle => 'Immetti nuovo titolo';

  @override
  String get dialogEditMessageTitle => 'Modifica Messaggio';

  @override
  String get settingsTitleBehavior => 'Comportamento';

  @override
  String get settingsDescriptionBehavior =>
      'Modifica il comportamento dell\'AI a tuo piacimento.';

  @override
  String get settingsTitleInterface => 'Interfaccia';

  @override
  String get settingsDescriptionInterface =>
      'Modifica l\'aspetto e il comportamento dell\'app Ollama.';

  @override
  String get settingsTitleVoice => 'Voce';

  @override
  String get settingsDescriptionVoice =>
      'Abilita la modalità vocale e configura le impostazioni vocali.';

  @override
  String get settingsTitleExport => 'Esporta';

  @override
  String get settingsDescriptionExport =>
      'Esporta e importa la cronologia delle tue chat.';

  @override
  String get settingsTitleAbout => 'Informazioni';

  @override
  String get settingsDescriptionAbout =>
      'Controlla gli aggiornamenti e scopri di più su Ollama App.';

  @override
  String get settingsSavedAutomatically =>
      'Le impostazioni vengono salvate automaticamente';

  @override
  String get settingsExperimentalAlpha => 'alpha';

  @override
  String get settingsExperimentalAlphaDescription =>
      'Questa funzionalità è in versione alpha e potrebbe non funzionare come previsto o previsto.\nNon si possono escludere problemi critici e/o danni critici permanenti al dispositivo e/o ai servizi utilizzati.\nL\'utilizzo è a proprio rischio. Nessuna responsabilità da parte dell\'autore dell\'app.';

  @override
  String get settingsExperimentalAlphaFeature =>
      'Funzione Alpha, tieni premuto per saperne di più';

  @override
  String get settingsExperimentalBeta => 'beta';

  @override
  String get settingsExperimentalBetaDescription =>
      'Questa funzionalità è in versione beta e potrebbe non funzionare come previsto o previsto.\nPotrebbero verificarsi o meno problemi meno gravi. I danni non dovrebbero essere critici.\nUtilizza a tuo rischio e pericolo.';

  @override
  String get settingsExperimentalBetaFeature =>
      'Funzione Beta, tieni premuto per saperne di più';

  @override
  String get settingsExperimentalDeprecated => 'deprecato';

  @override
  String get settingsExperimentalDeprecatedDescription =>
      'Questa funzionalità è deprecata e verrà rimossa in una versione futura.\nPotrebbe non funzionare come previsto o atteso. Usare a proprio rischio.';

  @override
  String get settingsExperimentalDeprecatedFeature =>
      'Funzionalità deprecata, tenere premuto per saperne di più';

  @override
  String get settingsHost => 'Host';

  @override
  String get settingsHostValid => 'Host valido';

  @override
  String get settingsHostChecking => 'Controllo Host';

  @override
  String settingsHostInvalid(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': 'URL invalido',
        'host': 'Host invalido',
        'timeout': 'Richiesta fallita. Problema col server',
        'ratelimit': 'Troppe richieste',
        'other': 'Richiesta fallita',
      },
    );
    return 'Problema: $_temp0';
  }

  @override
  String get settingsHostHeaderTitle => 'Imposta header host';

  @override
  String get settingsHostHeaderInvalid =>
      'Il testo immesso non è un valido oggetto JSON';

  @override
  String settingsHostInvalidDetailed(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url':
            'L\'URL inserito non è valido. Non è un formato URL standardizzato.',
        'other':
            'L\'host inserito non è valido. Non può essere raggiunto. Controlla l\'host e riprova.',
      },
    );
    return '$_temp0';
  }

  @override
  String get settingsSystemMessage => 'Messaggio di sistema';

  @override
  String get settingsUseSystem => 'Usa Messaggio di sistema';

  @override
  String get settingsUseSystemDescription =>
      'Disabilita l\'impostazione del messaggio di sistema sopra e utilizza invece quello del modello. Può essere utile per i modelli con file di modello';

  @override
  String get settingsDisableMarkdown => 'Disabilita markdown';

  @override
  String get settingsBehaviorNotUpdatedForOlderChats =>
      'Le impostazioni sul comportamento non vengono aggiornate per le chat meno recenti';

  @override
  String get settingsShowModelTags => 'Visualizza tags modello';

  @override
  String get settingsPreloadModels => 'Precarica modello';

  @override
  String get settingsResetOnModelChange => 'Reimposta al cambio modello';

  @override
  String get settingsRequestTypeStream => 'Stream';

  @override
  String get settingsRequestTypeRequest => 'Request';

  @override
  String get settingsGenerateTitles => 'Genera titoli';

  @override
  String get settingsEnableEditing => 'Abilita modifica di messaggi';

  @override
  String get settingsAskBeforeDelete => 'Chiedi prima di eliminare la chat';

  @override
  String get settingsShowTips => 'Mostra suggerimenti nella barra laterale';

  @override
  String get settingsKeepModelLoadedAlways =>
      'Mantieni modello sempre caricato';

  @override
  String get settingsKeepModelLoadedNever =>
      'Non mantenere modello sempre caricato';

  @override
  String get settingsKeepModelLoadedFor =>
      'Imposta un tempo specifico per mantenere il modello caricato';

  @override
  String settingsKeepModelLoadedSet(String minutes) {
    return 'Mantieni modello caricato per $minutes minuti';
  }

  @override
  String get settingsTimeoutMultiplier => 'Moltiplicatore di timeout';

  @override
  String get settingsTimeoutMultiplierDescription =>
      'Seleziona il moltiplicatore che viene applicato a ogni valore di timeout nell\'applicazione. Può essere utile con una connessione internet lenta o un host lento.';

  @override
  String get settingsTimeoutMultiplierExample => 'Es. messaggio di timeout:';

  @override
  String get settingsEnableHapticFeedback => 'Abilita il feedback tattile';

  @override
  String get settingsMaximizeOnStart => 'Inizzia massimizzato';

  @override
  String get settingsBrightnessSystem => 'Sistema';

  @override
  String get settingsBrightnessLight => 'Chiaro';

  @override
  String get settingsBrightnessDark => 'Scuro';

  @override
  String get settingsThemeDevice => 'Dispositivo';

  @override
  String get settingsThemeOllama => 'Ollama';

  @override
  String get settingsTemporaryFixes =>
      'Aggiustamenti temporanei dell\'interfaccia';

  @override
  String get settingsTemporaryFixesDescription =>
      'Abilita correzioni temporanee per problemi dell\'interfaccia.\nPremi a lungo sulle opzioni individuali per saperne di più.';

  @override
  String get settingsTemporaryFixesInstructions =>
      'Non attivare nessuna di queste impostazioni a meno che tu non sappia cosa stai facendo! Le soluzioni fornite potrebbero non funzionare come previsto. \nNon possono essere considerate definitive o giudicate come tali. Potrebbero verificarsi problemi.';

  @override
  String get settingsTemporaryFixesNoFixes => 'Nessuna correzione disponibile';

  @override
  String get settingsVoicePermissionLoading => 'Caricamento permessi voce ...';

  @override
  String get settingsVoiceTtsNotSupported => 'Text-to-speech non supportato';

  @override
  String get settingsVoiceTtsNotSupportedDescription =>
      'I servizi di text-to-speech non sono supportati per la lingua selezionata. Seleziona una lingua diversa nel menu a discesa delle lingue per riattivarli.\nAltri servizi come il riconoscimento vocale e il pensiero dell\'IA funzioneranno comunque normalmente, ma l\'interazione potrebbe non essere fluida.';

  @override
  String get settingsVoicePermissionNot => 'Permessi non concessi';

  @override
  String get settingsVoiceNotEnabled => 'Modalità vocale non abilitata';

  @override
  String get settingsVoiceNotSupported => 'Modalità vocale non supportata';

  @override
  String get settingsVoiceEnable => 'Abilita modalità vocale';

  @override
  String get settingsVoiceNoLanguage => 'Nessuna lingua selezionata';

  @override
  String get settingsVoiceLimitLanguage => 'Limita alla lingua selezionata';

  @override
  String get settingsVoicePunctuation => 'Abilita la punteggiatura AI';

  @override
  String get settingsExportChats => 'Esporta chats';

  @override
  String get settingsExportChatsSuccess => 'Chat esportate con successo';

  @override
  String get settingsImportChats => 'Importa chats';

  @override
  String get settingsImportChatsTitle => 'Importa';

  @override
  String get settingsImportChatsDescription =>
      'Il passaggio successivo importerà le chat dal file selezionato. Ciò sovrascriverà tutte le chat attualmente disponibili.\nVuoi continuare?';

  @override
  String get settingsImportChatsImport => 'Importa e cancella';

  @override
  String get settingsImportChatsCancel => 'Annulla';

  @override
  String get settingsImportChatsSuccess => 'Chats importate con successo';

  @override
  String get settingsExportInfo =>
      'Questa opzione ti consente di esportare e importare la cronologia chat. Questo può essere utile se desideri trasferire la cronologia chat su un altro dispositivo o eseguire il backup della cronologia chat';

  @override
  String get settingsExportWarning =>
      'Più cronologie di chat non verranno unite! Perderai la cronologia chat attuale se ne importi una nuova';

  @override
  String get settingsUpdateCheck => 'Controlla aggiornamenti';

  @override
  String get settingsUpdateChecking => 'Sto cercando aggiornamenti ...';

  @override
  String get settingsUpdateLatest => 'Hai l\'ultima versione';

  @override
  String settingsUpdateAvailable(String version) {
    return 'Aggiornamento disponibile (v$version)';
  }

  @override
  String get settingsUpdateRateLimit =>
      'Impossibile verificare, limite di accesso API superato';

  @override
  String get settingsUpdateIssue => 'Si è verificato un errore';

  @override
  String get settingsUpdateDialogTitle => 'Nuova versione disponibile';

  @override
  String get settingsUpdateDialogDescription =>
      'È disponibile una nuova versione di Ollama. Vuoi scaricarla e installarla adesso?';

  @override
  String get settingsUpdateChangeLog => 'Cambiamenti';

  @override
  String get settingsUpdateDialogUpdate => 'Aggiorna';

  @override
  String get settingsUpdateDialogCancel => 'Annulla';

  @override
  String get settingsCheckForUpdates =>
      'Controlla gli aggiornamenti all\'apertura';

  @override
  String get settingsGithub => 'GitHub';

  @override
  String get settingsReportIssue => 'Riporta problema';

  @override
  String get settingsLicenses => 'Licenze';

  @override
  String settingsVersion(String version) {
    return 'Ollama App v$version';
  }
}
