// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Ollama';

  @override
  String get optionNewChat => 'Nova conversa';

  @override
  String get optionSettings => 'Definições';

  @override
  String get optionInstallPwa => 'Instalar aplicação web';

  @override
  String get optionNoChatFound => 'Não foram encontradas conversas';

  @override
  String get tipPrefix => 'Dica: ';

  @override
  String get tip0 => 'Edite as mensagens mantendo-as premidas';

  @override
  String get tip1 => 'Elimine as mensagens tocando nelas duas vezes';

  @override
  String get tip2 => 'Pode alterar o tema nas definições';

  @override
  String get tip3 => 'Selecione um modelo multimodal para introduzir imagens';

  @override
  String get tip4 => 'As conversas são guardadas automaticamente';

  @override
  String get deleteChat => 'Eliminar';

  @override
  String get renameChat => 'Renomear';

  @override
  String get takeImage => 'Tirar fotografia';

  @override
  String get uploadImage => 'Carregar imagem';

  @override
  String get notAValidImage => 'Não é uma imagem válida';

  @override
  String get imageOnlyConversation => 'Conversa apenas com imagens';

  @override
  String get messageInputPlaceholder => 'Mensagem';

  @override
  String get tooltipAttachment => 'Adicionar anexo';

  @override
  String get tooltipSend => 'Enviar';

  @override
  String get tooltipSave => 'Guardar';

  @override
  String get tooltipLetAIThink => 'Deixar a IA pensar';

  @override
  String get tooltipAddHostHeaders => 'Adicionar cabeçalhos do servidor';

  @override
  String get tooltipReset => 'Reiniciar a conversa atual';

  @override
  String get tooltipOptions => 'Mostrar opções';

  @override
  String get noModelSelected => 'Nenhum modelo selecionado';

  @override
  String get noHostSelected => 'Nenhum servidor selecionado; abra as definições para definir um';

  @override
  String get noSelectedModel => '<seletor>';

  @override
  String get newChatTitle => 'Conversa sem nome';

  @override
  String get modelDialogAddModel => 'Adicionar';

  @override
  String get modelDialogAddPromptTitle => 'Adicionar novo modelo';

  @override
  String get modelDialogAddPromptDescription => 'Isto pode ser um nome normal (p. ex. \'llama3\') ou um nome com etiqueta (p. ex. \'llama3:70b\').';

  @override
  String get modelDialogAddPromptAlreadyExists => 'O modelo já existe';

  @override
  String get modelDialogAddPromptInvalid => 'Nome de modelo inválido';

  @override
  String get modelDialogAddAllowanceTitle => 'Permitir proxy';

  @override
  String get modelDialogAddAllowanceDescription => 'A aplicação Ollama tem de verificar se o modelo introduzido é válido. Para isso, normalmente enviamos um pedido web à lista de modelos do Ollama e verificamos o código de estado, mas como está a utilizar o cliente web, não o podemos fazer diretamente. Em vez disso, a aplicação enviará o pedido para outra API, alojada por JHubi1, para verificar por nós.\nEste é um pedido único e só será enviado quando adicionar um novo modelo.\nO seu endereço IP será enviado com o pedido e poderá ser guardado durante um máximo de dez minutos para impedir o envio de spam com intenções potencialmente prejudiciais.\nSe aceitar, a sua seleção será memorizada no futuro; se não, nada será enviado e o modelo não será adicionado.';

  @override
  String get modelDialogAddAllowanceAllow => 'Permitir';

  @override
  String get modelDialogAddAllowanceDeny => 'Negar';

  @override
  String modelDialogAddAssuranceTitle(String model) {
    return 'Adicionar $model?';
  }

  @override
  String modelDialogAddAssuranceDescription(String model) {
    return 'Ao premir \'Adicionar\', o modelo \'$model\' será transferido diretamente do servidor Ollama para o seu servidor.\nIsto pode demorar algum tempo, dependendo da sua ligação à internet. A ação não pode ser cancelada.\nSe a aplicação for fechada durante a transferência, esta será retomada se voltar a introduzir o nome na janela de modelos.';
  }

  @override
  String get modelDialogAddAssuranceAdd => 'Adicionar';

  @override
  String get modelDialogAddAssuranceCancel => 'Cancelar';

  @override
  String get modelDialogAddDownloadPercentLoading => 'a carregar o progresso';

  @override
  String modelDialogAddDownloadPercent(String percent) {
    return 'transferência em $percent%';
  }

  @override
  String get modelDialogAddDownloadFailed => 'Desligado, tente novamente';

  @override
  String get modelDialogAddDownloadSuccess => 'Transferência concluída com sucesso';

  @override
  String get deleteDialogTitle => 'Eliminar conversa';

  @override
  String get deleteDialogDescription => 'Tem a certeza de que pretende continuar? Isto apagará toda a memória desta conversa e não pode ser anulado.\nPara desativar esta janela, visite as definições.';

  @override
  String get deleteDialogDelete => 'Eliminar';

  @override
  String get deleteDialogCancel => 'Cancelar';

  @override
  String get dialogEnterNewTitle => 'Introduza o novo título';

  @override
  String get dialogEditMessageTitle => 'Editar mensagem';

  @override
  String get settingsTitleBehavior => 'Comportamento';

  @override
  String get settingsDescriptionBehavior => 'Altere o comportamento da IA ao seu gosto.';

  @override
  String get settingsTitleInterface => 'Interface';

  @override
  String get settingsDescriptionInterface => 'Edite a aparência e o comportamento da aplicação Ollama.';

  @override
  String get settingsTitleVoice => 'Voz';

  @override
  String get settingsDescriptionVoice => 'Ative o modo de voz e configure as definições de voz.';

  @override
  String get settingsTitleExport => 'Exportar';

  @override
  String get settingsDescriptionExport => 'Exporte e importe o seu histórico de conversas.';

  @override
  String get settingsTitleAbout => 'Acerca de';

  @override
  String get settingsDescriptionAbout => 'Verifique se há atualizações e saiba mais sobre a aplicação Ollama.';

  @override
  String get settingsSavedAutomatically => 'As definições são guardadas automaticamente';

  @override
  String get settingsExperimentalAlpha => 'alfa';

  @override
  String get settingsExperimentalAlphaDescription => 'Esta funcionalidade está em fase alfa e pode não funcionar como pretendido ou esperado.\nNão é possível excluir problemas críticos e/ou danos críticos permanentes no dispositivo e/ou nos serviços utilizados.\nUtilize por sua conta e risco. O autor da aplicação não assume qualquer responsabilidade.';

  @override
  String get settingsExperimentalAlphaFeature => 'Funcionalidade em alfa, mantenha premido para saber mais';

  @override
  String get settingsExperimentalBeta => 'beta';

  @override
  String get settingsExperimentalBetaDescription => 'Esta funcionalidade está em fase beta e pode não funcionar como pretendido ou esperado.\nPodem ou não ocorrer problemas menos graves. Os danos não deverão ser críticos.\nUtilize por sua conta e risco.';

  @override
  String get settingsExperimentalBetaFeature => 'Funcionalidade em beta, mantenha premido para saber mais';

  @override
  String get settingsExperimentalDeprecated => 'obsoleta';

  @override
  String get settingsExperimentalDeprecatedDescription => 'Esta funcionalidade está obsoleta e será removida numa versão futura.\nPode não funcionar como pretendido ou esperado. Utilize por sua conta e risco.';

  @override
  String get settingsExperimentalDeprecatedFeature => 'Funcionalidade obsoleta, mantenha premido para saber mais';

  @override
  String get settingsHost => 'Servidor';

  @override
  String get settingsHostValid => 'Servidor válido';

  @override
  String get settingsHostChecking => 'A verificar o servidor';

  @override
  String settingsHostInvalid(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': 'URL inválido',
        'host': 'Servidor inválido',
        'auth': 'Falha na autenticação',
        'timeout': 'Falha no pedido. Problemas no servidor',
        'ratelimit': 'Demasiados pedidos',
        'other': 'Falha no pedido',
      },
    );
    return 'Problema: $_temp0';
  }

  @override
  String get settingsHostHeaderTitle => 'Definir cabeçalho do servidor';

  @override
  String get settingsHostHeaderInvalid => 'O texto introduzido não é um objeto JSON de cabeçalho válido';

  @override
  String settingsHostInvalidDetailed(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': 'O URL introduzido é inválido. Utilize um URL completo que comece por http:// ou https:// — por exemplo http://localhost:11434 para um servidor Ollama local, ou https://ollama.com para Ollama Cloud. Não acrescente uma barra final nem um caminho /api.',
        'host': 'O servidor introduzido é inválido. Não é possível alcançá-lo. Verifique o servidor e tente novamente.',
        'auth': 'O servidor rejeitou o pedido (401/403). Se se ligar ao Ollama Cloud (https://ollama.com), introduza a sua chave de API no campo de token abaixo — pode criá-la ou copiá-la em https://ollama.com/keys — e guarde-a. Se utilizar um servidor alojado por si, verifique o cabeçalho Authorization configurado para o servidor.',
        'other': 'O servidor introduzido é inválido. Não é possível alcançá-lo. Verifique o servidor e tente novamente.',
      },
    );
    return '$_temp0';
  }

  @override
  String get settingsApiTokenInvalid => 'Token de API rejeitado';

  @override
  String get settingsApiTokenInvalidDetailed => 'O token de API foi rejeitado pelo servidor (401/403). Verifique que foi copiado exatamente como apresentado em https://ollama.com/keys — é possível criar uma nova chave nessa página — e volte a guardá-lo. O token tem de estar definido enquanto o servidor for https://ollama.com.';

  @override
  String get settingsApiTokenVerified => 'Token de API guardado e verificado';

  @override
  String get settingsApiToken => 'Token de API do Ollama Cloud';

  @override
  String get settingsApiTokenHint => 'Cole o token de ollama.com';

  @override
  String get tooltipShowToken => 'Mostrar token';

  @override
  String get tooltipHideToken => 'Ocultar token';

  @override
  String voiceLanguageInstruction(String language) {
    return 'Tem de escrever no seguinte idioma: $language!';
  }

  @override
  String get settingsSystemMessage => 'Mensagem do sistema';

  @override
  String get settingsUseSystem => 'Utilizar mensagem do sistema';

  @override
  String get settingsUseSystemDescription => 'Desativa a definição da mensagem do sistema acima e utiliza a do modelo em vez disso. Pode ser útil para modelos com ficheiros de modelo';

  @override
  String get settingsDisableMarkdown => 'Desativar markdown';

  @override
  String get settingsBehaviorNotUpdatedForOlderChats => 'As definições de comportamento não são atualizadas para conversas mais antigas';

  @override
  String get settingsShowModelTags => 'Mostrar etiquetas do modelo';

  @override
  String get settingsPreloadModels => 'Pré-carregar modelos';

  @override
  String get settingsResetOnModelChange => 'Reiniciar ao mudar de modelo';

  @override
  String get settingsRequestTypeStream => 'Stream';

  @override
  String get settingsRequestTypeRequest => 'Request';

  @override
  String get settingsGenerateTitles => 'Gerar títulos';

  @override
  String get settingsEnableEditing => 'Edição de mensagens';

  @override
  String get settingsAskBeforeDelete => 'Perguntar antes de eliminar a conversa';

  @override
  String get settingsShowTips => 'Mostrar dicas na barra lateral';

  @override
  String get settingsKeepModelLoadedAlways => 'Manter o modelo sempre carregado';

  @override
  String get settingsKeepModelLoadedNever => 'Não manter o modelo carregado';

  @override
  String get settingsKeepModelLoadedFor => 'Definir um tempo específico para manter o modelo carregado';

  @override
  String settingsKeepModelLoadedSet(String minutes) {
    return 'Manter o modelo carregado durante $minutes minutos';
  }

  @override
  String get settingsTimeoutMultiplier => 'Multiplicador do tempo limite';

  @override
  String get settingsTimeoutMultiplierDescription => 'Selecione o multiplicador que será aplicado a todos os valores de tempo limite na aplicação. Pode ser útil com uma ligação à internet lenta ou um servidor lento.';

  @override
  String get settingsTimeoutMultiplierExample => 'P. ex., tempo limite da mensagem:';

  @override
  String get settingsEnableHapticFeedback => 'Ativar feedback háptico';

  @override
  String get settingsMaximizeOnStart => 'Iniciar maximizado';

  @override
  String get settingsBrightnessSystem => 'Sistema';

  @override
  String get settingsBrightnessLight => 'Claro';

  @override
  String get settingsBrightnessDark => 'Escuro';

  @override
  String get settingsThemeDevice => 'Dispositivo';

  @override
  String get settingsThemeOllama => 'Ollama';

  @override
  String get settingsTemporaryFixes => 'Correções temporárias da interface';

  @override
  String get settingsTemporaryFixesDescription => 'Ative correções temporárias para problemas da interface.\nMantenha premido nas opções individuais para saber mais.';

  @override
  String get settingsTemporaryFixesInstructions => 'Não ative nenhuma destas definições, a menos que saiba o que está a fazer! As soluções indicadas podem não funcionar como esperado.\nNão podem ser consideradas definitivas nem devem ser avaliadas como tal. Podem ocorrer problemas.';

  @override
  String get settingsTemporaryFixesNoFixes => 'Não há correções disponíveis';

  @override
  String get settingsVoicePermissionLoading => 'A carregar as permissões de voz ...';

  @override
  String get settingsVoiceTtsNotSupported => 'Síntese de voz não suportada';

  @override
  String get settingsVoiceTtsNotSupportedDescription => 'Os serviços de síntese de voz não são suportados para o idioma selecionado. Selecione outro idioma no painel de idiomas para voltar a ativá-los.\nOutros serviços, como o reconhecimento de voz e o pensamento da IA, continuarão a funcionar normalmente, mas a interação pode não ser tão fluida.';

  @override
  String get settingsVoicePermissionNot => 'Permissões não concedidas';

  @override
  String get settingsVoiceNotEnabled => 'Modo de voz não ativado';

  @override
  String get settingsVoiceNotSupported => 'Modo de voz não suportado';

  @override
  String get settingsVoiceEnable => 'Ativar o modo de voz';

  @override
  String get settingsVoiceNoLanguage => 'Nenhum idioma selecionado';

  @override
  String get settingsVoiceLimitLanguage => 'Limitar ao idioma selecionado';

  @override
  String get settingsVoicePunctuation => 'Ativar pontuação da IA';

  @override
  String get settingsExportChats => 'Exportar conversas';

  @override
  String get settingsExportChatsSuccess => 'Conversas exportadas com sucesso';

  @override
  String get settingsImportChats => 'Importar conversas';

  @override
  String get settingsImportChatsTitle => 'Importar';

  @override
  String get settingsImportChatsDescription => 'O passo seguinte importará as conversas do ficheiro selecionado. Isto substituirá todas as conversas atualmente disponíveis.\nPretende continuar?';

  @override
  String get settingsImportChatsImport => 'Importar e apagar';

  @override
  String get settingsImportChatsCancel => 'Cancelar';

  @override
  String get settingsImportChatsSuccess => 'Conversas importadas com sucesso';

  @override
  String get settingsExportInfo => 'Esta opção permite exportar e importar o seu histórico de conversas. Pode ser útil se quiser transferir o seu histórico de conversas para outro dispositivo ou criar uma cópia de segurança do mesmo';

  @override
  String get settingsExportWarning => 'Vários históricos de conversas não serão unificados! Perderá o seu histórico de conversas atual se importar um novo';

  @override
  String get settingsUpdateCheck => 'Procurar atualizações';

  @override
  String get settingsUpdateChecking => 'A procurar atualizações ...';

  @override
  String get settingsUpdateLatest => 'Está na versão mais recente';

  @override
  String settingsUpdateAvailable(String version) {
    return 'Atualização disponível (v$version)';
  }

  @override
  String get settingsUpdateRateLimit => 'Não é possível verificar, limite de pedidos da API excedido';

  @override
  String get settingsUpdateIssue => 'Ocorreu um problema';

  @override
  String get settingsUpdateDialogTitle => 'Nova versão disponível';

  @override
  String get settingsUpdateDialogDescription => 'Está disponível uma nova versão do Ollama. Quer transferi-la e instalá-la agora?';

  @override
  String get settingsUpdateChangeLog => 'Registo de alterações';

  @override
  String get settingsUpdateDialogUpdate => 'Atualizar';

  @override
  String get settingsUpdateDialogCancel => 'Cancelar';

  @override
  String get settingsCheckForUpdates => 'Procurar atualizações ao abrir';

  @override
  String get settingsGithub => 'GitHub';

  @override
  String get settingsReportIssue => 'Comunicar problema';

  @override
  String get settingsLicenses => 'Licenças';

  @override
  String settingsVersion(String version) {
    return 'Ollama App v$version';
  }
}