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
  String get noHostSelected => 'Ana bilgisayar seçilmedi, ayarları açıp bir tane belirleyin';

  @override
  String get noSelectedModel => '<seçici>';

  @override
  String get newChatTitle => 'İsimsiz Sohbet';

  @override
  String get modelDialogAddModel => 'Ekle';

  @override
  String get modelDialogAddPromptTitle => 'Yeni model ekle';

  @override
  String get modelDialogAddPromptDescription => 'Bu normal bir isim (örneğin \'llama3\') ya da isim ve etiket (örneğin \'llama3:70b\') olabilir.';

  @override
  String get modelDialogAddPromptAlreadyExists => 'Model zaten mevcut';

  @override
  String get modelDialogAddPromptInvalid => 'Geçersiz model adı';

  @override
  String get modelDialogAddAllowanceTitle => 'Proxy\'e İzin Ver';

  @override
  String get modelDialogAddAllowanceDescription => 'Ollama Uygulaması, girilen modelin geçerli olup olmadığını kontrol etmelidir. Bunun için normalde Ollama model listesine bir web isteği gönderir ve durum kodunu kontrol ederiz, ancak siz web istemcisini kullandığınız için bunu doğrudan yapamayız. Bunun yerine, uygulama bizim için kontrol etmek amacıyla JHubi1 tarafından barındırılan farklı bir API\'ye istek gönderecek. \nBu, yalnızca bir kez yapılan bir istektir ve yalnızca yeni bir model eklediğinizde gönderilecektir. \nIP adresiniz istekle birlikte gönderilecek ve olası zararlı niyetlerle spam yapılmasını önlemek amacıyla on dakikaya kadar saklanabilir. \nKabul ederseniz, seçiminiz gelecekte hatırlanacaktır; kabul etmezseniz, hiçbir şey gönderilmeyecek ve model eklenmeyecektir.';

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
  String get modelDialogAddDownloadFailed => 'Bağlantı kesildi, yeniden deneyin';

  @override
  String get modelDialogAddDownloadSuccess => 'İndirme tamamlandı';

  @override
  String get deleteDialogTitle => 'Sohbeti Sil';

  @override
  String get deleteDialogDescription => 'Devam etmek istediğinizden emin misiniz? Bu işlem, bu sohbetin tüm hafızasını silecek ve geri alınamaz.\nBu dialogu devre dışı bırakmak için ayarları ziyaret edin.';

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
  String get settingsDescriptionBehavior => 'Yapay zekanın davranışını istediğiniz gibi değiştirin.';

  @override
  String get settingsTitleInterface => 'Arayüz';

  @override
  String get settingsDescriptionInterface => 'Ollama Uygulamasının görünümünü ve davranışını düzenleyin.';

  @override
  String get settingsTitleVoice => 'Ses';

  @override
  String get settingsDescriptionVoice => 'Ses modunu etkinleştirin ve ses ayarlarını yapılandırın.';

  @override
  String get settingsTitleExport => 'Dışa Aktar';

  @override
  String get settingsDescriptionExport => 'Sohbet geçmişinizi dışa ve içe aktarın.';

  @override
  String get settingsTitleAbout => 'Hakkında';

  @override
  String get settingsDescriptionAbout => 'Güncellemeleri kontrol edin ve Ollama Uygulaması hakkında daha fazla bilgi edinin.';

  @override
  String get settingsSavedAutomatically => 'Ayarlar otomatik olarak kaydedilir';

  @override
  String get settingsExperimentalAlpha => 'alfa';

  @override
  String get settingsExperimentalAlphaDescription => 'Bu özellik alfa aşamasındadır ve beklendiği gibi çalışmayabilir.\nKritik sorunlar ve/veya cihaza ve/veya kullanılan hizmetlere kalıcı kritik hasar verilebilme ihtimali göz ardı edilemez.\nKendi sorumluluğunuzda kullanın. Uygulama yazarının hiçbir sorumluluğu yoktur.';

  @override
  String get settingsExperimentalAlphaFeature => 'Alfa özelliği, daha fazla bilgi için basılı tutun';

  @override
  String get settingsExperimentalBeta => 'beta';

  @override
  String get settingsExperimentalBetaDescription => 'Bu özellik beta aşamasındadır ve beklendiği gibi çalışmayabilir.\nDaha az ciddi sorunlar ortaya çıkabilir. Hasar kritik olmamalıdır.\nKendi sorumluluğunuzda kullanın.';

  @override
  String get settingsExperimentalBetaFeature => 'Beta özelliği, daha fazla bilgi için basılı tutun';

  @override
  String get settingsExperimentalDeprecated => 'kullanım dışı';

  @override
  String get settingsExperimentalDeprecatedDescription => 'Bu özellik kullanımdan kaldırılmıştır ve gelecekteki bir sürümde kaldırılacaktır.\nAmaçlandığı veya beklendiği gibi çalışmayabilir. Kullanım riski size aittir.';

  @override
  String get settingsExperimentalDeprecatedFeature => 'Kullanımdan kaldırılan özellik, daha fazla bilgi için bekleyin';

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
        'auth': 'Kimlik doğrulama başarısız',
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
  String get settingsHostHeaderInvalid => 'Girilen metin geçerli bir başlık JSON nesnesi değil';

  @override
  String settingsHostInvalidDetailed(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': 'Girdiğiniz URL geçersiz. http:// veya https:// ile başlayan tam bir URL kullanın — örneğin yerel bir Ollama sunucusu için http://localhost:11434, Ollama Cloud için https://ollama.com. Sonda eğik çizgi veya /api yolu eklemeyin.',
        'host': 'Girdiğiniz ana bilgisayar geçersiz. Ulaşılamıyor. Lütfen ana bilgisayarı kontrol edin ve tekrar deneyin.',
        'auth': 'Sunucu isteği reddetti (401/403). Ollama Cloud\'a (https://ollama.com) bağlanıyorsanız, API anahtarınızı aşağıdaki token alanına girin — https://ollama.com/keys sayfasından oluşturabilir veya kopyalayabilirsiniz — ve kaydedin. Kendi sunucunuzu kullanıyorsanız, ana bilgisayar için yapılandırılmış Authorization başlığını kontrol edin.',
        'other': 'Girdiğiniz ana bilgisayar geçersiz. Ulaşılamıyor. Lütfen ana bilgisayarı kontrol edin ve tekrar deneyin.',
      },
    );
    return '$_temp0';
  }

  @override
  String get settingsApiTokenInvalid => 'API token reddedildi';

  @override
  String get settingsApiTokenInvalidDetailed => 'API token sunucu tarafından reddedildi (401/403). https://ollama.com/keys sayfasında gösterildiği gibi tam olarak kopyalandığını kontrol edin — yeni bir anahtar o sayfadan oluşturulabilir — ve tekrar kaydedin. Token, ana bilgisayar https://ollama.com iken ayarlanmış olmalıdır.';

  @override
  String get settingsApiTokenVerified => 'API token kaydedildi ve doğrulandı';

  @override
  String get settingsApiToken => 'Ollama Cloud API Token';

  @override
  String get settingsApiTokenHint => 'Token\'ı ollama.com\'dan yapıştır';

  @override
  String get tooltipShowToken => 'Token\'ı göster';

  @override
  String get tooltipHideToken => 'Token\'ı gizle';

  @override
  String voiceLanguageInstruction(String language) {
    return 'Şu dilde yazmalısınız: $language!';
  }

  @override
  String get settingsSystemMessage => 'Sistem mesajı';

  @override
  String get settingsUseSystem => 'Sistem mesajını kullan';

  @override
  String get settingsUseSystemDescription => 'Yukarıdaki sistem mesajını ayarlamayı devre dışı bırakır ve bunun yerine modelin mesajını kullanır. Model dosyaları olan modeller için yararlı olabilir';

  @override
  String get settingsDisableMarkdown => 'Markdown\'\'ı devre dışı bırak';

  @override
  String get settingsBehaviorNotUpdatedForOlderChats => 'Davranış ayarları eski sohbetler için güncellenmez';

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
  String get settingsKeepModelLoadedFor => 'Modelin yüklü kalacağı belirli bir süre ayarla';

  @override
  String settingsKeepModelLoadedSet(String minutes) {
    return 'Modeli $minutes dakika boyunca yüklü tut';
  }

  @override
  String get settingsTimeoutMultiplier => 'Zaman aşımı çarpanı';

  @override
  String get settingsTimeoutMultiplierDescription => 'Uygulamadaki her zaman aşımı değerine uygulanacak çarpanı seçin. Yavaş bir internet bağlantısı veya yavaş bir ana bilgisayar ile yararlı olabilir.';

  @override
  String get settingsTimeoutMultiplierExample => 'Örn. mesaj zaman aşımı:';

  @override
  String get settingsEnableHapticFeedback => 'Dokunsal geri bildirimi etkinleştir';

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
  String get settingsTemporaryFixesDescription => 'Arayüz sorunları için geçici düzeltmeleri etkinleştirin. \nDaha fazla bilgi edinmek için tek tek seçeneklere uzun basın.';

  @override
  String get settingsTemporaryFixesInstructions => 'Ne yaptığınızı bilmiyorsanız bu ayarlardan herhangi birini değiştirmeyin! Verilen çözümler beklendiği gibi çalışmayabilir.\nBunlar nihai olarak görülemez veya bu şekilde değerlendirilmemelidir. Sorunlar ortaya çıkabilir.';

  @override
  String get settingsTemporaryFixesNoFixes => 'Herhangi bir düzeltme mevcut değil';

  @override
  String get settingsVoicePermissionLoading => 'Ses izinleri yükleniyor ...';

  @override
  String get settingsVoiceTtsNotSupported => 'Metinden sese desteklenmiyor';

  @override
  String get settingsVoiceTtsNotSupportedDescription => 'Metinden sese hizmetleri seçilen dil için desteklenmiyor. Bunları yeniden etkinleştirmek için dil çekmecesinde farklı bir dil seçin.\nSes tanıma ve yapay zeka ile düşünme gibi diğer hizmetler her zamanki gibi çalışmaya devam eder, ancak etkileşim o kadar akıcı olmayabilir.';

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
  String get settingsVoicePunctuation => 'Yapay zeka noktalama işaretlerini etkinleştir';

  @override
  String get settingsExportChats => 'Sohbetleri dışa aktar';

  @override
  String get settingsExportChatsSuccess => 'Sohbetler başarıyla dışa aktarıldı';

  @override
  String get settingsImportChats => 'Sohbetleri içe aktar';

  @override
  String get settingsImportChatsTitle => 'İçe Aktar';

  @override
  String get settingsImportChatsDescription => 'Sonraki adım, seçilen dosyadan sohbetleri içe aktaracaktır. Bu işlem, şu anda mevcut olan tüm sohbetlerin üzerine yazacaktır.\nDevam etmek istiyor musunuz?';

  @override
  String get settingsImportChatsImport => 'İçe Aktar ve Sil';

  @override
  String get settingsImportChatsCancel => 'İptal';

  @override
  String get settingsImportChatsSuccess => 'Sohbetler başarıyla içe aktarıldı';

  @override
  String get settingsExportInfo => 'Bu seçenekler, sohbet geçmişinizi dışa ve içe aktarmanıza olanak tanır. Bu, sohbet geçmişinizi başka bir cihaza aktarmak veya yedeklemek istediğinizde kullanışlı olabilir';

  @override
  String get settingsExportWarning => 'Birden fazla sohbet geçmişi birleştirilmeyecek! Yeni bir sohbet geçmişi içe aktarırsanız mevcut sohbet geçmişinizi kaybedeceksiniz';

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
  String get settingsUpdateRateLimit => 'Kontrol edilemiyor, API hız sınırı aşıldı';

  @override
  String get settingsUpdateIssue => 'Bir sorun oluştu';

  @override
  String get settingsUpdateDialogTitle => 'Yeni sürüm mevcut';

  @override
  String get settingsUpdateDialogDescription => 'Ollama\'\'nın yeni bir sürümü mevcut. Şimdi indirip kurmak istiyor musunuz?';

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

  @override
  String get settingsTitleAccessibility => 'Erişilebilirlik';

  @override
  String get settingsDescriptionAccessibility =>
      'Erişilebilirlik bildirimi, test sonuçları ve sorun bildirme yolları.';

  @override
  String get accessibilityStatementTitle => 'Erişilebilirlik bildirimi';

  @override
  String get accessibilityCommitmentIntro =>
      'Ollama, yayınladığımız her dilde, her yetenek düzeyindeki kişi tarafından kullanılabilmelidir. Sesli kontrol, ekran okuyucular, klavye ile gezinme ve yüksek kontrastlı gösterim bu uygulamanın birinci sınıf kullanım yollarıdır — sonradan düşünülmüş eklemeler değil.';

  @override
  String get accessibilityCommitmentDetails =>
      'Uygulamada bu şöyle anlama gelir: her etkileşimli denetimin ekran okuyucuların duyurduğu bir adı vardır (sesli mod durumu dahil), düğmeler en az 48dp dokunma hedefine sahiptir, klavye odağı arayüzün görsel sırasını izler, durum mesajları değiştikçe duyurulur ve arayüz büyük metin ölçeklerinde hem açık hem de koyu temalarda kullanılabilir durumda kalır.';

  @override
  String get accessibilityConformanceTitle => 'Uyumluluk durumu';

  @override
  String get accessibilityConformanceStatus =>
      'Bu uygulama, Web Content Accessibility Guidelines (WCAG) 2.2 Level AA ile uyumlu olacak şekilde tasarlanmıştır. Uyumluluk bağımsız bir üçüncü taraf tarafından sertifikalandırılmamıştır; kendi otomatik testlerimize dayanmaktadır. Uygun olduğu durumlarda AA\'nın ötesine geçiyor ve aşağıda listelenen WCAG AAA ölçülerini uyguluyoruz.';

  @override
  String get accessibilityAaaMeasuresTitle => 'AA\'nın ötesinde (AAA ölçüleri)';

  @override
  String get accessibilityAaaMeasures =>
      'Ana metin her iki temada 21:1 kontrast kullanır (AAA 7:1 gerektirir), soluk ikincil metin 10:1 veya daha iyisini kullanır, başarı ve uyarı durum renkleri her iki temada AAA kontrastını karşılar ve koyu temadaki hata metni AAA kontrastını karşılar. AAA ayrıca bu boyutta bir sohbet uygulamasında pratik olmayan ölçüler gerektirir (örneğin tüm metinlerde kesinlikle 7:1 kontrast ve okuma düzeyi sınırları), bu nedenle garanti olarak AA\'yi hedefliyor ve bu AAA ölçülerini iyileştirmeler olarak ele alıyoruz.';

  @override
  String get accessibilityAodaTitle =>
      'Accessibility for Ontarians with Disabilities Act (AODA)';

  @override
  String get accessibilityAodaText =>
      'Ontario\'nın Accessibility for Ontarians with Disabilities Act (AODA) yasası, dijital ürünlerin WCAG 2.0/2.1 Level AA karşılamasını gerektirir. Bu uygulamanın WCAG 2.2 Level AA hedefi bu tabanı karşılar ve aşar. Erişilebilirlik geri bildirimleri, AODA\'nın geri bildirim kanallarını erişilebilir kılma gereksinimi doğrultusunda bu sayfadaki iletişim formu aracılığıyla memnuniyetle kabul edilir.';

  @override
  String get accessibilityStandardsEuropeTitle =>
      'Avrupa standartları (EN 301 549)';

  @override
  String get accessibilityStandardsEuropeText =>
      'Avrupa Birliği\'nde uyumlaştırılmış standart EN 301 549, Avrupa Erişilebilirlik Yasası\'nın BT erişilebilirliği gereksinimlerini tanımlar; bu yasa WCAG 2.1 Level AA\'ya atıfta bulunur. Bu uygulamanın WCAG 2.2 Level AA hedefi bu gereksinimleri kapsar ve 28 Haziran 2025\'ten itibaren geçerli olan Avrupa erişilebilirlik yükümlülüklerini destekler.';

  @override
  String get accessibilityStandardsUsTitle =>
      'Amerika Birleşik Devletleri standartları (ADA / Section 508)';

  @override
  String get accessibilityStandardsUsText =>
      'Amerika Birleşik Devletleri\'nde Americans with Disabilities Act (ADA) genel ayrımcılık yasağı tabanıdır ve Rehabilitation Act\'ın Section 508 maddesi federal teknoloji için WCAG 2.0 Level AA gerektirir (Section 504 benzer yükümlülükleri desteklenen programlara genişletir). Bu uygulamanın WCAG 2.2 Level AA hedefi bu tabanları karşılar ve aşar.';

  @override
  String get accessibilityKnownIssuesTitle => 'Bilinen sınırlamalar';

  @override
  String get accessibilityKnownIssues =>
      'Masaüstü pencere başlık çubuğu düğmeleri (küçültme, büyütme, kapatma) işletim sistemi entegrasyonu tarafından sağlanır ve uygulamanın ekran okuyucu ağacından erişilemez. Sohbet kitaplığı, kendi arayüz metninin küçük bir bölümünü kendisi oluşturur; bu metin henüz tüm dillerde mevcut olmayabilir. Ses modunda yanıt metni ekranın kenarına yakın bir yerde soluklaşır ve sistem metin boyutu belirgin şekilde artırıldığında çok uzun sohbet satırları üç nokta ile kısaltılabilir.';

  @override
  String accessibilityLastValidated(String version) {
    return 'Otomatik kontroller en son Ollama App v$version için doğrulandı.';
  }

  @override
  String get accessibilityTestsTitle => 'Test sonuçları';

  @override
  String get accessibilityTestsIntro =>
      'Aşağıdaki otomatik erişilebilirlik kontrolleri bu uygulamanın test paketinin parçasıdır ve her gönderide çalışır:';

  @override
  String get accessibilityTestsCheckColumn => 'Kontrol';

  @override
  String get accessibilityTestsStatusColumn => 'Durum';

  @override
  String get accessibilityTestsPass => 'Geçti';

  @override
  String get accessibilityTestsCiNote =>
      'Tam paket (statik analiz ve otomatik testler) sürekli entegrasyon hattında her gönderide çalışır.';

  @override
  String get accessibilityTestContrast =>
      'Metin kontrastı açık ve koyu temalarda WCAG düzeylerini karşılar';

  @override
  String get accessibilityTestLabeledTapTarget =>
      'Dokunulabilir hedefler ekran okuyucu etiketlerine sahiptir';

  @override
  String get accessibilityTestAndroidTapTarget =>
      'Dokunma hedefleri en az 48x48dp (Android kılavuzu)';

  @override
  String get accessibilityTestIosTapTarget =>
      'Dokunma hedefleri en az 44x44dp (iOS kılavuzu)';

  @override
  String get accessibilityTestSemanticsPresent =>
      'Tüm özel denetimler için ekran okuyucu etiketleri mevcuttur';

  @override
  String get accessibilityTestTraversalOrder =>
      'Klavye odağı sırası görsel sırayı izler';

  @override
  String get accessibilityTestLocalesRender =>
      'Tüm arayüz dilleri hatasız oluşturuluyor';

  @override
  String get accessibilityTestFormValidation =>
      'Form alanları doğrulama hatalarını duyurur';

  @override
  String get accessibilityContactTitle => 'Erişilebilirlik sorunu bildir';

  @override
  String get accessibilityContactIntro =>
      'Erişilebilirlik bilgisi istemek, bir çözüm talep etmek veya bir erişilebilirlik engeli bildirmek için bu formu kullanın. Bildiriniz, e-posta ile ya da GitHub üzerinde herkese açık bir sorun kaydı olarak gönderebileceğiniz bir mesaj haline getirilir.';

  @override
  String get accessibilityFormName => 'Ad (isteğe bağlı)';

  @override
  String get accessibilityFormEmail => 'E-posta (isteğe bağlı)';

  @override
  String get accessibilityFormAssistiveTech =>
      'Kullanılan yardımcı teknoloji (isteğe bağlı)';

  @override
  String get accessibilityFormDescription => 'Sorunu açıklayın (zorunlu)';

  @override
  String get accessibilityFormDescriptionHint =>
      'Ne yapmaya çalışıyordunuz ve ne engel oldu?';

  @override
  String get accessibilityFormErrorDescription =>
      'Göndermeden önce lütfen sorunu açıklayın.';

  @override
  String get accessibilityFormErrorEmail =>
      'Lütfen geçerli bir e-posta adresi girin veya alanı boş bırakın.';

  @override
  String get accessibilityFormSendEmail => 'E-posta ile gönder';

  @override
  String get accessibilityFormSendGithub => 'GitHub sorunu aç';

  @override
  String get accessibilityFormEmailSubject =>
      'Erişilebilirlik raporu (Ollama App)';

  @override
  String get accessibilityFormCopiedFallback =>
      'Bağlantı açılamadı. Rapor panoya kopyalandı.';

  @override
  String get tooltipResetChat => 'Mevcut sohbeti sıfırla';

  @override
  String get tooltipVoiceClose => 'Ses modunu kapat';

  @override
  String get tooltipVoiceSettings => 'Ses ayarlarını aç';

  @override
  String get tooltipVoiceScrollToEnd => 'En son metne kaydır';

  @override
  String get tooltipWelcomeNext => 'Sonraki sayfa';

  @override
  String get tooltipWelcomeFinish => 'Ollama\'yı kullanmaya başla';

  @override
  String get accessibilityVoiceOrbListening =>
      'Ses modu dinliyor. Dinlemeyi durdurmak için dokunun.';

  @override
  String get accessibilityVoiceOrbSpeaking =>
      'Yanıt sesli olarak okunuyor. Durdurmak için dokunun.';

  @override
  String get accessibilityVoiceOrbThinking =>
      'Yapay zeka bir yanıt hazırlıyor. İptal etmek için dokunun.';

  @override
  String get accessibilityAppLogo => 'Ollama';

  @override
  String get accessibilityWelcomePage1 =>
      'Ollama\'ya hoş geldiniz. Bu tanıtım üç kısa resim gösteriyor.';

  @override
  String get accessibilityWelcomePage2 =>
      'Tanıtım sayfası 2/3. Resim bir modelin nasıl seçileceğini ve sohbete nasıl başlanacağını gösteriyor.';

  @override
  String get accessibilityWelcomePage3 =>
      'Tanıtım sayfası 3/3. Resim ayarların ve ses modunun nerede bulunacağını gösteriyor.';

  @override
  String get accessibilitySummaryConformance =>
      'Bu uygulama WCAG 2.2 Level AA\'yi hedefler ve AAA düzeyinde iyileştirmeler uygular. Bazı özelliklerin sınırlamaları vardır; bunlar her bölümün içinde açıklanmıştır.';

  @override
  String get accessibilitySectionStatementSummary =>
      'Taahhüdümüz, uyumluluk durumumuz ve AA\'nın ötesinde uyguladığımız ölçüler.';

  @override
  String get accessibilitySectionTestsSummary =>
      '8 otomatik erişilebilirlik kontrolü her derlemede geçiyor.';

  @override
  String get accessibilitySectionStandardsSummary =>
      'AODA\'yı, Avrupa standardı EN 301 549\'u ve ABD\'nin ADA / Section 508 maddesini nasıl desteklediğimiz.';

  @override
  String get accessibilitySectionContactSummary =>
      'Bir erişilebilirlik sorununu e-posta veya GitHub ile bildirin. Tüm bildirilere yanıt veriyoruz.';

  @override
  String get accessibilitySupportLevelLimited => 'Sınırlı destek';

  @override
  String get accessibilitySupportLevelCompliantWithLimitations =>
      'Sınırlamalarla uyumlu';
}
