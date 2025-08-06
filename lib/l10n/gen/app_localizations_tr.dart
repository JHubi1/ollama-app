// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Ollama';

  @override
  String get optionNewChat => 'Yeni Sohbet';

  @override
  String get optionSettings => 'Ayarlar';

  @override
  String get optionInstallPwa => 'Web Uygulamasını Yükle';

  @override
  String get optionNoChatFound => 'Sohbet bulunamadı';

  @override
  String get tipPrefix => 'İpucu: ';

  @override
  String get tip0 => 'Mesajları düzenlemek için üzerlerine uzun basın';

  @override
  String get tip1 => 'Mesajları silmek için üzerlerine çift dokunun';

  @override
  String get tip2 => 'Temayı ayarlardan değiştirebilirsiniz';

  @override
  String get tip3 => 'Görsel girmek için çoklu modlu bir model seçin';

  @override
  String get tip4 => 'Sohbetler otomatik olarak kaydedilir';

  @override
  String get deleteChat => 'Sil';

  @override
  String get renameChat => 'Yeniden adlandır';

  @override
  String get takeImage => 'Fotoğraf Çek';

  @override
  String get uploadImage => 'Görsel Yükle';

  @override
  String get notAValidImage => 'Geçerli bir görsel değil';

  @override
  String get imageOnlyConversation => 'Sadece Görsel İçeren Konuşma';

  @override
  String get messageInputPlaceholder => 'Mesaj';

  @override
  String get tooltipAttachment => 'Ek ekle';

  @override
  String get tooltipSend => 'Gönder';

  @override
  String get tooltipSave => 'Kaydet';

  @override
  String get tooltipLetAIThink => 'AI\'\'nın düşünmesine izin ver';

  @override
  String get tooltipAddHostHeaders => 'Ana bilgisayar başlıkları ekle';

  @override
  String get tooltipReset => 'Mevcut sohbeti sıfırla';

  @override
  String get tooltipOptions => 'Seçenekleri göster';

  @override
  String get noModelSelected => 'Model seçilmedi';

  @override
  String get noHostSelected =>
      'Ana bilgisayar seçilmedi, ayarları açıp bir tane belirleyin';

  @override
  String get noSelectedModel => '<seçici>';

  @override
  String get newChatTitle => 'İsimsiz Sohbet';

  @override
  String get modelDialogAddModel => 'Ekle';

  @override
  String get modelDialogAddPromptTitle => 'Yeni model ekle';

  @override
  String get modelDialogAddPromptDescription =>
      'Bu normal bir isim (örneğin \'llama3\') ya da isim ve etiket (örneğin \'llama3:70b\') olabilir.';

  @override
  String get modelDialogAddPromptAlreadyExists => 'Model zaten mevcut';

  @override
  String get modelDialogAddPromptInvalid => 'Geçersiz model adı';

  @override
  String get modelDialogAddAllowanceTitle => 'Proxy\'e İzin Ver';

  @override
  String get modelDialogAddAllowanceDescription =>
      'Ollama Uygulaması, girilen modelin geçerli olup olmadığını kontrol etmelidir. Bunun için normalde Ollama model listesine bir web isteği gönderir ve durum kodunu kontrol ederiz, ancak siz web istemcisini kullandığınız için bunu doğrudan yapamayız. Bunun yerine, uygulama bizim için kontrol etmek amacıyla JHubi1 tarafından barındırılan farklı bir API\'ye istek gönderecek. \nBu, yalnızca bir kez yapılan bir istektir ve yalnızca yeni bir model eklediğinizde gönderilecektir. \nIP adresiniz istekle birlikte gönderilecek ve olası zararlı niyetlerle spam yapılmasını önlemek amacıyla on dakikaya kadar saklanabilir. \nKabul ederseniz, seçiminiz gelecekte hatırlanacaktır; kabul etmezseniz, hiçbir şey gönderilmeyecek ve model eklenmeyecektir.';

  @override
  String get modelDialogAddAllowanceAllow => 'İzin ver';

  @override
  String get modelDialogAddAllowanceDeny => 'Reddet';

  @override
  String modelDialogAddAssuranceTitle(String model) {
    return '$model Ekle?';
  }

  @override
  String modelDialogAddAssuranceDescription(String model) {
    return '\'Ekle\' tuşuna basmak, \'$model\' modelini doğrudan Ollama sunucusundan bilgisayarınıza indirecektir. İnternet bağlantınıza bağlı olarak bu işlem biraz zaman alabilir. Bu işlem iptal edilemez. Uygulama indirme sırasında kapatılırsa, model adını tekrar model diyaloguna girerseniz indirme işlemi kaldığı yerden devam eder.';
  }

  @override
  String get modelDialogAddAssuranceAdd => 'Ekle';

  @override
  String get modelDialogAddAssuranceCancel => 'İptal';

  @override
  String get modelDialogAddDownloadPercentLoading => 'yükleme ilerleme durumu';

  @override
  String modelDialogAddDownloadPercent(String percent) {
    return '%$percent oranında indir';
  }

  @override
  String get modelDialogAddDownloadFailed =>
      'Bağlantı kesildi, yeniden deneyin';

  @override
  String get modelDialogAddDownloadSuccess => 'İndirme tamamlandı';

  @override
  String get deleteDialogTitle => 'Sohbeti Sil';

  @override
  String get deleteDialogDescription =>
      'Devam etmek istediğinizden emin misiniz? Bu işlem, bu sohbetin tüm hafızasını silecek ve geri alınamaz.\nBu dialogu devre dışı bırakmak için ayarları ziyaret edin.';

  @override
  String get deleteDialogDelete => 'Sil';

  @override
  String get deleteDialogCancel => 'İptal';

  @override
  String get dialogEnterNewTitle => 'Yeni başlık girin';

  @override
  String get dialogEditMessageTitle => 'Mesajı düzenle';

  @override
  String get settingsTitleBehavior => 'Davranış';

  @override
  String get settingsDescriptionBehavior =>
      'Yapay zekanın davranışını istediğiniz gibi değiştirin.';

  @override
  String get settingsTitleInterface => 'Arayüz';

  @override
  String get settingsDescriptionInterface =>
      'Ollama Uygulamasının görünümünü ve davranışını düzenleyin.';

  @override
  String get settingsTitleVoice => 'Ses';

  @override
  String get settingsDescriptionVoice =>
      'Ses modunu etkinleştirin ve ses ayarlarını yapılandırın.';

  @override
  String get settingsTitleExport => 'Dışa Aktar';

  @override
  String get settingsDescriptionExport =>
      'Sohbet geçmişinizi dışa ve içe aktarın.';

  @override
  String get settingsTitleAbout => 'Hakkında';

  @override
  String get settingsDescriptionAbout =>
      'Güncellemeleri kontrol edin ve Ollama Uygulaması hakkında daha fazla bilgi edinin.';

  @override
  String get settingsSavedAutomatically => 'Ayarlar otomatik olarak kaydedilir';

  @override
  String get settingsExperimentalAlpha => 'alfa';

  @override
  String get settingsExperimentalAlphaDescription =>
      'Bu özellik alfa aşamasındadır ve beklendiği gibi çalışmayabilir.\nKritik sorunlar ve/veya cihaza ve/veya kullanılan hizmetlere kalıcı kritik hasar verilebilme ihtimali göz ardı edilemez.\nKendi sorumluluğunuzda kullanın. Uygulama yazarının hiçbir sorumluluğu yoktur.';

  @override
  String get settingsExperimentalAlphaFeature =>
      'Alfa özelliği, daha fazla bilgi için basılı tutun';

  @override
  String get settingsExperimentalBeta => 'beta';

  @override
  String get settingsExperimentalBetaDescription =>
      'Bu özellik beta aşamasındadır ve beklendiği gibi çalışmayabilir.\nDaha az ciddi sorunlar ortaya çıkabilir. Hasar kritik olmamalıdır.\nKendi sorumluluğunuzda kullanın.';

  @override
  String get settingsExperimentalBetaFeature =>
      'Beta özelliği, daha fazla bilgi için basılı tutun';

  @override
  String get settingsExperimentalDeprecated => 'kullanım dışı';

  @override
  String get settingsExperimentalDeprecatedDescription =>
      'Bu özellik kullanımdan kaldırılmıştır ve gelecekteki bir sürümde kaldırılacaktır.\nAmaçlandığı veya beklendiği gibi çalışmayabilir. Kullanım riski size aittir.';

  @override
  String get settingsExperimentalDeprecatedFeature =>
      'Kullanımdan kaldırılan özellik, daha fazla bilgi için bekleyin';

  @override
  String get settingsHost => 'Ana bilgisayar';

  @override
  String get settingsHostValid => 'Geçerli Ana Bilgisayar';

  @override
  String get settingsHostChecking => 'Ana Bilgisayar Kontrol Ediliyor';

  @override
  String settingsHostInvalid(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': 'Geçersiz URL',
        'host': 'Geçersiz Ana Bilgisayar',
        'timeout': 'İstek Başarısız. Sunucu sorunları',
        'ratelimit': 'Çok fazla istek',
        'other': 'İstek Başarısız',
      },
    );
    return 'Sorun: $_temp0';
  }

  @override
  String get settingsHostHeaderTitle => 'Ana bilgisayar başlığını ayarla';

  @override
  String get settingsHostHeaderInvalid =>
      'Girilen metin geçerli bir başlık JSON nesnesi değil';

  @override
  String settingsHostInvalidDetailed(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': 'Girdiğiniz URL geçersiz. Standart bir URL formatında değil.',
        'other':
            'Girdiğiniz ana bilgisayar geçersiz. Ulaşılamıyor. Lütfen ana bilgisayarı kontrol edin ve tekrar deneyin.',
      },
    );
    return '$_temp0';
  }

  @override
  String get settingsSystemMessage => 'Sistem mesajı';

  @override
  String get settingsUseSystem => 'Sistem mesajını kullan';

  @override
  String get settingsUseSystemDescription =>
      'Yukarıdaki sistem mesajını ayarlamayı devre dışı bırakır ve bunun yerine modelin mesajını kullanır. Model dosyaları olan modeller için yararlı olabilir';

  @override
  String get settingsDisableMarkdown => 'Markdown\'\'ı devre dışı bırak';

  @override
  String get settingsBehaviorNotUpdatedForOlderChats =>
      'Davranış ayarları eski sohbetler için güncellenmez';

  @override
  String get settingsShowModelTags => 'Model etiketlerini göster';

  @override
  String get settingsPreloadModels => 'Ön yükleme modelleri';

  @override
  String get settingsResetOnModelChange => 'Model değiştiğinde sıfırla';

  @override
  String get settingsRequestTypeStream => 'Akış';

  @override
  String get settingsRequestTypeRequest => 'İstek';

  @override
  String get settingsGenerateTitles => 'Başlıklar oluştur';

  @override
  String get settingsEnableEditing => 'Mesaj düzenlemeyi etkinleştir';

  @override
  String get settingsAskBeforeDelete => 'Sohbet silmeden önce sor';

  @override
  String get settingsShowTips => 'Kenar çubuğunda ipuçlarını göster';

  @override
  String get settingsKeepModelLoadedAlways => 'Modeli her zaman yüklü tut';

  @override
  String get settingsKeepModelLoadedNever => 'Modeli yüklü tutma';

  @override
  String get settingsKeepModelLoadedFor =>
      'Modelin yüklü kalacağı belirli bir süre ayarla';

  @override
  String settingsKeepModelLoadedSet(String minutes) {
    return 'Modeli $minutes dakika boyunca yüklü tut';
  }

  @override
  String get settingsTimeoutMultiplier => 'Zaman aşımı çarpanı';

  @override
  String get settingsTimeoutMultiplierDescription =>
      'Uygulamadaki her zaman aşımı değerine uygulanacak çarpanı seçin. Yavaş bir internet bağlantısı veya yavaş bir ana bilgisayar ile yararlı olabilir.';

  @override
  String get settingsTimeoutMultiplierExample => 'Örn. mesaj zaman aşımı:';

  @override
  String get settingsEnableHapticFeedback =>
      'Dokunsal geri bildirimi etkinleştir';

  @override
  String get settingsMaximizeOnStart => 'Başlangıçta maksimize et';

  @override
  String get settingsBrightnessSystem => 'Sistem';

  @override
  String get settingsBrightnessLight => 'Açık';

  @override
  String get settingsBrightnessDark => 'Koyu';

  @override
  String get settingsThemeDevice => 'Cihaz';

  @override
  String get settingsThemeOllama => 'Ollama';

  @override
  String get settingsTemporaryFixes => 'Geçici arayüz düzeltmeleri';

  @override
  String get settingsTemporaryFixesDescription =>
      'Arayüz sorunları için geçici düzeltmeleri etkinleştirin. \nDaha fazla bilgi edinmek için tek tek seçeneklere uzun basın.';

  @override
  String get settingsTemporaryFixesInstructions =>
      'Ne yaptığınızı bilmiyorsanız bu ayarlardan herhangi birini değiştirmeyin! Verilen çözümler beklendiği gibi çalışmayabilir.\nBunlar nihai olarak görülemez veya bu şekilde değerlendirilmemelidir. Sorunlar ortaya çıkabilir.';

  @override
  String get settingsTemporaryFixesNoFixes =>
      'Herhangi bir düzeltme mevcut değil';

  @override
  String get settingsVoicePermissionLoading => 'Ses izinleri yükleniyor ...';

  @override
  String get settingsVoiceTtsNotSupported => 'Metinden sese desteklenmiyor';

  @override
  String get settingsVoiceTtsNotSupportedDescription =>
      'Metinden sese hizmetleri seçilen dil için desteklenmiyor. Bunları yeniden etkinleştirmek için dil çekmecesinde farklı bir dil seçin.\nSes tanıma ve yapay zeka ile düşünme gibi diğer hizmetler her zamanki gibi çalışmaya devam eder, ancak etkileşim o kadar akıcı olmayabilir.';

  @override
  String get settingsVoicePermissionNot => 'İzinler verilmedi';

  @override
  String get settingsVoiceNotEnabled => 'Ses modu etkin değil';

  @override
  String get settingsVoiceNotSupported => 'Ses modu desteklenmiyor';

  @override
  String get settingsVoiceEnable => 'Ses modunu etkinleştir';

  @override
  String get settingsVoiceNoLanguage => 'Dil seçilmedi';

  @override
  String get settingsVoiceLimitLanguage => 'Seçili dille sınırla';

  @override
  String get settingsVoicePunctuation =>
      'Yapay zeka noktalama işaretlerini etkinleştir';

  @override
  String get settingsExportChats => 'Sohbetleri dışa aktar';

  @override
  String get settingsExportChatsSuccess => 'Sohbetler başarıyla dışa aktarıldı';

  @override
  String get settingsImportChats => 'Sohbetleri içe aktar';

  @override
  String get settingsImportChatsTitle => 'İçe Aktar';

  @override
  String get settingsImportChatsDescription =>
      'Sonraki adım, seçilen dosyadan sohbetleri içe aktaracaktır. Bu işlem, şu anda mevcut olan tüm sohbetlerin üzerine yazacaktır.\nDevam etmek istiyor musunuz?';

  @override
  String get settingsImportChatsImport => 'İçe Aktar ve Sil';

  @override
  String get settingsImportChatsCancel => 'İptal';

  @override
  String get settingsImportChatsSuccess => 'Sohbetler başarıyla içe aktarıldı';

  @override
  String get settingsExportInfo =>
      'Bu seçenekler, sohbet geçmişinizi dışa ve içe aktarmanıza olanak tanır. Bu, sohbet geçmişinizi başka bir cihaza aktarmak veya yedeklemek istediğinizde kullanışlı olabilir';

  @override
  String get settingsExportWarning =>
      'Birden fazla sohbet geçmişi birleştirilmeyecek! Yeni bir sohbet geçmişi içe aktarırsanız mevcut sohbet geçmişinizi kaybedeceksiniz';

  @override
  String get settingsUpdateCheck => 'Güncellemeleri kontrol et';

  @override
  String get settingsUpdateChecking => 'Güncellemeler kontrol ediliyor ...';

  @override
  String get settingsUpdateLatest => 'En son sürümü kullanıyorsunuz';

  @override
  String settingsUpdateAvailable(String version) {
    return 'Güncelleme mevcut (v$version)';
  }

  @override
  String get settingsUpdateRateLimit =>
      'Kontrol edilemiyor, API hız sınırı aşıldı';

  @override
  String get settingsUpdateIssue => 'Bir sorun oluştu';

  @override
  String get settingsUpdateDialogTitle => 'Yeni sürüm mevcut';

  @override
  String get settingsUpdateDialogDescription =>
      'Ollama\'\'nın yeni bir sürümü mevcut. Şimdi indirip kurmak istiyor musunuz?';

  @override
  String get settingsUpdateChangeLog => 'Değişiklik Günlüğü';

  @override
  String get settingsUpdateDialogUpdate => 'Güncelle';

  @override
  String get settingsUpdateDialogCancel => 'İptal';

  @override
  String get settingsCheckForUpdates => 'Açılışta güncellemeleri kontrol et';

  @override
  String get settingsGithub => 'GitHub';

  @override
  String get settingsReportIssue => 'Sorun Bildir';

  @override
  String get settingsLicenses => 'Lisanslar';

  @override
  String settingsVersion(String version) {
    return 'Ollama App v$version';
  }
}
