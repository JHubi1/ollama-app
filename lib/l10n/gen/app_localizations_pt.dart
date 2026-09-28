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

  @override
  String get settingsTitleAccessibility => 'Acessibilidade';

  @override
  String get settingsDescriptionAccessibility => 'Declaração de acessibilidade, resultados dos testes e como comunicar um problema.';

  @override
  String get accessibilityStatementTitle => 'Declaração de acessibilidade';

  @override
  String get accessibilityCommitmentIntro => 'O Ollama tem de ser utilizável por pessoas com qualquer tipo de capacidades, em todos os idiomas que disponibilizamos. O controlo por voz, os leitores de ecrã, a navegação por teclado e a renderização em alto contraste são formas de utilização desta aplicação de primeira classe — e não uma reflexão tardia.';

  @override
  String get accessibilityCommitmentDetails => 'Na prática, isto significa: cada controlo interativo tem um nome que os leitores de ecrã anunciam (incluindo o estado do modo de voz), os botões mantêm um alvo de toque mínimo de 48dp, a focagem do teclado segue a ordem visual da interface, as mensagens de estado são anunciadas quando mudam e a interface continua utilizável em escalas de texto grandes e nos temas claro e escuro.';

  @override
  String get accessibilityConformanceTitle => 'Estado de conformidade';

  @override
  String get accessibilityConformanceStatus => 'Esta aplicação está concebida para cumprir as Web Content Accessibility Guidelines (WCAG) 2.2 Level AA. A conformidade não foi certificada de forma independente por terceiros; baseia-se nos nossos próprios testes automatizados. Sempre que é viável, vamos além do AA e aplicamos medidas WCAG AAA, indicadas abaixo.';

  @override
  String get accessibilityAaaMeasuresTitle => 'Para além do AA (medidas AAA)';

  @override
  String get accessibilityAaaMeasures => 'O texto principal utiliza um contraste de 21:1 em ambos os temas (o AAA exige 7:1), o texto secundário atenuado utiliza 10:1 ou melhor, as cores de estado de sucesso e de aviso cumprem o contraste AAA em ambos os temas e o texto de erro no tema escuro cumpre o contraste AAA. O AAA exige, além disso, medidas pouco práticas numa aplicação de conversação deste tamanho (por exemplo, um contraste de 7:1 em absolutamente todo o texto e limites de nível de leitura), pelo que visamos o AA como garantia e tratamos estas medidas AAA como melhoramentos.';

  @override
  String get accessibilityAodaTitle => 'Lei de Acessibilidade para Ontarianos com Deficiências (AODA)';

  @override
  String get accessibilityAodaText => 'A Accessibility for Ontarians with Disabilities Act (AODA) de Ontário exige que os produtos digitais cumpram o WCAG 2.0/2.1 Level AA. O objetivo WCAG 2.2 Level AA desta aplicação cumpre e ultrapassa esse patamar mínimo. Os comentários sobre acessibilidade são bem-vindos através do formulário de contacto nesta página, em conformidade com a exigência da AODA de tornar os canais de comentários acessíveis.';

  @override
  String get accessibilityStandardsEuropeTitle => 'Normas europeias (EN 301 549)';

  @override
  String get accessibilityStandardsEuropeText => 'Na União Europeia, a norma harmonizada EN 301 549 define os requisitos de acessibilidade das TIC do Ato Europeu da Acessibilidade, que referencia o WCAG 2.1 Level AA. O objetivo WCAG 2.2 Level AA desta aplicação cobre esses requisitos, apoiando as obrigações europeias de acessibilidade aplicáveis a partir de 28 de junho de 2025.';

  @override
  String get accessibilityStandardsUsTitle => 'Normas dos Estados Unidos (ADA / Section 508)';

  @override
  String get accessibilityStandardsUsText => 'Nos Estados Unidos, a Americans with Disabilities Act (ADA) é o patamar mínimo geral de não discriminação e a Section 508 da Rehabilitation Act exige o WCAG 2.0 Level AA para a tecnologia federal (a Section 504 estende obrigações semelhantes aos programas financiados). O objetivo WCAG 2.2 Level AA desta aplicação cumpre e ultrapassa esses patamares.';

  @override
  String get accessibilityKnownIssuesTitle => 'Limitações conhecidas';

  @override
  String get accessibilityKnownIssues => 'Os botões da barra de título da janela de secretária (minimizar, maximizar, fechar) são fornecidos pela integração do sistema operativo e não estão ao alcance da árvore de leitor de ecrã da aplicação. A biblioteca de conversação processa uma pequena parte do seu próprio texto de interface, que pode ainda não estar disponível em todos os idiomas. No modo de voz, o texto da resposta é esbatido junto à margem do ecrã e as linhas de conversa muito longas podem ser truncadas com reticências quando o tamanho do texto do sistema é aumentado significativamente.';

  @override
  String accessibilityLastValidated(String version) {
    return 'Verificações automatizadas validadas pela última vez contra o Ollama App v$version.';
  }

  @override
  String get accessibilityTestsTitle => 'Resultados dos testes';

  @override
  String get accessibilityTestsIntro => 'As seguintes verificações de acessibilidade automatizadas fazem parte do conjunto de testes desta aplicação e são executadas em cada commit:';

  @override
  String get accessibilityTestsCheckColumn => 'Verificação';

  @override
  String get accessibilityTestsStatusColumn => 'Estado';

  @override
  String get accessibilityTestsPass => 'Aprovado';

  @override
  String get accessibilityTestsCiNote => 'O conjunto completo (análise estática e testes automatizados) é executado em cada commit no pipeline de integração contínua.';

  @override
  String get accessibilityTestContrast => 'O contraste do texto cumpre os níveis WCAG nos temas claro e escuro';

  @override
  String get accessibilityTestLabeledTapTarget => 'Os alvos tocáveis têm etiquetas para o leitor de ecrã';

  @override
  String get accessibilityTestAndroidTapTarget => 'As áreas de toque têm, no mínimo, 48x48dp (diretriz Android)';

  @override
  String get accessibilityTestIosTapTarget => 'As áreas de toque têm, no mínimo, 44x44dp (diretriz iOS)';

  @override
  String get accessibilityTestSemanticsPresent => 'Existem etiquetas de leitor de ecrã para todos os controlos personalizados';

  @override
  String get accessibilityTestTraversalOrder => 'A ordem de focagem do teclado segue a ordem visual';

  @override
  String get accessibilityTestLocalesRender => 'Todos os idiomas da interface são processados sem erros';

  @override
  String get accessibilityTestFormValidation => 'Os campos dos formulários anunciam erros de validação';

  @override
  String get accessibilityContactTitle => 'Comunicar um problema de acessibilidade';

  @override
  String get accessibilityContactIntro => 'Utilize este formulário para pedir informações de acessibilidade, solicitar uma resolução ou comunicar uma barreira de acessibilidade. O seu relatório é convertido numa mensagem que pode enviar por e-mail ou como um problema público no GitHub.';

  @override
  String get accessibilityFormName => 'Nome (opcional)';

  @override
  String get accessibilityFormEmail => 'E-mail (opcional)';

  @override
  String get accessibilityFormAssistiveTech => 'Tecnologia de assistência utilizada (opcional)';

  @override
  String get accessibilityFormDescription => 'Descreva o problema (obrigatório)';

  @override
  String get accessibilityFormDescriptionHint => 'O que estava a tentar fazer e o que o impediu?';

  @override
  String get accessibilityFormErrorDescription => 'Descreva o problema antes de enviar.';

  @override
  String get accessibilityFormErrorEmail => 'Introduza um endereço de e-mail válido ou deixe o campo vazio.';


  @override
  String get accessibilityFormSendGithub => 'Abrir um problema no GitHub';

  @override
  String get accessibilityFormEmailSubject => 'Relatório de acessibilidade (Ollama App)';

  @override
  String get accessibilityFormCopiedFallback => 'Não foi possível abrir a ligação. O relatório foi copiado para a área de transferência.';

  @override
  String get tooltipResetChat => 'Reiniciar a conversa atual';

  @override
  String get tooltipVoiceClose => 'Fechar o modo de voz';

  @override
  String get tooltipVoiceSettings => 'Abrir as definições de voz';

  @override
  String get tooltipVoiceScrollToEnd => 'Deslocar para o texto mais recente';

  @override
  String get tooltipWelcomeNext => 'Página seguinte';

  @override
  String get tooltipWelcomeFinish => 'Começar a utilizar o Ollama';

  @override
  String get accessibilityVoiceOrbListening => 'O modo de voz está a ouvir. Toque para parar de ouvir.';

  @override
  String get accessibilityVoiceOrbSpeaking => 'A resposta está a ser lida em voz alta. Toque para parar.';

  @override
  String get accessibilityVoiceOrbThinking => 'A IA está a preparar uma resposta. Toque para cancelar.';

  @override
  String get accessibilityAppLogo => 'Ollama';

  @override
  String get accessibilityWelcomePage1 => 'Bem-vindo ao Ollama. Esta apresentação inicial mostra três imagens breves.';

  @override
  String get accessibilityWelcomePage2 => 'Página de apresentação inicial 2 de 3. A imagem mostra como selecionar um modelo e começar a conversar.';

  @override
  String get accessibilityWelcomePage3 => 'Página de apresentação inicial 3 de 3. A imagem mostra onde encontrar as definições e o modo de voz.';

  @override
  String get accessibilitySummaryConformance => 'Esta aplicação tem como objetivo o WCAG 2.2 Level AA e aplica melhorias de nível AAA. Algumas funcionalidades têm limitações, descritas em cada secção.';

  @override
  String get accessibilitySectionStatementSummary => 'O nosso compromisso, o estado de conformidade e as medidas que aplicamos para além do AA.';

  @override
  String get accessibilitySectionTestsSummary => '8 verificações de acessibilidade automatizadas são aprovadas em cada compilação.';

  @override
  String get accessibilitySectionStandardsSummary => 'Como apoiamos a AODA, a norma europeia EN 301 549 e a ADA / Section 508 dos EUA.';

  @override
  String get accessibilitySectionContactSummary => 'Comunique um problema de acessibilidade por e-mail ou no GitHub. Respondemos a todas as comunicações.';

  @override
  String get accessibilitySupportLevelLimited => 'Suporte limitado';

  @override
  String get accessibilitySupportLevelCompliantWithLimitations => 'Conforme com limitações';
}