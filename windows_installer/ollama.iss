; Inno Setup script for Ollama App, created by JHubi1

#define AppName "Ollama App"
#define AppPublisher "JHubi1"
#define AppURL "https://jhubi1.com"
#define AppExeName "ollama.exe"

; #define AppVersion "1.0.1"
; #define AppArchitectures "x64"

#ifndef AppVersion
    #error AppVersion is required
#endif

#ifndef AppArchitectures
    #define AppArchitectures "x64"
#endif

[Setup]   
SourceDir=..
#if AppArchitectures == 'x64'
    ArchitecturesAllowed=x64compatible
#else
    ArchitecturesAllowed={#AppArchitectures}
#endif

AppId={{4ACF8C84-5D9B-455C-9FED-93D29E2F71DC}
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} v{#AppVersion}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppURL}
SetupIconFile=windows\runner\resources\app_icon.ico
AppCopyright=Copyright 2024 {#AppPublisher}

VersionInfoCompany={#AppPublisher}
VersionInfoDescription=Installation program for {#AppName}
VersionInfoOriginalFileName={#AppExeName}
VersionInfoVersion={#AppVersion}

UninstallDisplayIcon={app}\{#AppExeName}
UninstallDisplayName={#AppName}

DefaultDirName={autopf}\OllamaApp
OutputDir=build\windows\{#AppArchitectures}\runner
OutputBaseFilename=ollama-windows-{#AppArchitectures}-v{#AppVersion}

AppSupportURL=https://github.com/JHubi1/ollama-app/issues
AppUpdatesURL=https://github.com/JHubi1/ollama-app/releases

LicenseFile=windows_installer\docs\license.txt
InfoBeforeFile=windows_installer\docs\before.txt
InfoAfterFile=windows_installer\docs\after.txt

WizardImageFile=assets\OllamaAppBanner.bmp

PrivilegesRequiredOverridesAllowed=dialog
; Password=enterPasswordInCaseOfSecretBuild
; Encryption=yes

DisableWelcomePage=no
DisableProgramGroupPage=yes

Compression=lzma2/ultra64
SolidCompression=yes
WizardStyle=modern
WizardResizable=no

SetupMutex=OllamaAppSetup
CloseApplications=force

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "turkish"; MessagesFile: "compiler:Languages\Turkish.isl"

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

[Code]
function InitializeSetup(): Boolean;
begin
    Result := true;
    { TODO: Uncoment when arm64 is ready! }
    {if (ProcessorArchitecture = paArm64) and (ExpandConstant('{#AppArchitectures}') = 'x64') then
    begin
        if SuppressibleTaskDialogMsgBox('Architecture Compatibility', 'You are running the x64 version of the installer on an arm64 device. There is an arm64 version avaliable for download. It is recommended to be used. Do you wish to continue?', mbError, MB_YESNO, [SetupMessage(msgButtonYes), SetupMessage(msgButtonNo)], 0, IDYES) = IDNO then
        begin
            Result := false;
        end;
    end;}
end;

procedure CurUninstallStepChanged (CurUninstallStep: TUninstallStep);
    var
        mres : integer;
    begin
        case CurUninstallStep of                   
        usPostUninstall:
            begin
                mres := SuppressibleMsgBox('Do you want to Remove settings?', mbConfirmation, MB_YESNO or MB_DEFBUTTON2, IDYES)
                if mres = IDYES then
                    DelTree(ExpandConstant('{userappdata}\JHubi1\Ollama App'), True, True, True);
        end;
    end;
end;
