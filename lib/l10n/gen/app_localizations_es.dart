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
}