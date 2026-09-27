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
  String get tip3 => 'Seleziona un modello multimodale per inserire le immagini';

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
  String get noHostSelected => 'Nessun host selezionato, apri le impostazioni per farlo';

  @override
  String get noSelectedModel => '<modelli>';

  @override
  String get newChatTitle => 'Chat senza nome';

  @override
  String get modelDialogAddModel => 'Aggiungi';

  @override
  String get modelDialogAddPromptTitle => 'Aggiungi nuovo modello';

  @override
  String get modelDialogAddPromptDescription => 'Questo può essere un nome normale (ad es. \'llama3\') o nome e tag (ad es. \'llama3:70b\').';

  @override
  String get modelDialogAddPromptAlreadyExists => 'Il modello esiste già';

  @override
  String get modelDialogAddPromptInvalid => 'Nome del modello non valido';

  @override
  String get modelDialogAddAllowanceTitle => 'Abilita Proxy';

  @override
  String get modelDialogAddAllowanceDescription => 'Ollama App deve controllare se il modello inserito è valido. Per questo, normalmente inviamo una richiesta web alla lista dei modelli Ollama e controlliamo il codice di stato, ma perché stai usando il web client, non possiamo farlo direttamente. Invece, l\'app invierà la richiesta a un altro api, ospitato da JHubi1, per eseguire il controllo.\nQuesta è una richiesta verrà inviata solo quando aggiungi un nuovo modello.\nIl tuo indirizzo IP verrà inviato con la richiesta e potrebbe essere memorizzato per un massimo di dieci minuti per evitare lo spamming con potenziali intenzioni nocive.\nSe accetti, la tua selezione sarà ricordata in futuro; in caso contrario, non verrà inviato nulla e il modello non verrà aggiunto.';

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
  String get modelDialogAddDownloadSuccess => 'Download completato con successo';

  @override
  String get deleteDialogTitle => 'Elimina Chat';

  @override
  String get deleteDialogDescription => 'Sei sicuro di voler continuare? Tale operazione cancellerà tutta questa chat e non potrà essere annullata.\nPer disattivare questa finestra di dialogo, vai alle impostazioni.';

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
  String get settingsDescriptionBehavior => 'Modifica il comportamento dell\'AI a tuo piacimento.';

  @override
  String get settingsTitleInterface => 'Interfaccia';

  @override
  String get settingsDescriptionInterface => 'Modifica l\'aspetto e il comportamento dell\'app Ollama.';

  @override
  String get settingsTitleVoice => 'Voce';

  @override
  String get settingsDescriptionVoice => 'Abilita la modalità vocale e configura le impostazioni vocali.';

  @override
  String get settingsTitleExport => 'Esporta';

  @override
  String get settingsDescriptionExport => 'Esporta e importa la cronologia delle tue chat.';

  @override
  String get settingsTitleAbout => 'Informazioni';

  @override
  String get settingsDescriptionAbout => 'Controlla gli aggiornamenti e scopri di più su Ollama App.';

  @override
  String get settingsSavedAutomatically => 'Le impostazioni vengono salvate automaticamente';

  @override
  String get settingsExperimentalAlpha => 'alpha';

  @override
  String get settingsExperimentalAlphaDescription => 'Questa funzionalità è in versione alpha e potrebbe non funzionare come previsto o previsto.\nNon si possono escludere problemi critici e/o danni critici permanenti al dispositivo e/o ai servizi utilizzati.\nL\'utilizzo è a proprio rischio. Nessuna responsabilità da parte dell\'autore dell\'app.';

  @override
  String get settingsExperimentalAlphaFeature => 'Funzione Alpha, tieni premuto per saperne di più';

  @override
  String get settingsExperimentalBeta => 'beta';

  @override
  String get settingsExperimentalBetaDescription => 'Questa funzionalità è in versione beta e potrebbe non funzionare come previsto o previsto.\nPotrebbero verificarsi o meno problemi meno gravi. I danni non dovrebbero essere critici.\nUtilizza a tuo rischio e pericolo.';

  @override
  String get settingsExperimentalBetaFeature => 'Funzione Beta, tieni premuto per saperne di più';

  @override
  String get settingsExperimentalDeprecated => 'deprecato';

  @override
  String get settingsExperimentalDeprecatedDescription => 'Questa funzionalità è deprecata e verrà rimossa in una versione futura.\nPotrebbe non funzionare come previsto o atteso. Usare a proprio rischio.';

  @override
  String get settingsExperimentalDeprecatedFeature => 'Funzionalità deprecata, tenere premuto per saperne di più';

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
        'auth': 'Autenticazione fallita',
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
  String get settingsHostHeaderInvalid => 'Il testo immesso non è un valido oggetto JSON';

  @override
  String settingsHostInvalidDetailed(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': 'L\'URL inserito non è valido. Usa un URL completo che inizi con http:// o https:// — ad esempio http://localhost:11434 per un server Ollama locale, oppure https://ollama.com per Ollama Cloud. Non aggiungere una barra finale né un percorso /api.',
        'host': 'L\'host inserito non è valido. Non può essere raggiunto. Controlla l\'host e riprova.',
        'auth': 'Il server ha rifiutato la richiesta (401/403). Se ti connetti a Ollama Cloud (https://ollama.com), inserisci la tua chiave API nel campo token qui sotto — puoi crearla o copiarla su https://ollama.com/keys — e salva. Se usi un server self-hosted, controlla l\'header Authorization configurato per l\'host.',
        'other': 'L\'host inserito non è valido. Non può essere raggiunto. Controlla l\'host e riprova.',
      },
    );
    return '$_temp0';
  }

  @override
  String get settingsApiTokenInvalid => 'Token API rifiutato';

  @override
  String get settingsApiTokenInvalidDetailed => 'Il token API è stato rifiutato dal server (401/403). Verifica che sia copiato esattamente come mostrato su https://ollama.com/keys — su quella pagina puoi creare una nuova chiave — e salva di nuovo. Il token deve essere impostato mentre l\'host è https://ollama.com.';

  @override
  String get settingsApiTokenVerified => 'Token API salvato e verificato';

  @override
  String get settingsApiToken => 'Token API di Ollama Cloud';

  @override
  String get settingsApiTokenHint => 'Incolla il token da ollama.com';

  @override
  String get tooltipShowToken => 'Mostra token';

  @override
  String get tooltipHideToken => 'Nascondi token';

  @override
  String voiceLanguageInstruction(String language) {
    return 'Devi scrivere nella seguente lingua: $language!';
  }

  @override
  String get settingsSystemMessage => 'Messaggio di sistema';

  @override
  String get settingsUseSystem => 'Usa Messaggio di sistema';

  @override
  String get settingsUseSystemDescription => 'Disabilita l\'impostazione del messaggio di sistema sopra e utilizza invece quello del modello. Può essere utile per i modelli con file di modello';

  @override
  String get settingsDisableMarkdown => 'Disabilita markdown';

  @override
  String get settingsBehaviorNotUpdatedForOlderChats => 'Le impostazioni sul comportamento non vengono aggiornate per le chat meno recenti';

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
  String get settingsKeepModelLoadedAlways => 'Mantieni modello sempre caricato';

  @override
  String get settingsKeepModelLoadedNever => 'Non mantenere modello sempre caricato';

  @override
  String get settingsKeepModelLoadedFor => 'Imposta un tempo specifico per mantenere il modello caricato';

  @override
  String settingsKeepModelLoadedSet(String minutes) {
    return 'Mantieni modello caricato per $minutes minuti';
  }

  @override
  String get settingsTimeoutMultiplier => 'Moltiplicatore di timeout';

  @override
  String get settingsTimeoutMultiplierDescription => 'Seleziona il moltiplicatore che viene applicato a ogni valore di timeout nell\'applicazione. Può essere utile con una connessione internet lenta o un host lento.';

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
  String get settingsTemporaryFixes => 'Aggiustamenti temporanei dell\'interfaccia';

  @override
  String get settingsTemporaryFixesDescription => 'Abilita correzioni temporanee per problemi dell\'interfaccia.\nPremi a lungo sulle opzioni individuali per saperne di più.';

  @override
  String get settingsTemporaryFixesInstructions => 'Non attivare nessuna di queste impostazioni a meno che tu non sappia cosa stai facendo! Le soluzioni fornite potrebbero non funzionare come previsto. \nNon possono essere considerate definitive o giudicate come tali. Potrebbero verificarsi problemi.';

  @override
  String get settingsTemporaryFixesNoFixes => 'Nessuna correzione disponibile';

  @override
  String get settingsVoicePermissionLoading => 'Caricamento permessi voce ...';

  @override
  String get settingsVoiceTtsNotSupported => 'Text-to-speech non supportato';

  @override
  String get settingsVoiceTtsNotSupportedDescription => 'I servizi di text-to-speech non sono supportati per la lingua selezionata. Seleziona una lingua diversa nel menu a discesa delle lingue per riattivarli.\nAltri servizi come il riconoscimento vocale e il pensiero dell\'IA funzioneranno comunque normalmente, ma l\'interazione potrebbe non essere fluida.';

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
  String get settingsImportChatsDescription => 'Il passaggio successivo importerà le chat dal file selezionato. Ciò sovrascriverà tutte le chat attualmente disponibili.\nVuoi continuare?';

  @override
  String get settingsImportChatsImport => 'Importa e cancella';

  @override
  String get settingsImportChatsCancel => 'Annulla';

  @override
  String get settingsImportChatsSuccess => 'Chats importate con successo';

  @override
  String get settingsExportInfo => 'Questa opzione ti consente di esportare e importare la cronologia chat. Questo può essere utile se desideri trasferire la cronologia chat su un altro dispositivo o eseguire il backup della cronologia chat';

  @override
  String get settingsExportWarning => 'Più cronologie di chat non verranno unite! Perderai la cronologia chat attuale se ne importi una nuova';

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
  String get settingsUpdateRateLimit => 'Impossibile verificare, limite di accesso API superato';

  @override
  String get settingsUpdateIssue => 'Si è verificato un errore';

  @override
  String get settingsUpdateDialogTitle => 'Nuova versione disponibile';

  @override
  String get settingsUpdateDialogDescription => 'È disponibile una nuova versione di Ollama. Vuoi scaricarla e installarla adesso?';

  @override
  String get settingsUpdateChangeLog => 'Cambiamenti';

  @override
  String get settingsUpdateDialogUpdate => 'Aggiorna';

  @override
  String get settingsUpdateDialogCancel => 'Annulla';

  @override
  String get settingsCheckForUpdates => 'Controlla gli aggiornamenti all\'apertura';

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

  @override
  String get settingsTitleAccessibility => 'Accessibilità';

  @override
  String get settingsDescriptionAccessibility => 'Dichiarazione di accessibilità, risultati dei test e come segnalare un problema.';

  @override
  String get accessibilityStatementTitle => 'Dichiarazione di accessibilità';

  @override
  String get accessibilityCommitmentIntro => 'Ollama deve essere utilizzabile da persone con ogni tipo di abilità, in tutte le lingue che forniamo. Controllo vocale, screen reader, navigazione da tastiera e resa a contrasto elevato sono modi principali di utilizzare questa app — non un ripensamento.';

  @override
  String get accessibilityCommitmentDetails => 'In pratica questo significa: ogni controllo interattivo ha un nome annunciato dagli screen reader (incluso lo stato della modalità vocale), i pulsanti mantengono un\'area minima toccabile di 48dp, il focus da tastiera segue l\'ordine visivo dell\'interfaccia, i messaggi di stato vengono annunciati mentre cambiano, e l\'interfaccia rimane utilizzabile con testo ingrandito e nei temi sia chiaro che scuro.';

  @override
  String get accessibilityConformanceTitle => 'Stato di conformità';

  @override
  String get accessibilityConformanceStatus => 'Questa app è progettata per essere conforme alle Web Content Accessibility Guidelines (WCAG) 2.2 Level AA. La conformità non è stata certificata in modo indipendente da terzi; si basa sulle nostre stesse verifiche automatizzate. Ove possibile andiamo oltre AA e applichiamo misure WCAG AAA, elencate di seguito.';

  @override
  String get accessibilityAaaMeasuresTitle => 'Oltre AA (misure AAA)';

  @override
  String get accessibilityAaaMeasures => 'Il testo principale utilizza un contrasto di 21:1 in entrambi i temi (AAA richiede 7:1), il testo secondario attenuato utilizza 10:1 o meglio, i colori di stato per successi e avvisi rispettano il contrasto AAA in entrambi i temi, e il testo di errore nel tema scuro rispetta il contrasto AAA. AAA richiede inoltre misure non praticabili in un\'applicazione di chat di queste dimensioni (ad esempio contrasto 7:1 su assolutamente tutto il testo e limiti di livello di lettura), quindi puntiamo ad AA come garanzia e trattiamo queste misure AAA come miglioramenti.';

  @override
  String get accessibilityAodaTitle => 'Accessibility for Ontarians with Disabilities Act (AODA)';

  @override
  String get accessibilityAodaText => 'L\'Accessibility for Ontarians with Disabilities Act (AODA) dell\'Ontario richiede che i prodotti digitali rispettino WCAG 2.0/2.1 Level AA. L\'obiettivo WCAG 2.2 Level AA di questa app raggiunge e supera tale livello minimo. I feedback sull\'accessibilità sono benvenuti tramite il modulo di contatto in questa pagina, in linea con il requisito dell\'AODA di rendere accessibili i canali di feedback.';

  @override
  String get accessibilityStandardsEuropeTitle => 'Standard europei (EN 301 549)';

  @override
  String get accessibilityStandardsEuropeText => 'Nell\'Unione Europea, lo standard armonizzato EN 301 549 definisce i requisiti di accessibilità ICT dell\'European Accessibility Act, che fa riferimento a WCAG 2.1 Level AA. L\'obiettivo WCAG 2.2 Level AA di questa app copre tali requisiti, supportando gli obblighi europei di accessibilità applicabili dal 28 giugno 2025.';

  @override
  String get accessibilityStandardsUsTitle => 'Standard degli Stati Uniti (ADA / Section 508)';

  @override
  String get accessibilityStandardsUsText => 'Negli Stati Uniti, l\'Americans with Disabilities Act (ADA) è il livello minimo generale di non discriminazione, e la Section 508 del Rehabilitation Act richiede WCAG 2.0 Level AA per la tecnologia federale (la Section 504 estende obblighi simili ai programmi finanziati). L\'obiettivo WCAG 2.2 Level AA di questa app raggiunge e supera tali livelli minimi.';

  @override
  String get accessibilityKnownIssuesTitle => 'Limitazioni note';

  @override
  String get accessibilityKnownIssues => 'I pulsanti della barra del titolo della finestra desktop (riduci a icona, ingrandisci, chiudi) sono forniti dall\'integrazione con il sistema operativo e non sono raggiungibili dall\'albero degli screen reader dell\'app. La libreria delle chat renderizza una piccola parte del proprio testo di interfaccia, che potrebbe non essere ancora disponibile in tutte le lingue. In modalità vocale, il testo della risposta è sfumato vicino al bordo dello schermo e le righe di chat molto lunghe possono essere troncate con dei puntini di sospensione quando la dimensione del testo di sistema viene aumentata in modo significativo.';

  @override
  String accessibilityLastValidated(String version) {
    return 'Verifiche automatizzate convalidate l\'ultima volta contro Ollama App v$version.';
  }

  @override
  String get accessibilityTestsTitle => 'Risultati dei test';

  @override
  String get accessibilityTestsIntro => 'Le seguenti verifiche di accessibilità automatizzate fanno parte della suite di test di questa app e vengono eseguite a ogni commit:';

  @override
  String get accessibilityTestsCheckColumn => 'Verifica';

  @override
  String get accessibilityTestsStatusColumn => 'Stato';

  @override
  String get accessibilityTestsPass => 'Superato';

  @override
  String get accessibilityTestsCiNote => 'La suite completa (analisi statica più test automatizzati) viene eseguita a ogni commit nella pipeline di integrazione continua.';

  @override
  String get accessibilityTestContrast => 'Il contrasto del testo rispetta i livelli WCAG nei temi chiaro e scuro';

  @override
  String get accessibilityTestLabeledTapTarget => 'Le destinazioni toccabili hanno etichette per screen reader';

  @override
  String get accessibilityTestAndroidTapTarget => 'Le aree di tocco sono di almeno 48x48dp (linea guida Android)';

  @override
  String get accessibilityTestIosTapTarget => 'Le aree di tocco sono di almeno 44x44dp (linea guida iOS)';

  @override
  String get accessibilityTestSemanticsPresent => 'Esistono etichette per screen reader per tutti i controlli personalizzati';

  @override
  String get accessibilityTestTraversalOrder => 'L\'ordine di focus da tastiera segue l\'ordine visivo';

  @override
  String get accessibilityTestLocalesRender => 'Tutte le lingue dell\'interfaccia vengono renderizzate senza errori';

  @override
  String get accessibilityTestFormValidation => 'I campi dei moduli annunciano gli errori di convalida';

  @override
  String get accessibilityContactTitle => 'Segnala un problema di accessibilità';

  @override
  String get accessibilityContactIntro => 'Usa questo modulo per richiedere informazioni sull\'accessibilità, chiedere una risoluzione o segnalare una barriera di accessibilità. La tua segnalazione viene composta in un messaggio che puoi inviare per email o come issue pubblica su GitHub.';

  @override
  String get accessibilityFormName => 'Nome (facoltativo)';

  @override
  String get accessibilityFormEmail => 'Email (facoltativa)';

  @override
  String get accessibilityFormAssistiveTech => 'Tecnologia assistiva utilizzata (facoltativa)';

  @override
  String get accessibilityFormDescription => 'Descrivi il problema (obbligatorio)';

  @override
  String get accessibilityFormDescriptionHint => 'Cosa stavi tentando di fare e cosa ti ha ostacolato?';

  @override
  String get accessibilityFormErrorDescription => 'Descrivi il problema prima di inviare.';

  @override
  String get accessibilityFormErrorEmail => 'Inserisci un indirizzo email valido o lascia il campo vuoto.';

  @override
  String get accessibilityFormSendEmail => 'Invia per email';

  @override
  String get accessibilityFormSendGithub => 'Apri una issue su GitHub';

  @override
  String get accessibilityFormEmailSubject => 'Segnalazione di accessibilità (Ollama App)';

  @override
  String get accessibilityFormCopiedFallback => 'Impossibile aprire il collegamento. La segnalazione è stata copiata negli appunti.';

  @override
  String get tooltipResetChat => 'Reimposta la chat corrente';

  @override
  String get tooltipVoiceClose => 'Chiudi la modalità vocale';

  @override
  String get tooltipVoiceSettings => 'Apri le impostazioni vocali';

  @override
  String get tooltipVoiceScrollToEnd => 'Scorri fino all\'ultimo testo';

  @override
  String get tooltipWelcomeNext => 'Pagina successiva';

  @override
  String get tooltipWelcomeFinish => 'Inizia a usare Ollama';

  @override
  String get accessibilityVoiceOrbListening => 'La modalità vocale sta ascoltando. Tocca per interrompere l\'ascolto.';

  @override
  String get accessibilityVoiceOrbSpeaking => 'La risposta viene letta ad alta voce. Tocca per interrompere.';

  @override
  String get accessibilityVoiceOrbThinking => 'L\'IA sta preparando una risposta. Tocca per annullare.';

  @override
  String get accessibilityAppLogo => 'Ollama';

  @override
  String get accessibilityWelcomePage1 => 'Benvenuto in Ollama. Questo onboarding mostra tre brevi immagini.';

  @override
  String get accessibilityWelcomePage2 => 'Pagina di onboarding 2 di 3. L\'immagine mostra come selezionare un modello e iniziare a chattare.';

  @override
  String get accessibilityWelcomePage3 => 'Pagina di onboarding 3 di 3. L\'immagine mostra dove trovare le impostazioni e la modalità vocale.';

  @override
  String get accessibilitySummaryConformance => 'Questa app punta a WCAG 2.2 Livello AA e applica miglioramenti di livello AAA. Alcune funzionalità presentano limitazioni, descritte all\'interno di ciascuna sezione.';

  @override
  String get accessibilitySectionStatementSummary => 'Il nostro impegno, lo stato di conformità e le misure che applichiamo oltre il livello AA.';

  @override
  String get accessibilitySectionTestsSummary => '8 verifiche di accessibilità automatizzate superate a ogni build.';

  @override
  String get accessibilitySectionStandardsSummary => 'Come supportiamo AODA, lo standard europeo EN 301 549 e ADA statunitense / Section 508.';

  @override
  String get accessibilitySectionContactSummary => 'Segnala un problema di accessibilità via email o GitHub. Rispondiamo a tutte le segnalazioni.';

  @override
  String get accessibilitySupportLevelLimited => 'Supporto limitato';

  @override
  String get accessibilitySupportLevelCompliantWithLimitations => 'Conforme con limitazioni';
}
