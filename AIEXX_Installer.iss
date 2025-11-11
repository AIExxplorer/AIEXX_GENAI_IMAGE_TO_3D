; AIEXX GenAI Image to 3D - Inno Setup Script
; Version 1.1.0

[Setup]
; Application Information
AppName=AIEXX GenAI Image to 3D
AppVersion=1.1.0
AppPublisher=AIEXX Project
AppPublisherURL=https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D
AppSupportURL=https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D/issues
AppUpdatesURL=https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D/releases
DefaultDirName={autopf}\AIEXX
DefaultGroupName=AIEXX GenAI
AllowNoIcons=yes
LicenseFile=LICENSE.txt
OutputDir=installer_output
OutputBaseFilename=AIEXX_Setup_v1.1.0
SetupIconFile=aiexx_icon.ico
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=admin
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "portuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; Launcher files
Source: "AIEXX_LAUNCHER.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "DIAGNOSTIC_TEST.bat"; DestDir: "{app}"; Flags: ignoreversion

; Setup scripts
Source: "1-INSTALL_VS_BUILDTOOLS_WINGET.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "1-INSTALL_VS_BUILDTOOLS.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "3-RUN_INSTALL_3DPACK.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "4-DOWNLOAD_3D_MODELS.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "5-SETUP_SD_MODELS.bat"; DestDir: "{app}"; Flags: ignoreversion

; Python scripts
Source: "download_models.py"; DestDir: "{app}"; Flags: ignoreversion
Source: "download_sd_models.py"; DestDir: "{app}"; Flags: ignoreversion
Source: "download_sd_simple.py"; DestDir: "{app}"; Flags: ignoreversion

; Documentation
Source: "README.md"; DestDir: "{app}"; Flags: ignoreversion isreadme
Source: "START_HERE.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "COMO_USAR.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "TESTING_GUIDE.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "TROUBLESHOOTING_BATCH_FILES.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "ORDEM_DE_INSTALACAO.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "PREPARING_EXE_INSTALLER.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "PROJECT_ORGANIZATION.md"; DestDir: "{app}"; Flags: ignoreversion

; Workflow documentation
Source: "WORKFLOWS_DISPONIVEIS.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "WORKFLOW_COMPLETO_GUIA.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "COMO_TRANSFORMAR_FOTO_EM_3D.md"; DestDir: "{app}"; Flags: ignoreversion

; Release information
Source: "CHANGELOG.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "RELEASE_GUIDE.md"; DestDir: "{app}"; Flags: ignoreversion

; License and logo
Source: "LICENSE.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "aiexx_logo.txt"; DestDir: "{app}"; Flags: ignoreversion

; Workflows (if folder exists)
Source: "workflows\*"; DestDir: "{app}\workflows"; Flags: ignoreversion recursesubdirs createallsubdirs; Check: DirExists(ExpandConstant('{src}\workflows'))

[Icons]
Name: "{group}\AIEXX Launcher"; Filename: "{app}\AIEXX_LAUNCHER.bat"; IconFilename: "{app}\aiexx_icon.ico"
Name: "{group}\Diagnostic Test"; Filename: "{app}\DIAGNOSTIC_TEST.bat"
Name: "{group}\Read Me"; Filename: "{app}\README.md"
Name: "{group}\Getting Started"; Filename: "{app}\START_HERE.md"
Name: "{group}\{cm:UninstallProgram,AIEXX}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\AIEXX GenAI"; Filename: "{app}\AIEXX_LAUNCHER.bat"; IconFilename: "{app}\aiexx_icon.ico"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\AIEXX"; Filename: "{app}\AIEXX_LAUNCHER.bat"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\START_HERE.md"; Description: "{cm:LaunchProgram,Read Getting Started Guide}"; Flags: postinstall shellexec skipifsilent
Filename: "{app}\AIEXX_LAUNCHER.bat"; Description: "{cm:LaunchProgram,AIEXX Launcher}"; Flags: postinstall nowait skipifsilent unchecked

[Code]
function DirExists(const Name: String): Boolean;
begin
  Result := DirExists(Name);
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    // Create .aiexx_installed marker file after installation
    // This tells the launcher that installation is complete
    SaveStringToFile(ExpandConstant('{app}\.aiexx_installed'),
      'Installation completed on ' + GetDateTimeString('yyyy-mm-dd hh:nn:ss', #0, #0),
      False);
  end;
end;

[UninstallDelete]
Type: files; Name: "{app}\.aiexx_installed"
Type: files; Name: "{app}\.aiexx_checkpoint"
Type: filesandordirs; Name: "{app}\.venv311"
Type: filesandordirs; Name: "{app}\ComfyUI"

[Messages]
WelcomeLabel1=Welcome to AIEXX GenAI Image to 3D Setup
WelcomeLabel2=This will install AIEXX GenAI Image to 3D on your computer.%n%nAIEXX is an AI-powered system for generating 3D models from images and text prompts.%n%nIt is recommended that you close all other applications before continuing.
FinishedHeadingLabel=AIEXX Installation Complete
FinishedLabel=AIEXX has been installed on your computer.%n%nClick "Getting Started Guide" to learn how to use AIEXX, or click "AIEXX Launcher" to start the system now.
