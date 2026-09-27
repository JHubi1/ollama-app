// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Ollama';

  @override
  String get optionNewChat => '新建聊天';

  @override
  String get optionSettings => '设置';

  @override
  String get optionInstallPwa => '安装 Webapp';

  @override
  String get optionNoChatFound => '暂无聊天消息';

  @override
  String get tipPrefix => '提示： ';

  @override
  String get tip0 => '长按编辑消息';

  @override
  String get tip1 => '双击删除消息';

  @override
  String get tip2 => '您可以在设置中更改主题';

  @override
  String get tip3 => '选择一个多模态模型来输入图像';

  @override
  String get tip4 => '聊天记录会自动保存';

  @override
  String get deleteChat => '删除';

  @override
  String get renameChat => '重命名';

  @override
  String get takeImage => '拍摄图像';

  @override
  String get uploadImage => '上传图像';

  @override
  String get notAValidImage => '不是一个有效的图片文件.';

  @override
  String get imageOnlyConversation => '仅图片对话';

  @override
  String get messageInputPlaceholder => '消息';

  @override
  String get tooltipAttachment => '添加附件';

  @override
  String get tooltipSend => '发送';

  @override
  String get tooltipSave => '保存';

  @override
  String get tooltipLetAIThink => '让AI思考';

  @override
  String get tooltipAddHostHeaders => '设置主机请求头';

  @override
  String get tooltipReset => '重置当前聊天';

  @override
  String get tooltipOptions => '显示选项';

  @override
  String get noModelSelected => '未选择模型';

  @override
  String get noHostSelected => '没有填写主机地址，请打开设置以进行设置';

  @override
  String get noSelectedModel => '<模型选择>';

  @override
  String get newChatTitle => '未命名的聊天';

  @override
  String get modelDialogAddModel => '添加';

  @override
  String get modelDialogAddPromptTitle => '添加新模型';

  @override
  String get modelDialogAddPromptDescription => '可以是一个普通名称(如：\'llama3\')，也可以是名称加标签(如：\'llama3:70b\')。';

  @override
  String get modelDialogAddPromptAlreadyExists => '模型已存在';

  @override
  String get modelDialogAddPromptInvalid => '无效的模型名称';

  @override
  String get modelDialogAddAllowanceTitle => '允许代理服务器';

  @override
  String get modelDialogAddAllowanceDescription => 'Ollama 应用程序必须检查输入的模型是否有效。 为此，我们通常向Ollama模型列表发送一个网络请求并检查状态。 由于您正在使用 Web 客户端，我们不能直接做到这一点。 因此，应用将把请求发送到另一个由 JHubi 1 部署的api 上进行检查。\n这是一个一次性请求，只有当您添加一个新模型时才会发送。\n您的IP地址将与请求一起发送，可能会被存储长达10分钟，以防止潜在的有害故障。\n如果您接受，您的选择将在将来被记住；如果不接受，将不会发送任何内容，也不会添加模型。';

  @override
  String get modelDialogAddAllowanceAllow => '允许';

  @override
  String get modelDialogAddAllowanceDeny => '拒绝';

  @override
  String modelDialogAddAssuranceTitle(String model) {
    return '添加$model?';
  }

  @override
  String modelDialogAddAssuranceDescription(String model) {
    return '按下“添加”将直接从 Ollama 服务器下载模型“$model”到您的主机。\n这可能需要一些时间，取决于您的互联网连接。该操作不能被取消。\n如果在下载过程中关闭应用，当您再次在模型对话框中输入名称，它将恢复之前的下载。';
  }

  @override
  String get modelDialogAddAssuranceAdd => '添加';

  @override
  String get modelDialogAddAssuranceCancel => '取消';

  @override
  String get modelDialogAddDownloadPercentLoading => '加载进度';

  @override
  String modelDialogAddDownloadPercent(String percent) {
    return '已下载 $percent%';
  }

  @override
  String get modelDialogAddDownloadFailed => '连接断开，请重试';

  @override
  String get modelDialogAddDownloadSuccess => '下载成功';

  @override
  String get deleteDialogTitle => '删除聊天';

  @override
  String get deleteDialogDescription => '您确定要继续吗？这将删除此聊天的所有记录，且无法撤消。\n要禁用此对话框，请访问设置。';

  @override
  String get deleteDialogDelete => '删除';

  @override
  String get deleteDialogCancel => '取消';

  @override
  String get dialogEnterNewTitle => '输入新标题';

  @override
  String get dialogEditMessageTitle => '编辑消息';

  @override
  String get settingsTitleBehavior => '行为';

  @override
  String get settingsDescriptionBehavior => '根据您的喜好修改AI的行为';

  @override
  String get settingsTitleInterface => '界面';

  @override
  String get settingsDescriptionInterface => '修改 Ollama App的外观和行为';

  @override
  String get settingsTitleVoice => '语音';

  @override
  String get settingsDescriptionVoice => '启用语音模式并进行设置。';

  @override
  String get settingsTitleExport => '导出';

  @override
  String get settingsDescriptionExport => '导出和导入您的聊天记录。';

  @override
  String get settingsTitleAbout => '关于';

  @override
  String get settingsDescriptionAbout => '检查更新并了解更多关于Ollama App的信息。';

  @override
  String get settingsSavedAutomatically => '设置已自动保存';

  @override
  String get settingsExperimentalAlpha => 'alpha';

  @override
  String get settingsExperimentalAlphaDescription => '此功能处于 Alpha 测试阶段，可能无法按预期工作。\n无法排除会对设备、服务造成严重问题或永久性重大损害。\n使用需自行承担风险。应用作者不承担任何责任。';

  @override
  String get settingsExperimentalAlphaFeature => 'Alpha功能，按住以了解更多';

  @override
  String get settingsExperimentalBeta => 'beta';

  @override
  String get settingsExperimentalBetaDescription => '此功能处于 Beta 测试阶段，可能无法按预期工作。\n可能会出现较轻微的问题，损害预期不严重。\n使用需自行承担风险。';

  @override
  String get settingsExperimentalBetaFeature => 'Beta测试版功能，按住以了解更多';

  @override
  String get settingsExperimentalDeprecated => '已弃用';

  @override
  String get settingsExperimentalDeprecatedDescription => '此功能已被弃用，并将在将来的版本中删除。\n它可能无法像预期的那样工作。请自行承担风险。';

  @override
  String get settingsExperimentalDeprecatedFeature => '已弃用的功能，按住以了解更多';

  @override
  String get settingsHost => '主机地址';

  @override
  String get settingsHostValid => '有效主机地址';

  @override
  String get settingsHostChecking => '正在检查主机地址';

  @override
  String settingsHostInvalid(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': '无效的URL',
        'host': '无效的主机地址',
        'auth': '身份验证失败',
        'timeout': '请求失败。服务器问题',
        'other': '请求失败',
      },
    );
    return '问题：$_temp0';
  }

  @override
  String get settingsHostHeaderTitle => '设置主机请求头';

  @override
  String get settingsHostHeaderInvalid => '输入的文本不是有效的标题 JSON 对象';

  @override
  String settingsHostInvalidDetailed(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': '您输入的 URL 无效。请使用以 http:// 或 https:// 开头的完整 URL——例如本地 Ollama 服务器用 http://localhost:11434，Ollama Cloud 用 https://ollama.com。末尾不要加斜杠，也不要加 /api 路径。',
        'host': '您输入的主机地址无效。无法连接。请检查主机地址并再试一次',
        'auth': '服务器拒绝了请求（401/403）。如果您连接的是 Ollama Cloud（https://ollama.com），请在下方的令牌字段中输入您的 API 密钥——可在 https://ollama.com/keys 创建或复制——然后保存。如果您使用自托管服务器，请检查为主机配置的 Authorization 标头。',
        'other': '您输入的主机地址无效。无法连接。请检查主机地址并再试一次',
      },
    );
    return '$_temp0';
  }

  @override
  String get settingsApiTokenInvalid => 'API 令牌被拒绝';

  @override
  String get settingsApiTokenInvalidDetailed => '服务器拒绝了 API 令牌（401/403）。请检查是否按照 https://ollama.com/keys 页面显示的内容完整复制——也可以在该页面创建新密钥——然后重新保存。令牌需在主机为 https://ollama.com 时设置。';

  @override
  String get settingsApiTokenVerified => 'API 令牌已保存并通过验证';

  @override
  String get settingsApiToken => 'Ollama Cloud API 令牌';

  @override
  String get settingsApiTokenHint => '粘贴来自 ollama.com 的令牌';

  @override
  String get tooltipShowToken => '显示令牌';

  @override
  String get tooltipHideToken => '隐藏令牌';

  @override
  String voiceLanguageInstruction(String language) {
    return '你必须使用以下语言书写：$language！';
  }

  @override
  String get settingsSystemMessage => '系统信息';

  @override
  String get settingsUseSystem => '使用系统信息';

  @override
  String get settingsUseSystemDescription => '使用模型内嵌代替系统级别的消息。对于具有模型描述文件的模型可能会有用。';

  @override
  String get settingsDisableMarkdown => '禁用Markdown';

  @override
  String get settingsBehaviorNotUpdatedForOlderChats => '行为设置未针对旧聊天进行更新';

  @override
  String get settingsShowModelTags => '显示模型标签';

  @override
  String get settingsPreloadModels => '预加载模型';

  @override
  String get settingsResetOnModelChange => '模型更改时重置';

  @override
  String get settingsRequestTypeStream => '流式';

  @override
  String get settingsRequestTypeRequest => '请求';

  @override
  String get settingsGenerateTitles => '生成标题';

  @override
  String get settingsEnableEditing => '启用消息编辑';

  @override
  String get settingsAskBeforeDelete => '删除聊天前确认';

  @override
  String get settingsShowTips => '在侧边栏显示提示';

  @override
  String get settingsKeepModelLoadedAlways => '始终保持模型加载';

  @override
  String get settingsKeepModelLoadedNever => '不保持模型加载';

  @override
  String get settingsKeepModelLoadedFor => '设置模型加载的时间';

  @override
  String settingsKeepModelLoadedSet(String minutes) {
    return '保持模型加载 $minutes 分钟';
  }

  @override
  String get settingsTimeoutMultiplier => '超时时间倍倍数';

  @override
  String get settingsTimeoutMultiplierDescription => '选择应用程序中每个超时时间的倍数。适用于较慢的网络连接或远程主机。';

  @override
  String get settingsTimeoutMultiplierExample => '例如：消息超时：';

  @override
  String get settingsEnableHapticFeedback => '启用触觉反馈';

  @override
  String get settingsMaximizeOnStart => '最大化';

  @override
  String get settingsBrightnessSystem => '系统';

  @override
  String get settingsBrightnessLight => '明亮';

  @override
  String get settingsBrightnessDark => '黑暗';

  @override
  String get settingsThemeDevice => '设备主题';

  @override
  String get settingsThemeOllama => 'Ollama主题';

  @override
  String get settingsTemporaryFixes => '临时界面修复';

  @override
  String get settingsTemporaryFixesDescription => '启用界面问题的临时修复。\n长按选项以了解更多信息。';

  @override
  String get settingsTemporaryFixesInstructions => '不要切换这些设置，除非你知道自己在做什么！描述的行为可能不会按照预期工作。\n它们不能被视为最终结果。可能会导致一些问题。';

  @override
  String get settingsTemporaryFixesNoFixes => '没有可用的修复';

  @override
  String get settingsVoicePermissionLoading => '加载语音权限...';

  @override
  String get settingsVoiceTtsNotSupported => '不支持文本转语音';

  @override
  String get settingsVoiceTtsNotSupportedDescription => '所选的语言不支持文字转语音服务，您可能需要选择其他语言以启用该功能。\n语音识别和 AI 等其他服务仍可正常工作，但交互可能无法流畅运行。';

  @override
  String get settingsVoicePermissionNot => '未授予权限';

  @override
  String get settingsVoiceNotEnabled => '语音模式未启用';

  @override
  String get settingsVoiceNotSupported => '不支持语音模式';

  @override
  String get settingsVoiceEnable => '启用语音模式';

  @override
  String get settingsVoiceNoLanguage => '未选择语言';

  @override
  String get settingsVoiceLimitLanguage => '限制为所选语言';

  @override
  String get settingsVoicePunctuation => '启用AI标点';

  @override
  String get settingsExportChats => '导出聊天记录';

  @override
  String get settingsExportChatsSuccess => '聊天记录导出成功';

  @override
  String get settingsImportChats => '导入聊天记录';

  @override
  String get settingsImportChatsTitle => '导入';

  @override
  String get settingsImportChatsDescription => '以下步骤将从所选文件导入聊天记录。这将覆盖所有当前的聊天记录。\n您要继续吗？';

  @override
  String get settingsImportChatsImport => '导入并删除';

  @override
  String get settingsImportChatsCancel => '取消';

  @override
  String get settingsImportChatsSuccess => '聊天记录导入成功';

  @override
  String get settingsExportInfo => '这个选项允许您导出和导入您的聊天记录。如果您想将聊天记录转移到另一台设备或备份您的聊天记录，这可能会很有用。';

  @override
  String get settingsExportWarning => '多个聊天记录将不会合并！如果导入新的聊天记录，您将丢失当前的聊天记录';

  @override
  String get settingsUpdateCheck => '检查更新';

  @override
  String get settingsUpdateChecking => '检查更新中...';

  @override
  String get settingsUpdateLatest => '当前为最新版本';

  @override
  String settingsUpdateAvailable(String version) {
    return '有可用更新 (v$version)';
  }

  @override
  String get settingsUpdateRateLimit => '无法检查，API使用已超过速率限制';

  @override
  String get settingsUpdateIssue => '更新服务出错';

  @override
  String get settingsUpdateDialogTitle => '有可用的新版本';

  @override
  String get settingsUpdateDialogDescription => 'Ollama有新版本可用。是否下载并安装？';

  @override
  String get settingsUpdateChangeLog => '更新日志';

  @override
  String get settingsUpdateDialogUpdate => '更新';

  @override
  String get settingsUpdateDialogCancel => '取消';

  @override
  String get settingsCheckForUpdates => '启动时检查更新';

  @override
  String get settingsGithub => 'GitHub';

  @override
  String get settingsReportIssue => '问题反馈';

  @override
  String get settingsLicenses => '开源许可证';

  @override
  String settingsVersion(String version) {
    return 'Ollama App v$version';
  }

  @override
  String get settingsTitleAccessibility => '无障碍';

  @override
  String get settingsDescriptionAccessibility => '无障碍声明、测试结果以及如何报告问题。';

  @override
  String get accessibilityStatementTitle => '无障碍声明';

  @override
  String get accessibilityCommitmentIntro => 'Ollama 必须让我们发布的每一种语言下、所有能力的人群都能使用。语音控制、屏幕阅读器、键盘导航和高对比度渲染是使用本应用的一等公民方式，而非事后补充。';

  @override
  String get accessibilityCommitmentDetails => '具体而言：每个交互控件都有一个屏幕阅读器会播报的名称（包括语音模式的状态），按钮保持至少 48dp 的最小触控目标，键盘焦点遵循界面的视觉顺序，状态消息在变化时播报，并且界面在大字号以及明亮和黑暗主题下都保持可用。';

  @override
  String get accessibilityConformanceTitle => '符合性状态';

  @override
  String get accessibilityConformanceStatus => '本应用的设计符合《网页内容无障碍指南》(WCAG) 2.2 Level AA。该符合性尚未由第三方独立认证；其依据是我们自己的自动化测试。在可行的情况下，我们超越 AA 并采用 WCAG AAA 措施，如下所列。';

  @override
  String get accessibilityAaaMeasuresTitle => '超越 AA（AAA 措施）';

  @override
  String get accessibilityAaaMeasures => '主要文本在两种主题下使用 21:1 对比度（AAA 要求 7:1），次要的灰暗文本使用 10:1 或更高，成功与警告状态颜色在两种主题下均满足 AAA 对比度，黑暗主题下的错误文本满足 AAA 对比度。AAA 还额外要求一些在这种规模的聊天应用中并不切实际的措施（例如对所有文本一律 7:1 对比度以及阅读水平限制），因此我们以 AA 作为保证，并将这些 AAA 措施视为增强。';

  @override
  String get accessibilityAodaTitle => '《安大略省残障人士无障碍法》(AODA)';

  @override
  String get accessibilityAodaText => '安大略省《安大略残障人士无障碍法》(AODA) 要求数字产品达到 WCAG 2.0/2.1 Level AA。本应用的 WCAG 2.2 Level AA 目标达到并超越了该基准。欢迎通过本页面的联系表单提供无障碍方面的反馈，这符合 AODA 关于使反馈渠道无障碍的要求。';

  @override
  String get accessibilityStandardsEuropeTitle => '欧洲标准 (EN 301 549)';

  @override
  String get accessibilityStandardsEuropeText => '在欧盟，协调标准 EN 301 549 定义了《欧洲无障碍法案》的信息通信技术无障碍要求，该法案引用了 WCAG 2.1 Level AA。本应用的 WCAG 2.2 Level AA 目标涵盖了这些要求，支持自 2025年6月28日起适用的欧洲无障碍义务。';

  @override
  String get accessibilityStandardsUsTitle => '美国标准 (ADA / Section 508)';

  @override
  String get accessibilityStandardsUsText => '在美国，《美国残疾人法》(ADA) 是一般性的非歧视基准，而《康复法》的 Section 508 要求数字产品达到 WCAG 2.0 Level AA（Section 504 将类似义务扩展到受资助的项目）。本应用的 WCAG 2.2 Level AA 目标达到并超越了这些基准。';

  @override
  String get accessibilityKnownIssuesTitle => '已知限制';

  @override
  String get accessibilityKnownIssues => '桌面窗口标题栏按钮（最小化、最大化、关闭）由操作系统集成提供，应用的屏幕阅读器树无法访问它们。聊天库会渲染少量自身的界面文本，这些文本可能尚未提供所有语言版本。在语音模式下，响应文本在屏幕边缘附近渐隐，当系统文字尺寸显著增大时，很长的聊天行可能会被省略号截断。';

  @override
  String accessibilityLastValidated(String version) {
    return '自动化检查最后一次验证针对 Ollama App v$version。';
  }

  @override
  String get accessibilityTestsTitle => '测试结果';

  @override
  String get accessibilityTestsIntro => '以下自动化无障碍检查属于本应用的测试套件，并在每次提交时运行：';

  @override
  String get accessibilityTestsCheckColumn => '检查项';

  @override
  String get accessibilityTestsStatusColumn => '状态';

  @override
  String get accessibilityTestsPass => '通过';

  @override
  String get accessibilityTestsCiNote => '完整套件（静态分析加自动化测试）在持续集成流水线中对每次提交运行。';

  @override
  String get accessibilityTestContrast => '文本对比度在明亮和黑暗主题下均满足 WCAG 等级';

  @override
  String get accessibilityTestLabeledTapTarget => '可点按的目标具有屏幕阅读器标签';

  @override
  String get accessibilityTestAndroidTapTarget => '触控目标至少为 48x48dp（Android 准则）';

  @override
  String get accessibilityTestIosTapTarget => '触控目标至少为 44x44dp（iOS 准则）';

  @override
  String get accessibilityTestSemanticsPresent => '所有自定义控件都有屏幕阅读器标签';

  @override
  String get accessibilityTestTraversalOrder => '键盘焦点顺序遵循视觉顺序';

  @override
  String get accessibilityTestLocalesRender => '所有界面语言均能正常渲染';

  @override
  String get accessibilityTestFormValidation => '表单字段播报验证错误';

  @override
  String get accessibilityContactTitle => '报告无障碍问题';

  @override
  String get accessibilityContactIntro => '使用此表单索取无障碍信息、请求解决方案，或报告无障碍使用障碍。您的报告将被编写成一条消息，您可以通过电子邮件发送，或在 GitHub 上作为公开 issue 提交。';

  @override
  String get accessibilityFormName => '姓名（可选）';

  @override
  String get accessibilityFormEmail => '电子邮件（可选）';

  @override
  String get accessibilityFormAssistiveTech => '使用的辅助技术（可选）';

  @override
  String get accessibilityFormDescription => '描述问题（必填）';

  @override
  String get accessibilityFormDescriptionHint => '您原本想做什么？是什么阻碍了您？';

  @override
  String get accessibilityFormErrorDescription => '发送前请描述问题。';

  @override
  String get accessibilityFormErrorEmail => '请输入有效的电子邮件地址，或将该字段留空。';

  @override
  String get accessibilityFormSendEmail => '通过电子邮件发送';

  @override
  String get accessibilityFormSendGithub => '创建 GitHub issue';

  @override
  String get accessibilityFormEmailSubject => '无障碍报告 (Ollama App)';

  @override
  String get accessibilityFormCopiedFallback => '无法打开链接。报告已复制到剪贴板。';

  @override
  String get tooltipResetChat => '重置当前聊天';

  @override
  String get tooltipVoiceClose => '关闭语音模式';

  @override
  String get tooltipVoiceSettings => '打开语音设置';

  @override
  String get tooltipVoiceScrollToEnd => '滚动到最新文本';

  @override
  String get tooltipWelcomeNext => '下一页';

  @override
  String get tooltipWelcomeFinish => '开始使用 Ollama';

  @override
  String get accessibilityVoiceOrbListening => '语音模式正在聆听。点按以停止聆听。';

  @override
  String get accessibilityVoiceOrbSpeaking => '正在朗读响应。点按以停止。';

  @override
  String get accessibilityVoiceOrbThinking => 'AI 正在准备响应。点按以取消。';

  @override
  String get accessibilityAppLogo => 'Ollama';

  @override
  String get accessibilityWelcomePage1 => '欢迎使用 Ollama。本引导流程展示三张简短图片。';

  @override
  String get accessibilityWelcomePage2 => '引导页面第 2 页，共 3 页。图片展示如何选择模型并开始聊天。';

  @override
  String get accessibilityWelcomePage3 => '引导页面第 3 页，共 3 页。图片显示在哪里可以找到设置和语音模式。';

  @override
  String get accessibilitySummaryConformance => '本应用以 WCAG 2.2 Level AA 为目标，并采用 AAA 级别的增强措施。部分功能存在限制，详见各章节内的说明。';

  @override
  String get accessibilitySectionStatementSummary => '我们的承诺、符合性状态，以及我们超越 AA 所采用的措施。';

  @override
  String get accessibilitySectionTestsSummary => '每次构建中 8 项自动化无障碍检查全部通过。';

  @override
  String get accessibilitySectionStandardsSummary => '我们如何支持 AODA、欧洲标准 EN 301 549 以及美国 ADA / Section 508。';

  @override
  String get accessibilitySectionContactSummary => '通过电子邮件或 GitHub 报告无障碍问题。我们会回复所有报告。';

  @override
  String get accessibilitySupportLevelLimited => '有限支持';

  @override
  String get accessibilitySupportLevelCompliantWithLimitations => '符合标准（存在限制）';
}
