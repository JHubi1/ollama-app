// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Ollama';

  @override
  String get optionNewChat => 'Nuevo chat';

  @override
  String get optionSettings => 'Configuración';

  @override
  String get optionInstallPwa => 'Instalar aplicación web';

  @override
  String get optionNoChatFound => 'No se encontraron chats';

  @override
  String get tipPrefix => 'Consejo: ';

  @override
  String get tip0 => 'Edite los mensajes manteniéndolos presionados';

  @override
  String get tip1 => 'Elimine los mensajes tocándolos dos veces';

  @override
  String get tip2 => 'Puede cambiar el tema en la configuración';

  @override
  String get tip3 => 'Seleccione un modelo multimodal para ingresar imágenes';

  @override
  String get tip4 => 'Los chats se guardan automáticamente';

  @override
  String get deleteChat => 'Eliminar';

  @override
  String get renameChat => 'Renombrar';

  @override
  String get takeImage => 'Tomar imagen';

  @override
  String get uploadImage => 'Subir imagen';

  @override
  String get notAValidImage => 'No es una imagen válida';

  @override
  String get imageOnlyConversation => 'Conversación solo de imágenes';

  @override
  String get messageInputPlaceholder => 'Mensaje';

  @override
  String get tooltipAttachment => 'Agregar adjunto';

  @override
  String get tooltipSend => 'Enviar';

  @override
  String get tooltipSave => 'Guardar';

  @override
  String get tooltipLetAIThink => 'Dejar pensar a la IA';

  @override
  String get tooltipAddHostHeaders => 'Agregar encabezados del host';

  @override
  String get tooltipReset => 'Restablecer el chat actual';

  @override
  String get tooltipOptions => 'Mostrar opciones';

  @override
  String get noModelSelected => 'No hay ningún modelo seleccionado';

  @override
  String get noHostSelected => 'No hay ningún host seleccionado; abra la configuración para definir uno';

  @override
  String get noSelectedModel => '<selector>';

  @override
  String get newChatTitle => 'Chat sin nombre';

  @override
  String get modelDialogAddModel => 'Agregar';

  @override
  String get modelDialogAddPromptTitle => 'Agregar nuevo modelo';

  @override
  String get modelDialogAddPromptDescription => 'Esto puede ser un nombre normal (p. ej. \'llama3\') o un nombre con etiqueta (p. ej. \'llama3:70b\').';

  @override
  String get modelDialogAddPromptAlreadyExists => 'El modelo ya existe';

  @override
  String get modelDialogAddPromptInvalid => 'Nombre de modelo no válido';

  @override
  String get modelDialogAddAllowanceTitle => 'Permitir proxy';

  @override
  String get modelDialogAddAllowanceDescription => 'Ollama App debe comprobar si el modelo ingresado es válido. Para ello, normalmente enviamos una solicitud web a la lista de modelos de Ollama y comprobamos el código de estado, pero como está usando el cliente web, no podemos hacerlo directamente. En su lugar, la app enviará la solicitud a otra API, alojada por JHubi1, para comprobarlo por nosotros.\nEsta es una solicitud única y solo se enviará cuando agregue un nuevo modelo.\nSu dirección IP se enviará con la solicitud y podría almacenarse hasta por diez minutos para evitar el envío de spam con intenciones potencialmente dañinas.\nSi acepta, su selección se recordará en el futuro; si no, no se enviará nada y el modelo no se agregará.';

  @override
  String get modelDialogAddAllowanceAllow => 'Permitir';

  @override
  String get modelDialogAddAllowanceDeny => 'Denegar';

  @override
  String modelDialogAddAssuranceTitle(String model) {
    return '¿Agregar $model?';
  }

  @override
  String modelDialogAddAssuranceDescription(String model) {
    return 'Al presionar \'Agregar\' se descargará el modelo \'$model\' directamente desde el servidor de Ollama a su host.\nEsto puede tardar un tiempo según su conexión a internet. La acción no se puede cancelar.\nSi la app se cierra durante la descarga, se reanudará si vuelve a ingresar el nombre en el diálogo de modelos.';
  }

  @override
  String get modelDialogAddAssuranceAdd => 'Agregar';

  @override
  String get modelDialogAddAssuranceCancel => 'Cancelar';

  @override
  String get modelDialogAddDownloadPercentLoading => 'cargando progreso';

  @override
  String modelDialogAddDownloadPercent(String percent) {
    return 'descarga al $percent%';
  }

  @override
  String get modelDialogAddDownloadFailed => 'Desconectado, inténtelo de nuevo';

  @override
  String get modelDialogAddDownloadSuccess => 'Descarga exitosa';

  @override
  String get deleteDialogTitle => 'Eliminar chat';

  @override
  String get deleteDialogDescription => '¿Está seguro de que desea continuar? Esto borrará toda la memoria de este chat y no se puede deshacer.\nPara desactivar este diálogo, visite la configuración.';

  @override
  String get deleteDialogDelete => 'Eliminar';

  @override
  String get deleteDialogCancel => 'Cancelar';

  @override
  String get dialogEnterNewTitle => 'Ingrese el nuevo título';

  @override
  String get dialogEditMessageTitle => 'Editar mensaje';

  @override
  String get settingsTitleBehavior => 'Comportamiento';

  @override
  String get settingsDescriptionBehavior => 'Cambie el comportamiento de la IA a su gusto.';

  @override
  String get settingsTitleInterface => 'Interfaz';

  @override
  String get settingsDescriptionInterface => 'Edite la apariencia y el comportamiento de Ollama App.';

  @override
  String get settingsTitleVoice => 'Voz';

  @override
  String get settingsDescriptionVoice => 'Active el modo de voz y configure los ajustes de voz.';

  @override
  String get settingsTitleExport => 'Exportar';

  @override
  String get settingsDescriptionExport => 'Exporte e importe su historial de chats.';

  @override
  String get settingsTitleAbout => 'Acerca de';

  @override
  String get settingsDescriptionAbout => 'Busque actualizaciones y obtenga más información sobre Ollama App.';

  @override
  String get settingsSavedAutomatically => 'La configuración se guarda automáticamente';

  @override
  String get settingsExperimentalAlpha => 'alfa';

  @override
  String get settingsExperimentalAlphaDescription => 'Esta función está en fase alfa y puede no funcionar como se pretende o se espera.\nNo se pueden descartar problemas críticos y/o daños críticos permanentes en el dispositivo y/o los servicios utilizados.\nÚsela bajo su propio riesgo. El autor de la app no asume ninguna responsabilidad.';

  @override
  String get settingsExperimentalAlphaFeature => 'Función alfa, mantenga presionado para saber más';

  @override
  String get settingsExperimentalBeta => 'beta';

  @override
  String get settingsExperimentalBetaDescription => 'Esta función está en fase beta y puede no funcionar como se pretende o se espera.\nPueden ocurrir problemas menos graves, o no. Los daños no deberían ser críticos.\nÚsela bajo su propio riesgo.';

  @override
  String get settingsExperimentalBetaFeature => 'Función beta, mantenga presionado para saber más';

  @override
  String get settingsExperimentalDeprecated => 'obsoleta';

  @override
  String get settingsExperimentalDeprecatedDescription => 'Esta función está obsoleta y se eliminará en una versión futura.\nPuede que no funcione como se pretende o se espera. Úsela bajo su propio riesgo.';

  @override
  String get settingsExperimentalDeprecatedFeature => 'Función obsoleta, mantenga presionado para saber más';

  @override
  String get settingsHost => 'Host';

  @override
  String get settingsHostValid => 'Host válido';

  @override
  String get settingsHostChecking => 'Comprobando host';

  @override
  String settingsHostInvalid(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': 'URL no válida',
        'host': 'Host no válido',
        'auth': 'Error de autenticación',
        'timeout': 'Solicitud fallida. Problemas del servidor',
        'ratelimit': 'Demasiadas solicitudes',
        'other': 'Solicitud fallida',
      },
    );
    return 'Problema: $_temp0';
  }

  @override
  String get settingsHostHeaderTitle => 'Definir encabezado del host';

  @override
  String get settingsHostHeaderInvalid => 'El texto ingresado no es un objeto JSON de encabezado válido';

  @override
  String settingsHostInvalidDetailed(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': 'La URL ingresada no es válida. Use una URL completa que comience con http:// o https:// — por ejemplo http://localhost:11434 para un servidor Ollama local, o https://ollama.com para Ollama Cloud. No agregue una barra diagonal final ni una ruta /api.',
        'host': 'El host ingresado no es válido. No se puede alcanzar. Compruebe el host e inténtelo de nuevo.',
        'auth': 'El servidor rechazó la solicitud (401/403). Si se conecta a Ollama Cloud (https://ollama.com), ingrese su clave de API en el campo de token de abajo — puede crearla o copiarla en https://ollama.com/keys — y guárdela. Si usa un servidor autoalojado, compruebe el encabezado Authorization configurado para el host.',
        'other': 'El host ingresado no es válido. No se puede alcanzar. Compruebe el host e inténtelo de nuevo.',
      },
    );
    return '$_temp0';
  }

  @override
  String get settingsApiTokenInvalid => 'Token de API rechazado';

  @override
  String get settingsApiTokenInvalidDetailed => 'El token de API fue rechazado por el servidor (401/403). Compruebe que se haya copiado exactamente como se muestra en https://ollama.com/keys — en esa página se puede crear una clave nueva — y guárdelo de nuevo. El token debe estar configurado mientras el host sea https://ollama.com.';

  @override
  String get settingsApiTokenVerified => 'Token de API guardado y verificado';

  @override
  String get settingsApiToken => 'Token de API de Ollama Cloud';

  @override
  String get settingsApiTokenHint => 'Pegue el token de ollama.com';

  @override
  String get tooltipShowToken => 'Mostrar token';

  @override
  String get tooltipHideToken => 'Ocultar token';

  @override
  String voiceLanguageInstruction(String language) {
    return '¡Debe escribir en el siguiente idioma: $language!';
  }

  @override
  String get settingsSystemMessage => 'Mensaje del sistema';

  @override
  String get settingsUseSystem => 'Usar mensaje del sistema';

  @override
  String get settingsUseSystemDescription => 'Desactiva el establecimiento del mensaje del sistema de arriba y usa el del modelo en su lugar. Puede ser útil para modelos con archivos de modelo';

  @override
  String get settingsDisableMarkdown => 'Desactivar markdown';

  @override
  String get settingsBehaviorNotUpdatedForOlderChats => 'Los ajustes de comportamiento no se actualizan para los chats antiguos';

  @override
  String get settingsShowModelTags => 'Mostrar etiquetas del modelo';

  @override
  String get settingsPreloadModels => 'Precargar modelos';

  @override
  String get settingsResetOnModelChange => 'Restablecer al cambiar de modelo';

  @override
  String get settingsRequestTypeStream => 'Stream';

  @override
  String get settingsRequestTypeRequest => 'Request';

  @override
  String get settingsGenerateTitles => 'Generar títulos';

  @override
  String get settingsEnableEditing => 'Edición de mensajes';

  @override
  String get settingsAskBeforeDelete => 'Preguntar antes de eliminar el chat';

  @override
  String get settingsShowTips => 'Mostrar consejos en la barra lateral';

  @override
  String get settingsKeepModelLoadedAlways => 'Mantener el modelo siempre cargado';

  @override
  String get settingsKeepModelLoadedNever => 'No mantener el modelo cargado';

  @override
  String get settingsKeepModelLoadedFor => 'Definir un tiempo específico para mantener el modelo cargado';

  @override
  String settingsKeepModelLoadedSet(String minutes) {
    return 'Mantener el modelo cargado durante $minutes minutos';
  }

  @override
  String get settingsTimeoutMultiplier => 'Multiplicador de tiempo de espera';

  @override
  String get settingsTimeoutMultiplierDescription => 'Seleccione el multiplicador que se aplicará a cada valor de tiempo de espera en la app. Puede ser útil con una conexión a internet lenta o un host lento.';

  @override
  String get settingsTimeoutMultiplierExample => 'P. ej., tiempo de espera del mensaje:';

  @override
  String get settingsEnableHapticFeedback => 'Activar retroalimentación háptica';

  @override
  String get settingsMaximizeOnStart => 'Iniciar maximizado';

  @override
  String get settingsBrightnessSystem => 'Sistema';

  @override
  String get settingsBrightnessLight => 'Claro';

  @override
  String get settingsBrightnessDark => 'Oscuro';

  @override
  String get settingsThemeDevice => 'Dispositivo';

  @override
  String get settingsThemeOllama => 'Ollama';

  @override
  String get settingsTemporaryFixes => 'Correcciones temporales de interfaz';

  @override
  String get settingsTemporaryFixesDescription => 'Active correcciones temporales para problemas de interfaz.\nMantenga presionadas las opciones individuales para saber más.';

  @override
  String get settingsTemporaryFixesInstructions => '¡No active ninguna de estas opciones a menos que sepa lo que está haciendo! Las soluciones indicadas podrían no funcionar como se espera.\nNo pueden considerarse definitivas ni deben juzgarse como tales. Podrían surgir problemas.';

  @override
  String get settingsTemporaryFixesNoFixes => 'No hay correcciones disponibles';

  @override
  String get settingsVoicePermissionLoading => 'Cargando permisos de voz ...';

  @override
  String get settingsVoiceTtsNotSupported => 'Síntesis de voz no compatible';

  @override
  String get settingsVoiceTtsNotSupportedDescription => 'Los servicios de síntesis de voz no son compatibles con el idioma seleccionado. Seleccione otro idioma en el panel de idiomas para volver a activarlos.\nOtros servicios, como el reconocimiento de voz y el pensamiento de la IA, seguirán funcionando con normalidad, pero la interacción podría no ser tan fluida.';

  @override
  String get settingsVoicePermissionNot => 'Permisos no concedidos';

  @override
  String get settingsVoiceNotEnabled => 'Modo de voz no activado';

  @override
  String get settingsVoiceNotSupported => 'Modo de voz no compatible';

  @override
  String get settingsVoiceEnable => 'Activar modo de voz';

  @override
  String get settingsVoiceNoLanguage => 'No hay ningún idioma seleccionado';

  @override
  String get settingsVoiceLimitLanguage => 'Limitar al idioma seleccionado';

  @override
  String get settingsVoicePunctuation => 'Activar puntuación de la IA';

  @override
  String get settingsExportChats => 'Exportar chats';

  @override
  String get settingsExportChatsSuccess => 'Chats exportados correctamente';

  @override
  String get settingsImportChats => 'Importar chats';

  @override
  String get settingsImportChatsTitle => 'Importar';

  @override
  String get settingsImportChatsDescription => 'El siguiente paso importará los chats del archivo seleccionado. Esto sobrescribirá todos los chats disponibles actualmente.\n¿Desea continuar?';

  @override
  String get settingsImportChatsImport => 'Importar y borrar';

  @override
  String get settingsImportChatsCancel => 'Cancelar';

  @override
  String get settingsImportChatsSuccess => 'Chats importados correctamente';

  @override
  String get settingsExportInfo => 'Esta opción le permite exportar e importar su historial de chats. Puede ser útil si desea transferir su historial de chats a otro dispositivo o hacer una copia de seguridad del mismo';

  @override
  String get settingsExportWarning => '¡Varios historiales de chats no se fusionarán! Perderá su historial de chats actual si importa uno nuevo';

  @override
  String get settingsUpdateCheck => 'Buscar actualizaciones';

  @override
  String get settingsUpdateChecking => 'Buscando actualizaciones ...';

  @override
  String get settingsUpdateLatest => 'Está en la versión más reciente';

  @override
  String settingsUpdateAvailable(String version) {
    return 'Actualización disponible (v$version)';
  }

  @override
  String get settingsUpdateRateLimit => 'No se puede comprobar, se excedió el límite de la API';

  @override
  String get settingsUpdateIssue => 'Ocurrió un problema';

  @override
  String get settingsUpdateDialogTitle => 'Nueva versión disponible';

  @override
  String get settingsUpdateDialogDescription => 'Hay una nueva versión de Ollama disponible. ¿Desea descargarla e instalarla ahora?';

  @override
  String get settingsUpdateChangeLog => 'Registro de cambios';

  @override
  String get settingsUpdateDialogUpdate => 'Actualizar';

  @override
  String get settingsUpdateDialogCancel => 'Cancelar';

  @override
  String get settingsCheckForUpdates => 'Buscar actualizaciones al abrir';

  @override
  String get settingsGithub => 'GitHub';

  @override
  String get settingsReportIssue => 'Informar de un problema';

  @override
  String get settingsLicenses => 'Licencias';

  @override
  String settingsVersion(String version) {
    return 'Ollama App v$version';
  }

  @override
  String get settingsTitleAccessibility => 'Accesibilidad';

  @override
  String get settingsDescriptionAccessibility => 'Declaración de accesibilidad, resultados de pruebas y cómo informar de un problema.';

  @override
  String get accessibilityStatementTitle => 'Declaración de accesibilidad';

  @override
  String get accessibilityCommitmentIntro => 'Ollama debe poder ser usado por personas de todas las capacidades, en cada idioma que publicamos. El control por voz, los lectores de pantalla, la navegación con teclado y el renderizado de alto contraste son formas de primera clase de usar esta app — no algo secundario.';

  @override
  String get accessibilityCommitmentDetails => 'En la práctica, esto significa: cada control interactivo tiene un nombre que los lectores de pantalla anuncian (incluido el estado del modo de voz), los botones mantienen un objetivo táctil mínimo de 48dp, el foco del teclado sigue el orden visual de la interfaz, los mensajes de estado se anuncian mientras cambian y la interfaz sigue siendo utilizable con escalas de texto grandes y en los temas claro y oscuro.';

  @override
  String get accessibilityConformanceTitle => 'Estado de conformidad';

  @override
  String get accessibilityConformanceStatus => 'Esta app está diseñada para cumplir con las Pautas de Accesibilidad para el Contenido Web (WCAG) 2.2 Level AA. La conformidad no ha sido certificada de forma independiente por un tercero; se basa en nuestras propias pruebas automatizadas. Cuando resulta factible, vamos más allá de AA y aplicamos medidas WCAG AAA, que se enumeran a continuación.';

  @override
  String get accessibilityAaaMeasuresTitle => 'Superando AA (medidas AAA)';

  @override
  String get accessibilityAaaMeasures => 'El texto principal usa un contraste de 21:1 en ambos temas (AAA exige 7:1), el texto secundario atenuado usa 10:1 o mejor, los colores de estado para el éxito y las advertencias cumplen el contraste AAA en ambos temas, y el texto de error en el tema oscuro cumple el contraste AAA. AAA exige además medidas que no son prácticas en una aplicación de chat de este tamaño (por ejemplo, un contraste de 7:1 en absolutamente todo el texto y límites de nivel de lectura), por lo que nos fijamos en AA como garantía y tratamos estas medidas AAA como mejoras.';

  @override
  String get accessibilityAodaTitle => 'Ley de Accesibilidad para los Ontarienses con Discapacidad (AODA)';

  @override
  String get accessibilityAodaText => 'La Ley de Accesibilidad para los Ontarienses con Discapacidad (AODA) de Ontario exige que los productos digitales cumplan WCAG 2.0/2.1 Level AA. El objetivo WCAG 2.2 Level AA de esta app cumple y supera ese nivel base. Los comentarios sobre accesibilidad son bienvenidos a través del formulario de contacto de esta página, en línea con el requisito de la AODA de hacer accesibles los canales de comentarios.';

  @override
  String get accessibilityStandardsEuropeTitle => 'Normas europeas (EN 301 549)';

  @override
  String get accessibilityStandardsEuropeText => 'En la Unión Europea, la norma armonizada EN 301 549 define los requisitos de accesibilidad de las TIC del Acta Europea de Accesibilidad, que hace referencia a WCAG 2.1 Level AA. El objetivo WCAG 2.2 Level AA de esta app cubre esos requisitos, apoyando las obligaciones de accesibilidad europeas que se aplican desde el 28 de junio de 2025.';

  @override
  String get accessibilityStandardsUsTitle => 'Normas de Estados Unidos (ADA / Section 508)';

  @override
  String get accessibilityStandardsUsText => 'En Estados Unidos, la Ley de Estadounidenses con Discapacidad (ADA) es el nivel base general de no discriminación, y la Section 508 de la Ley de Rehabilitación exige WCAG 2.0 Level AA para la tecnología federal (la Section 504 extiende obligaciones similares a los programas financiados). El objetivo WCAG 2.2 Level AA de esta app cumple y supera esos niveles base.';

  @override
  String get accessibilityKnownIssuesTitle => 'Limitaciones conocidas';

  @override
  String get accessibilityKnownIssues => 'Los botones de la barra de título de la ventana de escritorio (minimizar, maximizar, cerrar) los proporciona la integración del sistema operativo y no son alcanzables desde el árbol del lector de pantalla de la app. La biblioteca de chats muestra una pequeña cantidad de su propio texto de interfaz, que puede no estar disponible todavía en todos los idiomas. En el modo de voz, el texto de la respuesta se desvanece cerca del borde de la pantalla y las líneas de chat muy largas pueden truncarse con puntos suspensivos cuando el tamaño de texto del sistema aumenta considerablemente.';

  @override
  String accessibilityLastValidated(String version) {
    return 'Las comprobaciones automatizadas se validaron por última vez contra Ollama App v$version.';
  }

  @override
  String get accessibilityTestsTitle => 'Resultados de las pruebas';

  @override
  String get accessibilityTestsIntro => 'Las siguientes comprobaciones automatizadas de accesibilidad forman parte del conjunto de pruebas de esta app y se ejecutan en cada commit:';

  @override
  String get accessibilityTestsCheckColumn => 'Comprobación';

  @override
  String get accessibilityTestsStatusColumn => 'Estado';

  @override
  String get accessibilityTestsPass => 'Correcta';

  @override
  String get accessibilityTestsCiNote => 'El conjunto completo (análisis estático más pruebas automatizadas) se ejecuta en cada commit en el pipeline de integración continua.';

  @override
  String get accessibilityTestContrast => 'El contraste del texto cumple los niveles WCAG en los temas claro y oscuro';

  @override
  String get accessibilityTestLabeledTapTarget => 'Los objetivos tocables tienen etiquetas para el lector de pantalla';

  @override
  String get accessibilityTestAndroidTapTarget => 'Los objetivos táctiles miden al menos 48x48dp (guía de Android)';

  @override
  String get accessibilityTestIosTapTarget => 'Los objetivos táctiles miden al menos 44x44dp (guía de iOS)';

  @override
  String get accessibilityTestSemanticsPresent => 'Existen etiquetas para el lector de pantalla para todos los controles personalizados';

  @override
  String get accessibilityTestTraversalOrder => 'El orden del foco del teclado sigue el orden visual';

  @override
  String get accessibilityTestLocalesRender => 'Todos los idiomas de la interfaz se renderizan sin errores';

  @override
  String get accessibilityTestFormValidation => 'Los campos del formulario anuncian los errores de validación';

  @override
  String get accessibilityContactTitle => 'Informar de un problema de accesibilidad';

  @override
  String get accessibilityContactIntro => 'Use este formulario para solicitar información de accesibilidad, pedir una resolución o informar de una barrera de accesibilidad. Su informe se compone en un mensaje que puede enviar por correo electrónico o como un issue público en GitHub.';

  @override
  String get accessibilityFormName => 'Nombre (opcional)';

  @override
  String get accessibilityFormEmail => 'Correo electrónico (opcional)';

  @override
  String get accessibilityFormAssistiveTech => 'Tecnología de asistencia usada (opcional)';

  @override
  String get accessibilityFormDescription => 'Describa el problema (obligatorio)';

  @override
  String get accessibilityFormDescriptionHint => '¿Qué estaba intentando hacer y qué se lo impidió?';

  @override
  String get accessibilityFormErrorDescription => 'Describa el problema antes de enviar.';

  @override
  String get accessibilityFormErrorEmail => 'Ingrese una dirección de correo electrónico válida o deje el campo vacío.';

  @override
  String get accessibilityFormSendEmail => 'Enviar por correo electrónico';

  @override
  String get accessibilityFormSendGithub => 'Abrir un issue en GitHub';

  @override
  String get accessibilityFormEmailSubject => 'Informe de accesibilidad (Ollama App)';

  @override
  String get accessibilityFormCopiedFallback => 'No se pudo abrir el enlace. El informe se copió al portapapeles.';

  @override
  String get tooltipResetChat => 'Restablecer el chat actual';

  @override
  String get tooltipVoiceClose => 'Cerrar el modo de voz';

  @override
  String get tooltipVoiceSettings => 'Abrir la configuración de voz';

  @override
  String get tooltipVoiceScrollToEnd => 'Desplazarse al último texto';

  @override
  String get tooltipWelcomeNext => 'Página siguiente';

  @override
  String get tooltipWelcomeFinish => 'Empezar a usar Ollama';

  @override
  String get accessibilityVoiceOrbListening => 'El modo de voz está escuchando. Toque para dejar de escuchar.';

  @override
  String get accessibilityVoiceOrbSpeaking => 'La respuesta se está leyendo en voz alta. Toque para detener.';

  @override
  String get accessibilityVoiceOrbThinking => 'La IA está preparando una respuesta. Toque para cancelar.';

  @override
  String get accessibilityAppLogo => 'Ollama';

  @override
  String get accessibilityWelcomePage1 => 'Bienvenido a Ollama. Esta introducción muestra tres imágenes breves.';

  @override
  String get accessibilityWelcomePage2 => 'Página de introducción 2 de 3. La imagen muestra cómo seleccionar un modelo y empezar a chatear.';

  @override
  String get accessibilityWelcomePage3 => 'Página de introducción 3 de 3. La imagen muestra dónde encontrar la configuración y el modo de voz.';

  @override
  String get accessibilitySummaryConformance => 'Esta app apunta a WCAG 2.2 Level AA y aplica mejoras de nivel AAA. Algunas funciones tienen limitaciones, descritas dentro de cada sección.';

  @override
  String get accessibilitySectionStatementSummary => 'Nuestro compromiso, el estado de conformidad y las medidas que aplicamos más allá de AA.';

  @override
  String get accessibilitySectionTestsSummary => '8 comprobaciones automatizadas de accesibilidad pasan en cada compilación.';

  @override
  String get accessibilitySectionStandardsSummary => 'Cómo damos soporte a AODA, la norma europea EN 301 549 y la ADA / Section 508 de Estados Unidos.';

  @override
  String get accessibilitySectionContactSummary => 'Informe de un problema de accesibilidad por correo electrónico o GitHub. Respondemos a todos los informes.';

  @override
  String get accessibilitySupportLevelLimited => 'Soporte limitado';

  @override
  String get accessibilitySupportLevelCompliantWithLimitations => 'Cumple con limitaciones';
}