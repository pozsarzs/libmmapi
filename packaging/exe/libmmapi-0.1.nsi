; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "LibMMAPI"
!define PRODUCT_VERSION "0.1"
!define PRODUCT_PUBLISHER "Pozsar Zsolt"
!define PRODUCT_WEB_SITE "http://www.szerafingomba.hu/softwares.html"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\mmapi.dll"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Language Selection Dialog Settings
!define MUI_LANGDLL_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_LANGDLL_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

; Installer pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "$(MUILicense)" 
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

; Language files
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "Hungarian"

; License Language
LicenseLangString MUILicense ${LANG_ENGLISH} "libmmapi-0.1\documents\copying.txt"
LicenseLangString MUILicense ${LANG_HUNGARIAN} "libmmapi-0.1\documents\copying.txt"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "libmmapi-0.1-win32.exe"
InstallDir "$PROGRAMFILES\LibMMAPI-0.1"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show
RequestExecutionLevel admin


Function .onInit
  !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

Section "Main files" SEC01
  SetShellVarContext all
  SetOutPath "$INSTDIR\documents"
  SetOverwrite try
  File "libmmapi-0.1\documents\authors.txt"
  File "libmmapi-0.1\documents\copying.txt"
  File "libmmapi-0.1\documents\install.txt"
  File "libmmapi-0.1\documents\readme.txt"
  File "libmmapi-0.1\documents\version.txt"
  SetOutPath "$INSTDIR\manuals"
  File "libmmapi-0.1\manuals\libmmapi_en.txt"
  File "libmmapi-0.1\manuals\libmmapi_hu.txt"
  SetOutPath "$INSTDIR"
  File "libmmapi-0.1\readme.txt"
  File "libmmapi-0.1\mmapi.dll"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\mmapi.dll"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\tubes2oe.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  Exec '"regsvr32.exe" "$INSTDIR\mmapi.dll"'
SectionEnd

; Section uninstall
  Function un.onInit
  !insertmacro MUI_UNGETLANGUAGE
  FunctionEnd

Section Uninstall
  SetShellVarContext all
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\mmapi.dll"
  Delete "$INSTDIR\readme.txt"
  Delete "$INSTDIR\documents\authors.txt"
  Delete "$INSTDIR\documents\copying.txt"
  Delete "$INSTDIR\documents\install.txt"
  Delete "$INSTDIR\documents\readme.txt"
  Delete "$INSTDIR\documents\version.txt"
  Delete "$INSTDIR\manuals\libmmapi_en.txt"
  Delete "$INSTDIR\manuals\libmmapi_hu.txt"
  
  RMDir "$INSTDIR\manuals"
  RMDir "$INSTDIR\documents"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd
