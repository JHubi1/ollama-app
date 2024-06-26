; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

; #define AppVersion "1.0.1"

#define AppName "Ollama App"
#define AppPublisher "JHubi1"
#define AppURL "https://jhubi1.com"
#define AppExeName "ollama.exe"
#define AppArchitectures "arm64"

[Setup]   
SourceDir=..
ArchitecturesAllowed={#AppArchitectures}

AppId={{4ACF8C84-5D9B-455C-9FED-93D29E2F71DC}
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} v{#AppVersion}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppURL}
SetupIconFile=windows\runner\resources\app_icon.ico
AppCopyright=© 2024 {#AppPublisher}

UninstallDisplayIcon={app}\{#AppExeName}
UninstallDisplayName={#AppName}

DefaultDirName={autopf}\OllamaApp
OutputDir=build\windows\{#AppArchitectures}\runner
OutputBaseFilename=ollama-v{#AppVersion}-{#AppArchitectures}

AppSupportURL=https://github.com/JHubi1/ollama-app/issues
AppUpdatesURL=https://github.com/JHubi1/ollama-app/releases

LicenseFile=windows_installer\docs\license.txt
InfoBeforeFile=windows_installer\docs\before.txt
InfoAfterFile=windows_installer\docs\after.txt

WizardImageFile=assets\OllamaAppBanner.bmp

PrivilegesRequiredOverridesAllowed=dialog
;Password=enterPasswordInCaseOfSecretBuild
;Encryption=yes

DisableWelcomePage=no
DisableProgramGroupPage=yes

Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "build\windows\{#AppArchitectures}\runner\Release\{#AppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "build\windows\{#AppArchitectures}\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\{#AppName}"; Filename: "{app}\{#AppExeName}"
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#AppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(AppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

