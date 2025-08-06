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
  String get modelDialogAddPromptDescription =>
      '可以是一个普通名称(如：\'llama3\')，也可以是名称加标签(如：\'llama3:70b\')。';

  @override
  String get modelDialogAddPromptAlreadyExists => '模型已存在';

  @override
  String get modelDialogAddPromptInvalid => '无效的模型名称';

  @override
  String get modelDialogAddAllowanceTitle => '允许代理服务器';

  @override
  String get modelDialogAddAllowanceDescription =>
      'Ollama 应用程序必须检查输入的模型是否有效。 为此，我们通常向Ollama模型列表发送一个网络请求并检查状态。 由于您正在使用 Web 客户端，我们不能直接做到这一点。 因此，应用将把请求发送到另一个由 JHubi 1 部署的api 上进行检查。\n这是一个一次性请求，只有当您添加一个新模型时才会发送。\n您的IP地址将与请求一起发送，可能会被存储长达10分钟，以防止潜在的有害故障。\n如果您接受，您的选择将在将来被记住；如果不接受，将不会发送任何内容，也不会添加模型。';

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
  String get deleteDialogDescription =>
      '您确定要继续吗？这将删除此聊天的所有记录，且无法撤消。\n要禁用此对话框，请访问设置。';

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
  String get settingsExperimentalAlphaDescription =>
      '此功能处于 Alpha 测试阶段，可能无法按预期工作。\n无法排除会对设备、服务造成严重问题或永久性重大损害。\n使用需自行承担风险。应用作者不承担任何责任。';

  @override
  String get settingsExperimentalAlphaFeature => 'Alpha功能，按住以了解更多';

  @override
  String get settingsExperimentalBeta => 'beta';

  @override
  String get settingsExperimentalBetaDescription =>
      '此功能处于 Beta 测试阶段，可能无法按预期工作。\n可能会出现较轻微的问题，损害预期不严重。\n使用需自行承担风险。';

  @override
  String get settingsExperimentalBetaFeature => 'Beta测试版功能，按住以了解更多';

  @override
  String get settingsExperimentalDeprecated => '已弃用';

  @override
  String get settingsExperimentalDeprecatedDescription =>
      '此功能已被弃用，并将在将来的版本中删除。\n它可能无法像预期的那样工作。请自行承担风险。';

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
        'url': '您输入的 URL 无效。它不是一个标准的 URL 格式。',
        'other': '您输入的主机地址无效。无法连接。请检查主机地址并再试一次',
      },
    );
    return '$_temp0';
  }

  @override
  String get settingsSystemMessage => '系统信息';

  @override
  String get settingsUseSystem => '使用系统信息';

  @override
  String get settingsUseSystemDescription =>
      '使用模型内嵌代替系统级别的消息。对于具有模型描述文件的模型可能会有用。';

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
  String get settingsTimeoutMultiplierDescription =>
      '选择应用程序中每个超时时间的倍数。适用于较慢的网络连接或远程主机。';

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
  String get settingsTemporaryFixesInstructions =>
      '不要切换这些设置，除非你知道自己在做什么！描述的行为可能不会按照预期工作。\n它们不能被视为最终结果。可能会导致一些问题。';

  @override
  String get settingsTemporaryFixesNoFixes => '没有可用的修复';

  @override
  String get settingsVoicePermissionLoading => '加载语音权限...';

  @override
  String get settingsVoiceTtsNotSupported => '不支持文本转语音';

  @override
  String get settingsVoiceTtsNotSupportedDescription =>
      '所选的语言不支持文字转语音服务，您可能需要选择其他语言以启用该功能。\n语音识别和 AI 等其他服务仍可正常工作，但交互可能无法流畅运行。';

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
  String get settingsImportChatsDescription =>
      '以下步骤将从所选文件导入聊天记录。这将覆盖所有当前的聊天记录。\n您要继续吗？';

  @override
  String get settingsImportChatsImport => '导入并删除';

  @override
  String get settingsImportChatsCancel => '取消';

  @override
  String get settingsImportChatsSuccess => '聊天记录导入成功';

  @override
  String get settingsExportInfo =>
      '这个选项允许您导出和导入您的聊天记录。如果您想将聊天记录转移到另一台设备或备份您的聊天记录，这可能会很有用。';

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
}
