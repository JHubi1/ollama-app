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

  @override
  String get settingsTitleAccessibility => 'Доступность';

  @override
  String get settingsDescriptionAccessibility => 'Заявление о доступности, результаты тестов и способ сообщить о проблеме.';

  @override
  String get accessibilityStatementTitle => 'Заявление о доступности';

  @override
  String get accessibilityCommitmentIntro => 'Ollama должна быть удобна для людей с любыми возможностями, на каждом языке, который мы поддерживаем. Голосовое управление, программы чтения с экрана, навигация с клавиатуры и отображение в высоком контрасте — полноправные способы работы с этим приложением, а не второстепенные дополнения.';

  @override
  String get accessibilityCommitmentDetails => 'На практике это означает: каждый интерактивный элемент управления имеет имя, которое озвучивает программа чтения с экрана (включая состояние голосового режима), кнопки сохраняют минимальную зону нажатия 48dp, фокус с клавиатуры следует визуальному порядку интерфейса, сообщения о состоянии озвучиваются при их изменении, а интерфейс остаётся удобным при крупном масштабе текста и в светлой, и в тёмной темах.';

  @override
  String get accessibilityConformanceTitle => 'Статус соответствия';

  @override
  String get accessibilityConformanceStatus => 'Это приложение разработано с учётом требований Руководства по доступности веб-контента (WCAG) 2.2 Level AA. Соответствие не сертифицировано независимой третьей стороной; оно основано на нашем собственном автоматическом тестировании. Там, где это возможно, мы выходим за рамки AA и применяем меры уровня WCAG AAA, перечисленные ниже.';

  @override
  String get accessibilityAaaMeasuresTitle => 'Превышение AA (меры AAA)';

  @override
  String get accessibilityAaaMeasures => 'Основной текст использует контраст 21:1 в обеих темах (AAA требует 7:1), приглушённый вторичный текст — 10:1 или выше, цвета состояний успеха и предупреждений соответствуют контрасту AAA в обеих темах, а текст ошибок в тёмной теме соответствует контрасту AAA. AAA дополнительно требует меры, непрактичные в чат-приложении такого размера (например, контраст 7:1 для абсолютно всего текста и ограничения по уровню чтения), поэтому мы гарантируем AA, а эти меры AAA считаем дополнительными улучшениями.';

  @override
  String get accessibilityAodaTitle => 'Закон о доступности для онтарийцев с ограниченными возможностями (AODA)';

  @override
  String get accessibilityAodaText => 'Закон Онтарио о доступности для онтарийцев с ограниченными возможностями (AODA) требует, чтобы цифровые продукты соответствовали WCAG 2.0/2.1 Level AA. Цель этого приложения — WCAG 2.2 Level AA — достигает этого базового уровня и превышает его. Отзывы о доступности приветствуются через форму обратной связи на этой странице, в соответствии с требованием AODA делать каналы обратной связи доступными.';

  @override
  String get accessibilityStandardsEuropeTitle => 'Европейские стандарты (EN 301 549)';

  @override
  String get accessibilityStandardsEuropeText => 'В Европейском союзе гармонизированный стандарт EN 301 549 определяет требования к доступности ИКТ, установленные Европейским актом о доступности, который ссылается на WCAG 2.1 Level AA. Цель этого приложения — WCAG 2.2 Level AA — охватывает эти требования, поддерживая европейские обязательства по доступности, действующие с 28 июня 2025 г.';

  @override
  String get accessibilityStandardsUsTitle => 'Стандарты США (ADA / Section 508)';

  @override
  String get accessibilityStandardsUsText => 'В Соединённых Штатах Закон об американцах с ограниченными возможностями (ADA) является общим базовым стандартом запрета дискриминации, а Section 508 Закона о реабилитации требует соответствия WCAG 2.0 Level AA для федеральных технологий (Section 504 распространяет аналогичные обязательства на финансируемые программы). Цель этого приложения — WCAG 2.2 Level AA — достигает этих базовых уровней и превышает их.';

  @override
  String get accessibilityKnownIssuesTitle => 'Известные ограничения';

  @override
  String get accessibilityKnownIssues => 'Кнопки в заголовке окна настольной версии (свернуть, развернуть, закрыть) предоставляются интеграцией с операционной системой и недоступны в дереве программы чтения с экрана приложения. Библиотека чата отрисовывает небольшой объём собственного текста интерфейса, который может быть ещё не доступен на всех языках. В голосовом режиме текст ответа затухает у края экрана, а очень длинные строки чата могут обрезаться многоточием при значительном увеличении системного размера текста.';

  @override
  String accessibilityLastValidated(String version) {
    return 'Автоматические проверки в последний раз выполнялись для Ollama App v$version.';
  }

  @override
  String get accessibilityTestsTitle => 'Результаты тестов';

  @override
  String get accessibilityTestsIntro => 'Следующие автоматические проверки доступности входят в набор тестов этого приложения и выполняются при каждом коммите:';

  @override
  String get accessibilityTestsCheckColumn => 'Проверка';

  @override
  String get accessibilityTestsStatusColumn => 'Статус';

  @override
  String get accessibilityTestsPass => 'Пройдено';

  @override
  String get accessibilityTestsCiNote => 'Полный набор (статический анализ и автоматические тесты) выполняется при каждом коммите в конвейере непрерывной интеграции.';

  @override
  String get accessibilityTestContrast => 'Контраст текста соответствует уровням WCAG в светлой и тёмной темах';

  @override
  String get accessibilityTestLabeledTapTarget => 'Нажимаемые цели имеют подписи для программ чтения с экрана';

  @override
  String get accessibilityTestAndroidTapTarget => 'Цели касания не менее 48x48dp (рекомендация Android)';

  @override
  String get accessibilityTestIosTapTarget => 'Цели касания не менее 44x44dp (рекомендация iOS)';

  @override
  String get accessibilityTestSemanticsPresent => 'Подписи для программ чтения с экрана существуют для всех пользовательских элементов управления';

  @override
  String get accessibilityTestTraversalOrder => 'Порядок фокуса с клавиатуры следует визуальному порядку';

  @override
  String get accessibilityTestLocalesRender => 'Все языки интерфейса отрисовываются без ошибок';

  @override
  String get accessibilityTestFormValidation => 'Поля формы озвучивают ошибки валидации';

  @override
  String get accessibilityContactTitle => 'Сообщить о проблеме доступности';

  @override
  String get accessibilityContactIntro => 'Используйте эту форму, чтобы запросить информацию о доступности, попросить решить проблему или сообщить о барьере доступности. Ваше сообщение будет сформировано в виде письма, которое можно отправить по электронной почте или как публичный issue на GitHub.';

  @override
  String get accessibilityFormName => 'Имя (необязательно)';

  @override
  String get accessibilityFormEmail => 'Электронная почта (необязательно)';

  @override
  String get accessibilityFormAssistiveTech => 'Используемая ассистивная технология (необязательно)';

  @override
  String get accessibilityFormDescription => 'Опишите проблему (обязательно)';

  @override
  String get accessibilityFormDescriptionHint => 'Что вы пытались сделать и что вам помешало?';

  @override
  String get accessibilityFormErrorDescription => 'Опишите проблему перед отправкой.';

  @override
  String get accessibilityFormErrorEmail => 'Введите корректный адрес электронной почты или оставьте поле пустым.';

  @override
  String get accessibilityFormSendEmail => 'Отправить по электронной почте';

  @override
  String get accessibilityFormSendGithub => 'Открыть issue на GitHub';

  @override
  String get accessibilityFormEmailSubject => 'Отчёт о доступности (Ollama App)';

  @override
  String get accessibilityFormCopiedFallback => 'Не удалось открыть ссылку. Отчёт скопирован в буфер обмена.';

  @override
  String get tooltipResetChat => 'Сбросить текущий чат';

  @override
  String get tooltipVoiceClose => 'Закрыть голосовой режим';

  @override
  String get tooltipVoiceSettings => 'Открыть настройки голоса';

  @override
  String get tooltipVoiceScrollToEnd => 'Прокрутить к последнему тексту';

  @override
  String get tooltipWelcomeNext => 'Следующая страница';

  @override
  String get tooltipWelcomeFinish => 'Начать использовать Ollama';

  @override
  String get accessibilityVoiceOrbListening => 'Голосовой режим слушает. Нажмите, чтобы остановить прослушивание.';

  @override
  String get accessibilityVoiceOrbSpeaking => 'Ответ зачитывается вслух. Нажмите, чтобы остановить.';

  @override
  String get accessibilityVoiceOrbThinking => 'ИИ готовит ответ. Нажмите, чтобы отменить.';

  @override
  String get accessibilityAppLogo => 'Ollama';

  @override
  String get accessibilityWelcomePage1 => 'Добро пожаловать в Ollama. Это обучение показывает три коротких изображения.';

  @override
  String get accessibilityWelcomePage2 => 'Страница онбординга 2 из 3. На изображении показано, как выбрать модель и начать чат.';

  @override
  String get accessibilityWelcomePage3 => 'Страница онбординга 3 из 3. На изображении показано, где найти настройки и голосовой режим.';

  @override
  String get accessibilitySummaryConformance => 'Цель этого приложения — WCAG 2.2 Level AA, также применяются улучшения уровня AAA. Некоторые функции имеют ограничения, описанные внутри каждого раздела.';

  @override
  String get accessibilitySectionStatementSummary => 'Наше обязательство, статус соответствия и меры, которые мы применяем сверх AA.';

  @override
  String get accessibilitySectionTestsSummary => '8 автоматических проверок доступности проходят при каждой сборке.';

  @override
  String get accessibilitySectionStandardsSummary => 'Как мы поддерживаем AODA, европейский стандарт EN 301 549 и ADA / Section 508 США.';

  @override
  String get accessibilitySectionContactSummary => 'Сообщите о проблеме доступности по электронной почте или на GitHub. Мы отвечаем на все обращения.';

  @override
  String get accessibilitySupportLevelLimited => 'Ограниченная поддержка';

  @override
  String get accessibilitySupportLevelCompliantWithLimitations => 'Соответствует с ограничениями';
}