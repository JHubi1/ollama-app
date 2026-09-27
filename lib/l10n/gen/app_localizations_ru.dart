// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Ollama';

  @override
  String get optionNewChat => 'Новый чат';

  @override
  String get optionSettings => 'Настройки';

  @override
  String get optionInstallPwa => 'Установить веб-приложение';

  @override
  String get optionNoChatFound => 'Чаты не найдены';

  @override
  String get tipPrefix => 'Совет: ';

  @override
  String get tip0 => 'Редактируйте сообщения долгим нажатием на них';

  @override
  String get tip1 => 'Удаляйте сообщения двойным нажатием на них';

  @override
  String get tip2 => 'Тему можно изменить в настройках';

  @override
  String get tip3 => 'Выберите мультимодальную модель, чтобы отправлять изображения';

  @override
  String get tip4 => 'Чаты сохраняются автоматически';

  @override
  String get deleteChat => 'Удалить';

  @override
  String get renameChat => 'Переименовать';

  @override
  String get takeImage => 'Сделать снимок';

  @override
  String get uploadImage => 'Загрузить изображение';

  @override
  String get notAValidImage => 'Некорректное изображение';

  @override
  String get imageOnlyConversation => 'Разговор только с изображениями';

  @override
  String get messageInputPlaceholder => 'Сообщение';

  @override
  String get tooltipAttachment => 'Добавить вложение';

  @override
  String get tooltipSend => 'Отправить';

  @override
  String get tooltipSave => 'Сохранить';

  @override
  String get tooltipLetAIThink => 'Пусть ИИ подумает';

  @override
  String get tooltipAddHostHeaders => 'Добавить заголовки хоста';

  @override
  String get tooltipReset => 'Сбросить текущий чат';

  @override
  String get tooltipOptions => 'Показать параметры';

  @override
  String get noModelSelected => 'Модель не выбрана';

  @override
  String get noHostSelected => 'Хост не выбран, откройте настройки, чтобы задать его';

  @override
  String get noSelectedModel => '<селектор>';

  @override
  String get newChatTitle => 'Безымянный чат';

  @override
  String get modelDialogAddModel => 'Добавить';

  @override
  String get modelDialogAddPromptTitle => 'Добавить новую модель';

  @override
  String get modelDialogAddPromptDescription => 'Это может быть обычное имя (например, \'llama3\') или имя с тегом (например, \'llama3:70b\').';

  @override
  String get modelDialogAddPromptAlreadyExists => 'Модель уже существует';

  @override
  String get modelDialogAddPromptInvalid => 'Некорректное имя модели';

  @override
  String get modelDialogAddAllowanceTitle => 'Разрешить прокси';

  @override
  String get modelDialogAddAllowanceDescription => 'Приложению Ollama App необходимо проверить, что введённая модель существует. Обычно для этого мы отправляем веб-запрос к списку моделей Ollama и проверяем код ответа, но, поскольку вы используете веб-клиент, сделать это напрямую нельзя. Вместо этого приложение отправит запрос к другому API, размещённому JHubi1, чтобы проверить это за нас.\nЭто разовый запрос, и он будет отправлен только при добавлении новой модели.\nВместе с запросом будет отправлен ваш IP-адрес, который может храниться до десяти минут для защиты от спама с потенциально вредоносными целями.\nЕсли вы согласны, ваш выбор будет запомнен на будущее; если нет, ничего не будет отправлено, и модель не будет добавлена.';

  @override
  String get modelDialogAddAllowanceAllow => 'Разрешить';

  @override
  String get modelDialogAddAllowanceDeny => 'Отклонить';

  @override
  String modelDialogAddAssuranceTitle(String model) {
    return 'Добавить $model?';
  }

  @override
  String modelDialogAddAssuranceDescription(String model) {
    return 'Нажав «Добавить», вы скачаете модель \'$model\' напрямую с сервера Ollama на ваш хост.\nЭто может занять время в зависимости от вашего интернет-соединения. Действие нельзя отменить.\nЕсли приложение будет закрыто во время загрузки, она продолжится, когда вы снова введёте имя в диалоге моделей.';
  }

  @override
  String get modelDialogAddAssuranceAdd => 'Добавить';

  @override
  String get modelDialogAddAssuranceCancel => 'Отмена';

  @override
  String get modelDialogAddDownloadPercentLoading => 'загрузка прогресса';

  @override
  String modelDialogAddDownloadPercent(String percent) {
    return 'загрузка на $percent%';
  }

  @override
  String get modelDialogAddDownloadFailed => 'Соединение потеряно, попробуйте снова';

  @override
  String get modelDialogAddDownloadSuccess => 'Загрузка успешно завершена';

  @override
  String get deleteDialogTitle => 'Удалить чат';

  @override
  String get deleteDialogDescription => 'Вы уверены, что хотите продолжить? Это сотрёт всю память об этом чате, и действие нельзя будет отменить.\nЧтобы отключить этот диалог, зайдите в настройки.';

  @override
  String get deleteDialogDelete => 'Удалить';

  @override
  String get deleteDialogCancel => 'Отмена';

  @override
  String get dialogEnterNewTitle => 'Введите новый заголовок';

  @override
  String get dialogEditMessageTitle => 'Редактировать сообщение';

  @override
  String get settingsTitleBehavior => 'Поведение';

  @override
  String get settingsDescriptionBehavior => 'Настройте поведение ИИ по своему вкусу.';

  @override
  String get settingsTitleInterface => 'Интерфейс';

  @override
  String get settingsDescriptionInterface => 'Настройте внешний вид и поведение Ollama App.';

  @override
  String get settingsTitleVoice => 'Голос';

  @override
  String get settingsDescriptionVoice => 'Включите голосовой режим и настройте параметры голоса.';

  @override
  String get settingsTitleExport => 'Экспорт';

  @override
  String get settingsDescriptionExport => 'Экспортируйте и импортируйте историю чатов.';

  @override
  String get settingsTitleAbout => 'О программе';

  @override
  String get settingsDescriptionAbout => 'Проверяйте наличие обновлений и узнавайте больше о Ollama App.';

  @override
  String get settingsSavedAutomatically => 'Настройки сохраняются автоматически';

  @override
  String get settingsExperimentalAlpha => 'альфа';

  @override
  String get settingsExperimentalAlphaDescription => 'Эта функция находится на стадии альфы и может работать не так, как задумано или ожидается.\nКритические проблемы и/или необратимый серьёзный ущерб устройству и/или используемым сервисам нельзя исключать.\nИспользуйте на свой страх и риск. Автор приложения ответственности не несёт.';

  @override
  String get settingsExperimentalAlphaFeature => 'Альфа-функция, удерживайте, чтобы узнать больше';

  @override
  String get settingsExperimentalBeta => 'бета';

  @override
  String get settingsExperimentalBetaDescription => 'Эта функция находится на стадии беты и может работать не так, как задумано или ожидается.\nМенее серьёзные проблемы могут возникать, а могут и нет. Ущерб не должен быть критическим.\nИспользуйте на свой страх и риск.';

  @override
  String get settingsExperimentalBetaFeature => 'Бета-функция, удерживайте, чтобы узнать больше';

  @override
  String get settingsExperimentalDeprecated => 'устарело';

  @override
  String get settingsExperimentalDeprecatedDescription => 'Эта функция устарела и будет удалена в будущей версии.\nОна может работать не так, как задумано или ожидается. Используйте на свой страх и риск.';

  @override
  String get settingsExperimentalDeprecatedFeature => 'Устаревшая функция, удерживайте, чтобы узнать больше';

  @override
  String get settingsHost => 'Хост';

  @override
  String get settingsHostValid => 'Хост действителен';

  @override
  String get settingsHostChecking => 'Проверка хоста';

  @override
  String settingsHostInvalid(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': 'Некорректный URL',
        'host': 'Некорректный хост',
        'auth': 'Ошибка аутентификации',
        'timeout': 'Запрос не удался. Проблемы на сервере',
        'ratelimit': 'Слишком много запросов',
        'other': 'Запрос не удался',
      },
    );
    return 'Проблема: $_temp0';
  }

  @override
  String get settingsHostHeaderTitle => 'Задать заголовок хоста';

  @override
  String get settingsHostHeaderInvalid => 'Введённый текст не является корректным JSON-объектом заголовков';

  @override
  String settingsHostInvalidDetailed(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': 'Введённый URL недействителен. Используйте полный URL, начинающийся с http:// или https:// — например, http://localhost:11434 для локального сервера Ollama или https://ollama.com для Ollama Cloud. Не добавляйте завершающий слэш или путь /api.',
        'host': 'Введённый хост недействителен. Он недоступен. Проверьте хост и попробуйте снова.',
        'auth': 'Сервер отклонил запрос (401/403). Если вы подключаетесь к Ollama Cloud (https://ollama.com), введите ваш API-ключ в поле токена ниже — его можно создать или скопировать на https://ollama.com/keys — и сохраните его. Если вы используете собственный сервер, проверьте заголовок Authorization, настроенный для этого хоста.',
        'other': 'Введённый хост недействителен. Он недоступен. Проверьте хост и попробуйте снова.',
      },
    );
    return '$_temp0';
  }

  @override
  String get settingsApiTokenInvalid => 'API-токен отклонён';

  @override
  String get settingsApiTokenInvalidDetailed => 'API-токен отклонён сервером (401/403). Убедитесь, что он скопирован в точности так, как показано на https://ollama.com/keys — на этой странице можно создать новый ключ — и сохраните его снова. Токен должен быть задан, пока хост — https://ollama.com.';

  @override
  String get settingsApiTokenVerified => 'API-токен сохранён и проверен';

  @override
  String get settingsApiToken => 'API-токен Ollama Cloud';

  @override
  String get settingsApiTokenHint => 'Вставьте токен с ollama.com';

  @override
  String get tooltipShowToken => 'Показать токен';

  @override
  String get tooltipHideToken => 'Скрыть токен';

  @override
  String voiceLanguageInstruction(String language) {
    return 'Вы должны писать на следующем языке: $language!';
  }

  @override
  String get settingsSystemMessage => 'Системное сообщение';

  @override
  String get settingsUseSystem => 'Использовать системное сообщение';

  @override
  String get settingsUseSystemDescription => 'Отключает установку системного сообщения выше и использует вместо него сообщение модели. Может быть полезно для моделей с файлами моделей';

  @override
  String get settingsDisableMarkdown => 'Отключить Markdown';

  @override
  String get settingsBehaviorNotUpdatedForOlderChats => 'Настройки поведения не обновляются для старых чатов';

  @override
  String get settingsShowModelTags => 'Показывать теги моделей';

  @override
  String get settingsPreloadModels => 'Предзагрузка моделей';

  @override
  String get settingsResetOnModelChange => 'Сброс при смене модели';

  @override
  String get settingsRequestTypeStream => 'Поток';

  @override
  String get settingsRequestTypeRequest => 'Запрос';

  @override
  String get settingsGenerateTitles => 'Генерировать названия';

  @override
  String get settingsEnableEditing => 'Редактирование сообщений';

  @override
  String get settingsAskBeforeDelete => 'Спрашивать перед удалением чата';

  @override
  String get settingsShowTips => 'Показывать советы в боковой панели';

  @override
  String get settingsKeepModelLoadedAlways => 'Всегда держать модель загруженной';

  @override
  String get settingsKeepModelLoadedNever => 'Не держать модель загруженной';

  @override
  String get settingsKeepModelLoadedFor => 'Задать время удержания модели загруженной';

  @override
  String settingsKeepModelLoadedSet(String minutes) {
    return 'Держать модель загруженной $minutes мин.';
  }

  @override
  String get settingsTimeoutMultiplier => 'Множитель тайм-аута';

  @override
  String get settingsTimeoutMultiplierDescription => 'Выберите множитель, который применяется к каждому значению тайм-аута в приложении. Может быть полезно при медленном интернет-соединении или медленном хосте.';

  @override
  String get settingsTimeoutMultiplierExample => 'Например, тайм-аут сообщения:';

  @override
  String get settingsEnableHapticFeedback => 'Включить тактильный отклик';

  @override
  String get settingsMaximizeOnStart => 'Запускать в развёрнутом виде';

  @override
  String get settingsBrightnessSystem => 'Системная';

  @override
  String get settingsBrightnessLight => 'Светлая';

  @override
  String get settingsBrightnessDark => 'Тёмная';

  @override
  String get settingsThemeDevice => 'Устройство';

  @override
  String get settingsThemeOllama => 'Ollama';

  @override
  String get settingsTemporaryFixes => 'Временные исправления интерфейса';

  @override
  String get settingsTemporaryFixesDescription => 'Включите временные исправления для проблем интерфейса.\nУдерживайте нажатие на отдельных параметрах, чтобы узнать больше.';

  @override
  String get settingsTemporaryFixesInstructions => 'Не включайте ни одну из этих настроек, если не знаете, что делаете! Предложенные решения могут работать не так, как ожидается.\nИх нельзя считать окончательными, и оценивать их следует именно так. Возможны проблемы.';

  @override
  String get settingsTemporaryFixesNoFixes => 'Нет доступных исправлений';

  @override
  String get settingsVoicePermissionLoading => 'Загрузка разрешений голосового режима ...';

  @override
  String get settingsVoiceTtsNotSupported => 'Синтез речи не поддерживается';

  @override
  String get settingsVoiceTtsNotSupportedDescription => 'Сервисы синтеза речи не поддерживаются для выбранного языка. Выберите другой язык в панели выбора языка, чтобы снова включить их.\nДругие сервисы, такие как распознавание речи и «мышление» ИИ, будут работать как обычно, но взаимодействие может быть менее плавным.';

  @override
  String get settingsVoicePermissionNot => 'Разрешения не предоставлены';

  @override
  String get settingsVoiceNotEnabled => 'Голосовой режим не включён';

  @override
  String get settingsVoiceNotSupported => 'Голосовой режим не поддерживается';

  @override
  String get settingsVoiceEnable => 'Включить голосовой режим';

  @override
  String get settingsVoiceNoLanguage => 'Язык не выбран';

  @override
  String get settingsVoiceLimitLanguage => 'Ограничить выбранным языком';

  @override
  String get settingsVoicePunctuation => 'Включить пунктуацию ИИ';

  @override
  String get settingsExportChats => 'Экспортировать чаты';

  @override
  String get settingsExportChatsSuccess => 'Чаты успешно экспортированы';

  @override
  String get settingsImportChats => 'Импортировать чаты';

  @override
  String get settingsImportChatsTitle => 'Импорт';

  @override
  String get settingsImportChatsDescription => 'Следующий шаг импортирует чаты из выбранного файла. Это перезапишет все текущие чаты.\nВы хотите продолжить?';

  @override
  String get settingsImportChatsImport => 'Импортировать и стереть';

  @override
  String get settingsImportChatsCancel => 'Отмена';

  @override
  String get settingsImportChatsSuccess => 'Чаты успешно импортированы';

  @override
  String get settingsExportInfo => 'Эта опция позволяет экспортировать и импортировать историю чатов. Это может пригодиться, если вы хотите перенести историю чатов на другое устройство или создать её резервную копию';

  @override
  String get settingsExportWarning => 'Несколько историй чатов не будут объединены! Если вы импортируете новую историю, вы потеряете текущую';

  @override
  String get settingsUpdateCheck => 'Проверить обновления';

  @override
  String get settingsUpdateChecking => 'Проверка обновлений ...';

  @override
  String get settingsUpdateLatest => 'У вас последняя версия';

  @override
  String settingsUpdateAvailable(String version) {
    return 'Доступно обновление (v$version)';
  }

  @override
  String get settingsUpdateRateLimit => 'Не удалось проверить: превышен лимит запросов API';

  @override
  String get settingsUpdateIssue => 'Произошла ошибка';

  @override
  String get settingsUpdateDialogTitle => 'Доступна новая версия';

  @override
  String get settingsUpdateDialogDescription => 'Доступна новая версия Ollama. Скачать и установить её сейчас?';

  @override
  String get settingsUpdateChangeLog => 'Журнал изменений';

  @override
  String get settingsUpdateDialogUpdate => 'Обновить';

  @override
  String get settingsUpdateDialogCancel => 'Отмена';

  @override
  String get settingsCheckForUpdates => 'Проверять обновления при запуске';

  @override
  String get settingsGithub => 'GitHub';

  @override
  String get settingsReportIssue => 'Сообщить о проблеме';

  @override
  String get settingsLicenses => 'Лицензии';

  @override
  String settingsVersion(String version) {
    return 'Ollama App v$version';
  }
}