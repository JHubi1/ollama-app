// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese, Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'Ollama';

  @override
  String get optionNewChat => 'Nova conversa';

  @override
  String get optionSettings => 'Configurações';

  @override
  String get optionInstallPwa => 'Instalar aplicativo web';

  @override
  String get optionNoChatFound => 'Nenhuma conversa encontrada';

  @override
  String get tipPrefix => 'Dica: ';

  @override
  String get tip0 => 'Edite as mensagens pressionando e mantendo o dedo sobre elas';

  @override
  String get tip1 => 'Exclua as mensagens tocando duas vezes nelas';

  @override
  String get tip2 => 'Você pode alterar o tema nas configurações';

  @override
  String get tip3 => 'Selecione um modelo multimodal para inserir imagens';

  @override
  String get tip4 => 'As conversas são salvas automaticamente';

  @override
  String get deleteChat => 'Excluir';

  @override
  String get renameChat => 'Renomear';

  @override
  String get takeImage => 'Tirar foto';

  @override
  String get uploadImage => 'Enviar imagem';

  @override
  String get notAValidImage => 'Imagem inválida';

  @override
  String get imageOnlyConversation => 'Conversa somente com imagens';

  @override
  String get messageInputPlaceholder => 'Mensagem';

  @override
  String get tooltipAttachment => 'Adicionar anexo';

  @override
  String get tooltipSend => 'Enviar';

  @override
  String get tooltipSave => 'Salvar';

  @override
  String get tooltipLetAIThink => 'Deixar a IA pensar';

  @override
  String get tooltipAddHostHeaders => 'Adicionar cabeçalhos do host';

  @override
  String get tooltipReset => 'Redefinir a conversa atual';

  @override
  String get tooltipOptions => 'Mostrar opções';

  @override
  String get noModelSelected => 'Nenhum modelo selecionado';

  @override
  String get noHostSelected => 'Nenhum host selecionado, abra as configurações para definir um';

  @override
  String get noSelectedModel => '<seletor>';

  @override
  String get newChatTitle => 'Conversa sem nome';

  @override
  String get modelDialogAddModel => 'Adicionar';

  @override
  String get modelDialogAddPromptTitle => 'Adicionar novo modelo';

  @override
  String get modelDialogAddPromptDescription => 'Pode ser um nome normal (por exemplo, \'llama3\') ou um nome com tag (por exemplo, \'llama3:70b\').';

  @override
  String get modelDialogAddPromptAlreadyExists => 'O modelo já existe';

  @override
  String get modelDialogAddPromptInvalid => 'Nome de modelo inválido';

  @override
  String get modelDialogAddAllowanceTitle => 'Permitir proxy';

  @override
  String get modelDialogAddAllowanceDescription => 'O Ollama App precisa verificar se o modelo informado é válido. Para isso, normalmente enviamos uma requisição web à lista de modelos do Ollama e verificamos o código de status, mas como você está usando o cliente web, não podemos fazer isso diretamente. Em vez disso, o aplicativo enviará a requisição a uma API diferente, hospedada por JHubi1, para verificar por nós.\nEsta é uma requisição única e será enviada apenas quando você adicionar um novo modelo.\nSeu endereço IP será enviado com a requisição e poderá ser armazenado por até dez minutos para evitar spam com intenções potencialmente prejudiciais.\nSe você aceitar, sua escolha será lembrada no futuro; caso contrário, nada será enviado e o modelo não será adicionado.';

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
    return 'Ao pressionar \'Adicionar\', o modelo \'$model\' será baixado diretamente do servidor Ollama para o seu host.\nIsso pode levar algum tempo, dependendo da sua conexão com a internet. A ação não pode ser cancelada.\nSe o aplicativo for fechado durante o download, ele será retomado se você inserir o nome novamente na janela de modelos.';
  }

  @override
  String get modelDialogAddAssuranceAdd => 'Adicionar';

  @override
  String get modelDialogAddAssuranceCancel => 'Cancelar';

  @override
  String get modelDialogAddDownloadPercentLoading => 'carregando progresso';

  @override
  String modelDialogAddDownloadPercent(String percent) {
    return 'download em $percent%';
  }

  @override
  String get modelDialogAddDownloadFailed => 'Desconectado, tente novamente';

  @override
  String get modelDialogAddDownloadSuccess => 'Download concluído com sucesso';

  @override
  String get deleteDialogTitle => 'Excluir conversa';

  @override
  String get deleteDialogDescription => 'Tem certeza de que deseja continuar? Isso apagará toda a memória desta conversa e não poderá ser desfeito.\nPara desativar este diálogo, acesse as configurações.';

  @override
  String get deleteDialogDelete => 'Excluir';

  @override
  String get deleteDialogCancel => 'Cancelar';

  @override
  String get dialogEnterNewTitle => 'Digite o novo título';

  @override
  String get dialogEditMessageTitle => 'Editar mensagem';

  @override
  String get settingsTitleBehavior => 'Comportamento';

  @override
  String get settingsDescriptionBehavior => 'Altere o comportamento da IA do seu jeito.';

  @override
  String get settingsTitleInterface => 'Interface';

  @override
  String get settingsDescriptionInterface => 'Edite a aparência e o comportamento do aplicativo Ollama.';

  @override
  String get settingsTitleVoice => 'Voz';

  @override
  String get settingsDescriptionVoice => 'Ative o modo de voz e configure as opções de voz.';

  @override
  String get settingsTitleExport => 'Exportar';

  @override
  String get settingsDescriptionExport => 'Exporte e importe seu histórico de conversas.';

  @override
  String get settingsTitleAbout => 'Sobre';

  @override
  String get settingsDescriptionAbout => 'Verifique se há atualizações e saiba mais sobre o aplicativo Ollama.';

  @override
  String get settingsSavedAutomatically => 'As configurações são salvas automaticamente';

  @override
  String get settingsExperimentalAlpha => 'alfa';

  @override
  String get settingsExperimentalAlphaDescription => 'Este recurso está em alfa e pode não funcionar conforme o planejado ou o esperado.\nProblemas críticos e/ou danos críticos permanentes ao dispositivo e/ou aos serviços utilizados não podem ser descartados.\nUse por sua conta e risco. O autor do aplicativo não assume qualquer responsabilidade.';

  @override
  String get settingsExperimentalAlphaFeature => 'Recurso em alfa, mantenha pressionado para saber mais';

  @override
  String get settingsExperimentalBeta => 'beta';

  @override
  String get settingsExperimentalBetaDescription => 'Este recurso está em beta e pode não funcionar conforme o planejado ou o esperado.\nProblemas menos graves podem ou não ocorrer. Os danos não devem ser críticos.\nUse por sua conta e risco.';

  @override
  String get settingsExperimentalBetaFeature => 'Recurso em beta, mantenha pressionado para saber mais';

  @override
  String get settingsExperimentalDeprecated => 'obsoleto';

  @override
  String get settingsExperimentalDeprecatedDescription => 'Este recurso está obsoleto e será removido em uma versão futura.\nEle pode não funcionar conforme o planejado ou o esperado. Use por sua conta e risco.';

  @override
  String get settingsExperimentalDeprecatedFeature => 'Recurso obsoleto, mantenha pressionado para saber mais';

  @override
  String get settingsHost => 'Host';

  @override
  String get settingsHostValid => 'Host válido';

  @override
  String get settingsHostChecking => 'Verificando o host';

  @override
  String settingsHostInvalid(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': 'URL inválida',
        'host': 'Host inválido',
        'auth': 'Falha na autenticação',
        'timeout': 'Falha na requisição. Problemas no servidor',
        'ratelimit': 'Requisições em excesso',
        'other': 'Falha na requisição',
      },
    );
    return 'Problema: $_temp0';
  }

  @override
  String get settingsHostHeaderTitle => 'Definir cabeçalho do host';

  @override
  String get settingsHostHeaderInvalid => 'O texto informado não é um objeto JSON de cabeçalho válido';

  @override
  String settingsHostInvalidDetailed(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': 'A URL que você informou é inválida. Use uma URL completa começando com http:// ou https:// — por exemplo, http://localhost:11434 para um servidor Ollama local, ou https://ollama.com para o Ollama Cloud. Não adicione uma barra final nem o caminho /api.',
        'host': 'O host que você informou é inválido. Não é possível acessá-lo. Verifique o host e tente novamente.',
        'auth': 'O servidor rejeitou a requisição (401/403). Se você se conectar ao Ollama Cloud (https://ollama.com), informe sua chave de API no campo de token abaixo — você pode criá-la ou copiá-la em https://ollama.com/keys — e salve-a. Se você usa um servidor auto-hospedado, verifique o cabeçalho Authorization configurado para o host.',
        'other': 'O host que você informou é inválido. Não é possível acessá-lo. Verifique o host e tente novamente.',
      },
    );
    return '$_temp0';
  }

  @override
  String get settingsApiTokenInvalid => 'Token de API rejeitado';

  @override
  String get settingsApiTokenInvalidDetailed => 'O token de API foi rejeitado pelo servidor (401/403). Verifique se ele foi copiado exatamente como exibido em https://ollama.com/keys — uma nova chave pode ser criada nessa página — e salve-o novamente. O token deve estar definido enquanto o host for https://ollama.com.';

  @override
  String get settingsApiTokenVerified => 'Token de API salvo e verificado';

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
    return 'Você deve escrever no idioma a seguir: $language!';
  }

  @override
  String get settingsSystemMessage => 'Mensagem do sistema';

  @override
  String get settingsUseSystem => 'Usar mensagem do sistema';

  @override
  String get settingsUseSystemDescription => 'Desativa a configuração da mensagem do sistema acima e usa a do modelo em vez disso. Pode ser útil para modelos com arquivos de modelo';

  @override
  String get settingsDisableMarkdown => 'Desativar markdown';

  @override
  String get settingsBehaviorNotUpdatedForOlderChats => 'As configurações de comportamento não são atualizadas para conversas mais antigas';

  @override
  String get settingsShowModelTags => 'Mostrar tags dos modelos';

  @override
  String get settingsPreloadModels => 'Pré-carregar modelos';

  @override
  String get settingsResetOnModelChange => 'Redefinir ao mudar de modelo';

  @override
  String get settingsRequestTypeStream => 'Stream';

  @override
  String get settingsRequestTypeRequest => 'Request';

  @override
  String get settingsGenerateTitles => 'Gerar títulos';

  @override
  String get settingsEnableEditing => 'Edição de mensagens';

  @override
  String get settingsAskBeforeDelete => 'Perguntar antes de excluir a conversa';

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
    return 'Manter o modelo carregado por $minutes minutos';
  }

  @override
  String get settingsTimeoutMultiplier => 'Multiplicador de tempo limite';

  @override
  String get settingsTimeoutMultiplierDescription => 'Selecione o multiplicador aplicado a todos os valores de tempo limite no aplicativo. Pode ser útil com uma conexão de internet lenta ou um host lento.';

  @override
  String get settingsTimeoutMultiplierExample => 'Por exemplo, o tempo limite da mensagem:';

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
  String get settingsTemporaryFixesDescription => 'Ative correções temporárias para problemas de interface.\nMantenha pressionado sobre as opções individuais para saber mais.';

  @override
  String get settingsTemporaryFixesInstructions => 'Não ative nenhuma dessas configurações a menos que saiba o que está fazendo! As soluções indicadas podem não funcionar como esperado.\nElas não podem ser consideradas definitivas nem julgadas como tais. Problemas podem ocorrer.';

  @override
  String get settingsTemporaryFixesNoFixes => 'Nenhuma correção disponível';

  @override
  String get settingsVoicePermissionLoading => 'Carregando permissões de voz ...';

  @override
  String get settingsVoiceTtsNotSupported => 'Síntese de voz não compatível';

  @override
  String get settingsVoiceTtsNotSupportedDescription => 'Os serviços de síntese de voz não são compatíveis com o idioma selecionado. Selecione outro idioma no painel de idiomas para reativá-los.\nOutros serviços, como reconhecimento de voz e raciocínio da IA, continuarão funcionando normalmente, mas a interação pode não ser tão fluida.';

  @override
  String get settingsVoicePermissionNot => 'Permissões não concedidas';

  @override
  String get settingsVoiceNotEnabled => 'Modo de voz não ativado';

  @override
  String get settingsVoiceNotSupported => 'Modo de voz não compatível';

  @override
  String get settingsVoiceEnable => 'Ativar modo de voz';

  @override
  String get settingsVoiceNoLanguage => 'Nenhum idioma selecionado';

  @override
  String get settingsVoiceLimitLanguage => 'Limitar ao idioma selecionado';

  @override
  String get settingsVoicePunctuation => 'Ativar pontuação pela IA';

  @override
  String get settingsExportChats => 'Exportar conversas';

  @override
  String get settingsExportChatsSuccess => 'Conversas exportadas com sucesso';

  @override
  String get settingsImportChats => 'Importar conversas';

  @override
  String get settingsImportChatsTitle => 'Importar';

  @override
  String get settingsImportChatsDescription => 'A etapa a seguir importará as conversas do arquivo selecionado. Isso substituirá todas as conversas disponíveis atualmente.\nDeseja continuar?';

  @override
  String get settingsImportChatsImport => 'Importar e apagar';

  @override
  String get settingsImportChatsCancel => 'Cancelar';

  @override
  String get settingsImportChatsSuccess => 'Conversas importadas com sucesso';

  @override
  String get settingsExportInfo => 'Esta opção permite exportar e importar seu histórico de conversas. Isso pode ser útil se você quiser transferir seu histórico de conversas para outro dispositivo ou fazer backup do seu histórico de conversas';

  @override
  String get settingsExportWarning => 'Vários históricos de conversas não serão mesclados! Você perderá seu histórico de conversas atual se importar um novo';

  @override
  String get settingsUpdateCheck => 'Verificar atualizações';

  @override
  String get settingsUpdateChecking => 'Verificando atualizações ...';

  @override
  String get settingsUpdateLatest => 'Você está na versão mais recente';

  @override
  String settingsUpdateAvailable(String version) {
    return 'Atualização disponível (v$version)';
  }

  @override
  String get settingsUpdateRateLimit => 'Não é possível verificar, limite de requisições da API excedido';

  @override
  String get settingsUpdateIssue => 'Ocorreu um problema';

  @override
  String get settingsUpdateDialogTitle => 'Nova versão disponível';

  @override
  String get settingsUpdateDialogDescription => 'Uma nova versão do Ollama está disponível. Deseja baixá-la e instalá-la agora?';

  @override
  String get settingsUpdateChangeLog => 'Registro de alterações';

  @override
  String get settingsUpdateDialogUpdate => 'Atualizar';

  @override
  String get settingsUpdateDialogCancel => 'Cancelar';

  @override
  String get settingsCheckForUpdates => 'Verificar atualizações ao abrir';

  @override
  String get settingsGithub => 'GitHub';

  @override
  String get settingsReportIssue => 'Relatar problema';

  @override
  String get settingsLicenses => 'Licenças';

  @override
  String settingsVersion(String version) {
    return 'Ollama App v$version';
  }

  @override
  String get settingsDescriptionAccessibility => 'Declaração de acessibilidade, resultados de testes e como relatar um problema.';

  @override
  String get accessibilityCommitmentIntro => 'O Ollama precisa ser utilizável por pessoas de todas as habilidades, em todos os idiomas em que é oferecido. Controle por voz, leitores de tela, navegação por teclado e renderização em alto contraste são formas de uso deste aplicativo tão importantes quanto quaisquer outras — não algo secundário.';

  @override
  String get accessibilityCommitmentDetails => 'Na prática, isso significa: todo controle interativo tem um nome anunciado pelos leitores de tela (incluindo o estado do modo de voz), os botões mantêm uma área de toque mínima de 48dp, o foco do teclado segue a ordem visual da interface, as mensagens de status são anunciadas enquanto mudam e a interface permanece utilizável em escalas de texto grandes e nos temas claro e escuro.';

  @override
  String get accessibilityConformanceTitle => 'Status de conformidade';

  @override
  String get accessibilityConformanceStatus => 'Este aplicativo foi projetado para estar em conformidade com as Diretrizes de Acessibilidade para Conteúdo Web (WCAG) 2.2 Level AA. A conformidade não foi certificada de forma independente por terceiros; ela se baseia em nossos próprios testes automatizados. Sempre que possível, vamos além do AA e aplicamos medidas WCAG AAA, listadas abaixo.';

  @override
  String get accessibilityAaaMeasuresTitle => 'Excedendo o AA (medidas AAA)';

  @override
  String get accessibilityAaaMeasures => 'O texto principal usa contraste de 21:1 em ambos os temas (o AAA exige 7:1), o texto secundário atenuado usa 10:1 ou melhor, as cores de status de sucesso e avisos atendem ao contraste AAA em ambos os temas e o texto de erro no tema escuro atende ao contraste AAA. O AAA exige adicionalmente medidas que não são práticas em um aplicativo de conversa deste tamanho (por exemplo, contraste de 7:1 em absolutamente todo o texto e limites de nível de leitura), por isso temos o AA como garantia e tratamos essas medidas AAA como aprimoramentos.';

  @override
  String get accessibilityAodaTitle => 'Accessibility for Ontarians with Disabilities Act (AODA)';

  @override
  String get accessibilityAodaText => 'A Accessibility for Ontarians with Disabilities Act (AODA) de Ontário exige que produtos digitais atendam ao WCAG 2.0/2.1 Level AA. A meta WCAG 2.2 Level AA deste aplicativo atende e excede esse patamar. Feedback sobre acessibilidade é bem-vindo por meio do formulário de contato nesta página, em conformidade com a exigência da AODA de tornar os canais de feedback acessíveis.';

  @override
  String get accessibilityStandardsEuropeTitle => 'Padrões europeus (EN 301 549)';

  @override
  String get accessibilityStandardsEuropeText => 'Na União Europeia, a norma harmonizada EN 301 549 define os requisitos de acessibilidade de TIC do Ato Europeu de Acessibilidade, que referencia o WCAG 2.1 Level AA. A meta WCAG 2.2 Level AA deste aplicativo cobre esses requisitos, apoiando as obrigações de acessibilidade europeias que se aplicam a partir de 28 de junho de 2025.';

  @override
  String get accessibilityStandardsUsTitle => 'Padrões dos Estados Unidos (ADA / Section 508)';

  @override
  String get accessibilityStandardsUsText => 'Nos Estados Unidos, a Lei dos Americanos com Deficiências (ADA) é a base geral de não discriminação, e a Section 508 do Rehabilitation Act exige o WCAG 2.0 Level AA para tecnologia federal (a Section 504 estende obrigações semelhantes a programas financiados). A meta WCAG 2.2 Level AA deste aplicativo atende e excede esses patamares.';

  @override
  String get accessibilityKnownIssues => 'Os botões da barra de título da janela de desktop (minimizar, maximizar, fechar) são fornecidos pela integração com o sistema operacional e não são alcançáveis pela árvore do leitor de tela do aplicativo. A biblioteca de conversa renderiza uma pequena quantidade de seu próprio texto de interface, que pode ainda não estar disponível em todos os idiomas. No modo de voz, o texto da resposta é esmaecido perto da borda da tela e linhas de conversa muito longas podem ser truncadas com reticências quando o tamanho de texto do sistema é aumentado significativamente.';

  @override
  String get accessibilityTestsTitle => 'Resultados de testes';

  @override
  String get accessibilityTestsIntro => 'As seguintes verificações automatizadas de acessibilidade fazem parte do conjunto de testes deste aplicativo e são executadas a cada commit:';

  @override
  String get accessibilityTestsStatusColumn => 'Status';

  @override
  String get accessibilityTestsCiNote => 'O conjunto completo (análise estática mais testes automatizados) é executado a cada commit no pipeline de integração contínua.';

  @override
  String get accessibilityTestContrast => 'O contraste de texto atende aos níveis WCAG nos temas claro e escuro';

  @override
  String get accessibilityTestLabeledTapTarget => 'Alvos tocáveis têm rótulos para leitores de tela';

  @override
  String get accessibilityTestAndroidTapTarget => 'Alvos de toque têm pelo menos 48x48dp (diretriz do Android)';

  @override
  String get accessibilityTestIosTapTarget => 'Alvos de toque têm pelo menos 44x44dp (diretriz do iOS)';

  @override
  String get accessibilityTestSemanticsPresent => 'Há rótulos para leitores de tela em todos os controles personalizados';

  @override
  String get accessibilityTestTraversalOrder => 'A ordem de foco do teclado segue a ordem visual';

  @override
  String get accessibilityTestLocalesRender => 'Todos os idiomas da interface são renderizados sem erros';

  @override
  String get accessibilityTestFormValidation => 'Os campos de formulário anunciam erros de validação';

  @override
  String get accessibilityContactTitle => 'Relatar um problema de acessibilidade';

  @override
  String get accessibilityContactIntro => 'Use este formulário para solicitar informações de acessibilidade, pedir uma solução ou relatar uma barreira de acessibilidade. Seu relatório é composto em uma mensagem que você pode enviar por e-mail ou como uma issue pública no GitHub.';

  @override
  String get accessibilityFormAssistiveTech => 'Tecnologia assistiva usada (opcional)';

  @override
  String get accessibilityFormDescriptionHint => 'O que você estava tentando fazer e o que atrapalhou?';

  @override
  String get accessibilityFormErrorEmail => 'Informe um endereço de e-mail válido ou deixe o campo vazio.';

  @override
  String get accessibilityFormSendGithub => 'Abrir uma issue no GitHub';

  @override
  String get accessibilityFormCopiedFallback => 'Não foi possível abrir o link. O relatório foi copiado para a área de transferência.';

  @override
  String get tooltipResetChat => 'Redefinir a conversa atual';

  @override
  String get tooltipVoiceSettings => 'Abrir as configurações de voz';

  @override
  String get tooltipVoiceScrollToEnd => 'Rolar até o texto mais recente';

  @override
  String get tooltipWelcomeNext => 'Próxima página';

  @override
  String get tooltipWelcomeFinish => 'Começar a usar o Ollama';

  @override
  String get accessibilityVoiceOrbListening => 'O modo de voz está ouvindo. Toque para parar de ouvir.';

  @override
  String get accessibilityVoiceOrbSpeaking => 'A resposta está sendo lida em voz alta. Toque para parar.';

  @override
  String get accessibilityVoiceOrbThinking => 'A IA está preparando uma resposta. Toque para cancelar.';

  @override
  String get accessibilityWelcomePage1 => 'Bem-vindo ao Ollama. Esta introdução mostra três imagens curtas.';

  @override
  String get accessibilityWelcomePage2 => 'Página 2 de 3 da introdução. A imagem mostra como selecionar um modelo e começar a conversar.';

  @override
  String get accessibilityWelcomePage3 => 'Página 3 de 3 da introdução. A imagem mostra onde encontrar as configurações e o modo de voz.';

  @override
  String get accessibilitySummaryConformance => 'Este aplicativo tem como meta o WCAG 2.2 Level AA e aplica aprimoramentos de nível AAA. Alguns recursos têm limitações, descritas dentro de cada seção.';

  @override
  String get accessibilitySectionStatementSummary => 'Nosso compromisso, status de conformidade e as medidas que aplicamos além do AA.';

  @override
  String get accessibilitySectionTestsSummary => '8 verificações automatizadas de acessibilidade são aprovadas em cada build.';

  @override
  String get accessibilitySectionStandardsSummary => 'Como oferecemos suporte à AODA, à norma europeia EN 301 549 e à ADA / Section 508 dos EUA.';

  @override
  String get accessibilitySectionContactSummary => 'Relate um problema de acessibilidade por e-mail ou GitHub. Respondemos a todos os relatórios.';

  @override
  String get accessibilitySupportLevelCompliantWithLimitations => 'Em conformidade com limitações';
}