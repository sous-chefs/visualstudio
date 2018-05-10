
#
# Author:: Shawn Neal (<sneal@sneal.net>)
# Cookbook Name:: visualstudio
# Attribute:: vs2015
#
# Copyright 2015, Shawn Neal
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Currently you cannot change this, doing so will break the cookbook
default['visualstudio']['2015']['install_dir'] =
  (ENV['ProgramFiles(x86)'] || 'C:\Program Files (x86)') + '\Microsoft Visual Studio 14.0'

# Test Professional w/Update1
default['visualstudio']['2015']['testprofessional']['installer_file'] = 'vs_testprofessional.exe'
default['visualstudio']['2015']['testprofessional']['filename'] = 'vs2015.testpro_enu.iso'
default['visualstudio']['2015']['testprofessional']['package_name'] =
  'Microsoft Visual Studio Test Professional 2015'
default['visualstudio']['2015']['testprofessional']['checksum'] =
  '4c83fd0c971d6249b7f87e7fb20ccbf41d4ff4814a0660c4f89d6884408c191b'
default['visualstudio']['2015']['testprofessional']['default_source'] =
  'http://download.microsoft.com/download/8/5/6/856E021B-39D6-4593-B7BB-2F8D1178EBCB'

# Professional w/Update1
default['visualstudio']['2015']['professional']['installer_file'] = 'vs_professional.exe'
default['visualstudio']['2015']['professional']['filename'] =
  'vs2015.1.pro_enu.iso'
default['visualstudio']['2015']['professional']['package_name'] =
  'Microsoft Visual Studio Professional 2015'
default['visualstudio']['2015']['professional']['checksum'] =
  '7badca090697567ca679159afa21f5d84605bda6a66f99283185dacd24d61e6b'
default['visualstudio']['2015']['professional']['default_source'] =
  'http://download.microsoft.com/download/3/6/A/36A72A3F-711B-4738-B4C6-C668A508D2EE'

# Defaults for the <SelectableItemCustomization> in AdminDeployment.xml
# These are DEFAULTS. If you wish to change the selectable items installed edit the node attributes
# default['visualstudio']['install_items']['<feature>']['selected'] etc. (see README)
default['visualstudio']['2015']['professional']['default_install_items'].tap do |h|
  h['MDDJSDependencyHiddenV1']['selected'] = true
  h['MDDJSDependencyHiddenV1']['friendly_name'] = 'MDDJSDependencyHidden'
  h['BlissHidden']['selected'] = true
  h['BlissHidden']['friendly_name'] = 'BlissHidden'
  h['HelpHidden']['selected'] = true
  h['HelpHidden']['friendly_name'] = 'HelpHidden'
  h['JavaScript']['selected'] = true
  h['JavaScript']['friendly_name'] = 'JavascriptHidden'
  h['NetFX4Hidden']['selected'] = true
  h['NetFX4Hidden']['friendly_name'] = 'NetFX4Hidden'
  h['NetFX45Hidden']['selected'] = true
  h['NetFX45Hidden']['friendly_name'] = 'NetFX45Hidden'
  h['NetFX451MTPackHidden']['selected'] = true
  h['NetFX451MTPackHidden']['friendly_name'] = 'NetFX451MTPackHidden'
  h['NetFX451MTPackCoreHidden']['selected'] = true
  h['NetFX451MTPackCoreHidden']['friendly_name'] = 'NetFX451MTPackCoreHidden'
  h['NetFX452MTPackHidden']['selected'] = true
  h['NetFX452MTPackHidden']['friendly_name'] = 'NetFX452MTPackHidden'
  h['NetFX46MTPackHidden']['selected'] = true
  h['NetFX46MTPackHidden']['friendly_name'] = 'NetFX46MTPackHidden'
  h['PortableDTPHidden']['selected'] = true
  h['PortableDTPHidden']['friendly_name'] = 'PortableDTPHidden'
  h['PreEmptiveDotfuscatorHidden']['selected'] = true
  h['PreEmptiveDotfuscatorHidden']['friendly_name'] = 'PreEmptiveDotfuscatorHidden'
  h['PreEmptiveAnalyticsHidden']['selected'] = true
  h['PreEmptiveAnalyticsHidden']['friendly_name'] = 'PreEmptiveAnalyticsHidden'
  h['RoslynLanguageServicesHidden']['selected'] = true
  h['RoslynLanguageServicesHidden']['friendly_name'] = 'RoslynLanguageServicesHidden'
  h['SDKTools3Hidden']['selected'] = true
  h['SDKTools3Hidden']['friendly_name'] = 'SDKTools3Hidden'
  h['SDKTools4Hidden']['selected'] = true
  h['SDKTools4Hidden']['friendly_name'] = 'SDKTools4Hidden'
  h['WCFDataServicesHidden']['selected'] = true
  h['WCFDataServicesHidden']['friendly_name'] = 'WCFDataServicesHidden'
  h['TypeScriptV1']['selected'] = true
  h['TypeScriptV1']['friendly_name'] = 'TypeScript for Visual Studio'
  h['NativeLanguageSupport_VCV1']['selected'] = false
  h['NativeLanguageSupport_VCV1']['hidden'] = false
  h['NativeLanguageSupport_VCV1']['friendly_name'] = 'Common Tools for Visual C++ 2015'
  h['NativeLanguageSupport_MFCV1']['selected'] = false
  h['NativeLanguageSupport_MFCV1']['hidden'] = false
  h['NativeLanguageSupport_MFCV1']['friendly_name'] = 'Microsoft Foundation Classes for C++'
  h['NativeLanguageSupport_XPV1']['selected'] = false
  h['NativeLanguageSupport_XPV1']['hidden'] = false
  h['NativeLanguageSupport_XPV1']['friendly_name'] = 'Windows XP Support for C++'
  h['Win81SDK_HiddenV1']['selected'] = false
  h['Win81SDK_HiddenV1']['hidden'] = false
  h['Win81SDK_HiddenV1']['friendly_name'] = ''
  h['FSharpV1']['selected'] = true
  h['FSharpV1']['hidden'] = false
  h['FSharpV1']['friendly_name'] = 'Visual F#'
  h['PythonToolsForVisualStudioV1']['selected'] = false
  h['PythonToolsForVisualStudioV1']['hidden'] = false
  h['PythonToolsForVisualStudioV1']['friendly_name'] = 'Python Tools for Visual Studio'
  h['ClickOnceV1']['selected'] = true
  h['ClickOnceV1']['hidden'] = false
  h['ClickOnceV1']['friendly_name'] = 'ClickOnce Publishing Tools'
  h['LightSwitchV1']['selected'] = false
  h['LightSwitchV1']['hidden'] = false
  h['LightSwitchV1']['friendly_name'] = 'LightSwitch'
  h['OfficeDeveloperToolsV1']['selected'] = true
  h['OfficeDeveloperToolsV1']['hidden'] = false
  h['OfficeDeveloperToolsV1']['friendly_name'] = 'Microsoft Office Developer Tools'
  h['SQLV1']['selected'] = false
  h['SQLV1']['hidden'] = false
  h['SQLV1']['friendly_name'] = 'Microsoft SQL Server Data Tools'
  h['WebToolsV1']['selected'] = false
  h['WebToolsV1']['hidden'] = false
  h['WebToolsV1']['friendly_name'] = 'Microsoft Web Developer Tools'
  h['PowerShellToolsV1']['selected'] = false
  h['PowerShellToolsV1']['hidden'] = false
  h['PowerShellToolsV1']['friendly_name'] = 'PowerShell Tools for Visual Studio'
  h['SilverLight_Developer_KitV1']['selected'] = false
  h['SilverLight_Developer_KitV1']['hidden'] = false
  h['SilverLight_Developer_KitV1']['friendly_name'] = 'Silverlight Development Kit'
  h['XamarinVSCoreV1']['selected'] = false
  h['XamarinVSCoreV1']['hidden'] = false
  h['XamarinVSCoreV1']['friendly_name'] = 'C#/.NET (Xamarin)'
  h['MDDJSCoreV1']['selected'] = false
  h['MDDJSCoreV1']['hidden'] = false
  h['MDDJSCoreV1']['friendly_name'] = 'HTML/JavaScript (Apache Cordova)'
  h['AndroidNDKV1']['selected'] = false
  h['AndroidNDKV1']['hidden'] = false
  h['AndroidNDKV1']['friendly_name'] = 'Android Native Development Kit (R10E, 32 bits)'
  h['AndroidSDKV1']['selected'] = false
  h['AndroidSDKV1']['hidden'] = false
  h['AndroidSDKV1']['friendly_name'] = 'Android SDK'
  h['AndroidSDK_API1921V1']['selected'] = false
  h['AndroidSDK_API1921V1']['hidden'] = false
  h['AndroidSDK_API1921V1']['friendly_name'] = 'Android SDK Setup (API Level 19 and 21)'
  h['AndroidSDK_API22V1']['selected'] = false
  h['AndroidSDK_API22V1']['hidden'] = false
  h['AndroidSDK_API22V1']['friendly_name'] = 'Android SDK Setup (API Level 22)'
  h['AntV1']['selected'] = false
  h['AntV1']['hidden'] = false
  h['AntV1']['friendly_name'] = 'Apache Ant (1.9.3)'
  h['MDDCPlusPlus_iOSV1']['selected'] = false
  h['MDDCPlusPlus_iOSV1']['hidden'] = false
  h['MDDCPlusPlus_iOSV1']['friendly_name'] = 'Visual C++ iOS Development'
  h['MDDCPlusPlus_AndroidV1']['selected'] = false
  h['MDDCPlusPlus_AndroidV1']['hidden'] = false
  h['MDDCPlusPlus_AndroidV1']['friendly_name'] = 'Visual C++ Android Development'
  h['JavaJDKV1']['selected'] = false
  h['JavaJDKV1']['hidden'] = false
  h['JavaJDKV1']['friendly_name'] = 'Java SE Development Kit (7.0.550.13)'
  h['Node.jsV1']['selected'] = false
  h['Node.jsV1']['hidden'] = false
  h['Node.jsV1']['friendly_name'] = 'Joyent Node.js'
  h['VSEmu_AndroidV1']['selected'] = false
  h['VSEmu_AndroidV1']['hidden'] = false
  h['VSEmu_AndroidV1']['friendly_name'] = 'Microsoft Visual Studio Emulator for Android'
  h['ToolsForWin81_WP80_WP81V1']['selected'] = false
  h['ToolsForWin81_WP80_WP81V1']['hidden'] = false
  h['ToolsForWin81_WP80_WP81V1']['friendly_name'] = 'Tools and Windows SDKs'
  h['WindowsPhone81EmulatorsV1']['selected'] = false
  h['WindowsPhone81EmulatorsV1']['hidden'] = false
  h['WindowsPhone81EmulatorsV1']['friendly_name'] = 'Emulators for Windows Phone 8.1'
  h['GitForWindowsV1']['selected'] = false
  h['GitForWindowsV1']['hidden'] = false
  h['GitForWindowsV1']['friendly_name'] = 'Git for Windows'
  h['GitHubVSV1']['selected'] = false
  h['GitHubVSV1']['hidden'] = false
  h['GitHubVSV1']['friendly_name'] = 'GitHub Extension for Visual Studio'
  h['VS_SDK_GroupV1']['selected'] = false
  h['VS_SDK_GroupV1']['hidden'] = false
  h['VS_SDK_GroupV1']['friendly_name'] = 'Visual Studio Extensibility Tools'
  h['VS_SDK_Breadcrumb_GroupV1']['selected'] = false
  h['VS_SDK_Breadcrumb_GroupV1']['friendly_name'] = 'Visual Studio Extensibility Tools'
  h['ProfilerHidden']['selected'] = false
  h['ProfilerHidden']['friendly_name'] = 'ProfilerHidden'
  h['StoryboardingHidden']['selected'] = false
  h['StoryboardingHidden']['friendly_name'] = 'StoryboardingHidden'
end

# Community w/Update 3
default['visualstudio']['2015']['community']['installer_file'] = 'vs_community.exe'
default['visualstudio']['2015']['community']['filename'] =
  'vs2015.3.com_enu.iso'
default['visualstudio']['2015']['community']['package_name'] =
  'Microsoft Visual Studio Community 2015 with Updates'
default['visualstudio']['2015']['community']['checksum'] =
  'ce124aec77f970605bb38352e59e7b3c7b51c0367f213cf5e6165b2698c1ba20'
default['visualstudio']['2015']['community']['default_source'] =
  'http://download.microsoft.com/download/b/e/d/bedddfc4-55f4-4748-90a8-ffe38a40e89f'

# Defaults for the <SelectableItemCustomization> in AdminDeployment.xml
# These are DEFAULTS. If you wish to change the selectable items installed edit the node attributes
# default['visualstudio']['install_items']['<feature>']['selected'] etc. (see README)
default['visualstudio']['2015']['community']['default_install_items'].tap do |h|
  h['TypeScriptV1']['selected'] = true
  h['TypeScriptV1']['friendly_name'] = 'TypeScript for Visual Studio'
  h['WebToolsV1']['selected'] = true
  h['WebToolsV1']['hidden'] = false
  h['WebToolsV1']['friendly_name'] = 'Microsoft Web Developer Tools'
  h['JavaJDKV1']['selected'] = true
  h['JavaJDKV1']['hidden'] = false
  h['JavaJDKV1']['friendly_name'] = 'Java SE Development Kit (7.0.550.13)'
  h['GitForWindowsV1']['selected'] = true
  h['GitForWindowsV1']['hidden'] = false
  h['GitForWindowsV1']['friendly_name'] = 'Git for Windows'
  h['MDDJSDependencyHiddenV1']['selected'] = true
  h['MDDJSDependencyHiddenV1']['friendly_name'] = 'MDDJSDependencyHidden'
  h['BlissHidden']['selected'] = true
  h['BlissHidden']['friendly_name'] = 'BlissHidden'
  h['HelpHidden']['selected'] = true
  h['HelpHidden']['friendly_name'] = 'HelpHidden'
  h['JavaScript']['selected'] = true
  h['JavaScript']['friendly_name'] = 'JavascriptHidden'
  h['NetFX4Hidden']['selected'] = true
  h['NetFX4Hidden']['friendly_name'] = 'NetFX4Hidden'
  h['NetFX45Hidden']['selected'] = true
  h['NetFX45Hidden']['friendly_name'] = 'NetFX45Hidden'
  h['NetFX451MTPackHidden']['selected'] = true
  h['NetFX451MTPackHidden']['friendly_name'] = 'NetFX451MTPackHidden'
  h['NetFX451MTPackCoreHidden']['selected'] = true
  h['NetFX451MTPackCoreHidden']['friendly_name'] = 'NetFX451MTPackCoreHidden'
  h['NetFX452MTPackHidden']['selected'] = true
  h['NetFX452MTPackHidden']['friendly_name'] = 'NetFX452MTPackHidden'
  h['NetFX46MTPackHidden']['selected'] = true
  h['NetFX46MTPackHidden']['friendly_name'] = 'NetFX46MTPackHidden'
  h['PortableDTPHidden']['selected'] = true
  h['PortableDTPHidden']['friendly_name'] = 'PortableDTPHidden'
  h['PreEmptiveDotfuscatorHidden']['selected'] = true
  h['PreEmptiveDotfuscatorHidden']['friendly_name'] = 'PreEmptiveDotfuscatorHidden'
  h['PreEmptiveAnalyticsHidden']['selected'] = true
  h['PreEmptiveAnalyticsHidden']['friendly_name'] = 'PreEmptiveAnalyticsHidden'
  h['ProfilerHidden']['selected'] = true
  h['ProfilerHidden']['friendly_name'] = 'ProfilerHidden'
  h['RoslynLanguageServicesHidden']['selected'] = true
  h['RoslynLanguageServicesHidden']['friendly_name'] = 'RoslynLanguageServicesHidden'
  h['SDKTools3Hidden']['selected'] = true
  h['SDKTools3Hidden']['friendly_name'] = 'SDKTools3Hidden'
  h['SDKTools4Hidden']['selected'] = true
  h['SDKTools4Hidden']['friendly_name'] = 'SDKTools4Hidden'
  h['WCFDataServicesHidden']['selected'] = true
  h['WCFDataServicesHidden']['friendly_name'] = 'WCFDataServicesHidden'
  h['NativeLanguageSupport_VCV1']['selected'] = false
  h['NativeLanguageSupport_VCV1']['hidden'] = false
  h['NativeLanguageSupport_VCV1']['friendly_name'] = 'Common Tools for Visual C++ 2015'
  h['NativeLanguageSupport_MFCV1']['selected'] = false
  h['NativeLanguageSupport_MFCV1']['hidden'] = false
  h['NativeLanguageSupport_MFCV1']['friendly_name'] = 'Microsoft Foundation Classes for C++'
  h['NativeLanguageSupport_XPV1']['selected'] = false
  h['NativeLanguageSupport_XPV1']['hidden'] = false
  h['NativeLanguageSupport_XPV1']['friendly_name'] = 'Windows XP Support for C++'
  h['Win81SDK_HiddenV1']['selected'] = false
  h['Win81SDK_HiddenV1']['hidden'] = false
  h['Win81SDK_HiddenV1']['friendly_name'] = 'Windows 8.1 SDK and Universal CRT SDK'
  h['FSharpV1']['selected'] = false
  h['FSharpV1']['hidden'] = false
  h['FSharpV1']['friendly_name'] = 'Visual F#'
  h['PythonToolsForVisualStudioV1']['selected'] = false
  h['PythonToolsForVisualStudioV1']['hidden'] = false
  h['PythonToolsForVisualStudioV1']['friendly_name'] = 'Python Tools for Visual Studio'
  h['ClickOnceV1']['selected'] = false
  h['ClickOnceV1']['hidden'] = false
  h['ClickOnceV1']['friendly_name'] = 'ClickOnce Publishing Tools'
  h['SQLV1']['selected'] = false
  h['SQLV1']['hidden'] = false
  h['SQLV1']['friendly_name'] = 'Microsoft SQL Server Data Tools'
  h['PowerShellToolsV1']['selected'] = false
  h['PowerShellToolsV1']['hidden'] = false
  h['PowerShellToolsV1']['friendly_name'] = 'PowerShell Tools for Visual Studio'
  h['SilverLight_Developer_KitV1']['selected'] = false
  h['SilverLight_Developer_KitV1']['hidden'] = false
  h['SilverLight_Developer_KitV1']['friendly_name'] = 'Silverlight Development Kit'
  h['XamarinVSCoreV1']['selected'] = false
  h['XamarinVSCoreV1']['hidden'] = false
  h['XamarinVSCoreV1']['friendly_name'] = 'C#/.NET (Xamarin)'
  h['MDDJSCoreV1']['selected'] = false
  h['MDDJSCoreV1']['hidden'] = false
  h['MDDJSCoreV1']['friendly_name'] = 'HTML/JavaScript (Apache Cordova)'
  h['AndroidNDKV1']['selected'] = false
  h['AndroidNDKV1']['hidden'] = false
  h['AndroidNDKV1']['friendly_name'] = 'Android Native Development Kit (R10E, 32 bits)'
  h['AndroidSDKV1']['selected'] = false
  h['AndroidSDKV1']['hidden'] = false
  h['AndroidSDKV1']['friendly_name'] = 'Android SDK'
  h['AndroidSDK_API1921V1']['selected'] = false
  h['AndroidSDK_API1921V1']['hidden'] = false
  h['AndroidSDK_API1921V1']['friendly_name'] = 'Android SDK Setup (API Level 19 and 21)'
  h['AndroidSDK_API22V1']['selected'] = false
  h['AndroidSDK_API22V1']['hidden'] = false
  h['AndroidSDK_API22V1']['friendly_name'] = 'Android SDK Setup (API Level 22)'
  h['AntV1']['selected'] = false
  h['AntV1']['hidden'] = false
  h['AntV1']['friendly_name'] = 'Apache Ant (1.9.3)'
  h['MDDCPlusPlus_iOSV1']['selected'] = false
  h['MDDCPlusPlus_iOSV1']['hidden'] = false
  h['MDDCPlusPlus_iOSV1']['friendly_name'] = 'Visual C++ iOS Development'
  h['MDDCPlusPlus_AndroidV1']['selected'] = false
  h['MDDCPlusPlus_AndroidV1']['hidden'] = false
  h['MDDCPlusPlus_AndroidV1']['friendly_name'] = 'Visual C++ Android Development'
  h['Node.jsV1']['selected'] = false
  h['Node.jsV1']['hidden'] = false
  h['Node.jsV1']['friendly_name'] = 'Joyent Node.js'
  h['VSEmu_AndroidV1']['selected'] = false
  h['VSEmu_AndroidV1']['hidden'] = false
  h['VSEmu_AndroidV1']['friendly_name'] = 'Microsoft Visual Studio Emulator for Android'
  h['WebSocket4NetV1']['selected'] = false
  h['WebSocket4NetV1']['hidden'] = false
  h['WebSocket4NetV1']['friendly_name'] = 'WebSocket4Net'
  h['ToolsForWin81_WP80_WP81V1']['selected'] = false
  h['ToolsForWin81_WP80_WP81V1']['hidden'] = false
  h['ToolsForWin81_WP80_WP81V1']['friendly_name'] = 'Tools and Windows SDKs'
  h['WindowsPhone81EmulatorsV1']['selected'] = false
  h['WindowsPhone81EmulatorsV1']['hidden'] = false
  h['WindowsPhone81EmulatorsV1']['friendly_name'] = 'Emulators for Windows Phone 8.1'
  h['GitHubVSV1']['selected'] = false
  h['GitHubVSV1']['hidden'] = false
  h['GitHubVSV1']['friendly_name'] = 'GitHub Extension for Visual Studio'
  h['VS_SDK_GroupV1']['selected'] = false
  h['VS_SDK_GroupV1']['hidden'] = false
  h['VS_SDK_GroupV1']['friendly_name'] = 'Visual Studio Extensibility Tools'
  h['VS_SDK_Breadcrumb_GroupV1']['selected'] = false
  h['VS_SDK_Breadcrumb_GroupV1']['friendly_name'] = 'Visual Studio Extensibility Tools'
end

# Enterprise w/Update1
default['visualstudio']['2015']['enterprise']['installer_file'] = 'vs_enterprise.exe'
default['visualstudio']['2015']['enterprise']['filename'] =
  'vs2015.1.ent_enu.iso'
default['visualstudio']['2015']['enterprise']['package_name'] =
  'Microsoft Visual Studio Enterprise 2015'
default['visualstudio']['2015']['enterprise']['checksum'] =
  'ea91fec301f1c105ef39826a72d21de5923f3d7a5857c25af3163526dd768639'
default['visualstudio']['2015']['enterprise']['default_source'] =
  'http://download.microsoft.com/download/6/C/9/6C95B548-64A9-4637-A7F2-EB2A750C7504'

# Defaults for the <SelectableItemCustomization> in AdminDeployment.xml
# These are DEFAULTS. If you wish to change the selectable items installed edit the node attributes
# default['visualstudio']['install_items']['<feature>']['selected'] etc. (see README)
default['visualstudio']['2015']['enterprise']['default_install_items'].tap do |h|
  h['NativeLanguageSupport_VCV1']['selected'] = false
  h['NativeLanguageSupport_VCV1']['hidden'] = false
  h['NativeLanguageSupport_VCV1']['friendly_name'] = 'Common Tools for Visual C++ 2015'
  h['NativeLanguageSupport_MFCV1']['selected'] = false
  h['NativeLanguageSupport_MFCV1']['hidden'] = false
  h['NativeLanguageSupport_MFCV1']['friendly_name'] = 'Microsoft Foundation Classes for C++'
  h['NativeLanguageSupport_XPV1']['selected'] = false
  h['NativeLanguageSupport_XPV1']['hidden'] = false
  h['NativeLanguageSupport_XPV1']['friendly_name'] = 'Windows XP Support for C++'
  h['Win81SDK_HiddenV1']['selected'] = false
  h['Win81SDK_HiddenV1']['hidden'] = false
  h['Win81SDK_HiddenV1']['friendly_name'] = 'Windows 8.1 SDK and Universal CRT SDK'
  h['FSharpV1']['selected'] = false
  h['FSharpV1']['hidden'] = false
  h['FSharpV1']['friendly_name'] = 'Visual F#'
  h['PythonToolsForVisualStudioV1']['selected'] = false
  h['PythonToolsForVisualStudioV1']['hidden'] = false
  h['PythonToolsForVisualStudioV1']['friendly_name'] = 'Python Tools for Visual Studio'
  h['ClickOnceV1']['selected'] = false
  h['ClickOnceV1']['hidden'] = false
  h['ClickOnceV1']['friendly_name'] = 'ClickOnce Publishing Tools'
  h['LightSwitchV1']['selected'] = false
  h['LightSwitchV1']['hidden'] = false
  h['LightSwitchV1']['friendly_name'] = 'LightSwitch'
  h['OfficeDeveloperToolsV1']['selected'] = false
  h['OfficeDeveloperToolsV1']['hidden'] = false
  h['OfficeDeveloperToolsV1']['friendly_name'] = 'Microsoft Office Developer Tools'
  h['SilverLight_Developer_KitV1']['selected'] = false
  h['SilverLight_Developer_KitV1']['hidden'] = false
  h['SilverLight_Developer_KitV1']['friendly_name'] = 'Silverlight Development Kit'
  h['Windows10_ToolsAndSDKV2']['selected'] = false
  h['Windows10_ToolsAndSDKV2']['hidden'] = false
  h['Windows10_ToolsAndSDKV2']['friendly_name'] = 'Tools (1.1.1) and Windows SDK (10.0.10240)'
  h['Win10_EmulatorV1']['selected'] = false
  h['Win10_EmulatorV1']['hidden'] = false
  h['Win10_EmulatorV1']['friendly_name'] = 'Emulators for Windows Mobile (10.0.10240)'
  h['XamarinVSCoreV1']['selected'] = false
  h['XamarinVSCoreV1']['hidden'] = false
  h['XamarinVSCoreV1']['friendly_name'] = 'C#/.NET (Xamarin)'
  h['MDDJSCoreV5']['selected'] = false
  h['MDDJSCoreV5']['hidden'] = false
  h['MDDJSCoreV5']['friendly_name'] = 'HTML/JavaScript (Apache Cordova) Update 4'
  h['AndroidNDKV1']['selected'] = false
  h['AndroidNDKV1']['hidden'] = false
  h['AndroidNDKV1']['friendly_name'] = 'Android Native Development Kit (R10E, 32 bits)'
  h['AndroidSDKV1']['selected'] = false
  h['AndroidSDKV1']['hidden'] = false
  h['AndroidSDKV1']['friendly_name'] = 'Android SDK'
  h['AndroidSDK_API1921V1']['selected'] = false
  h['AndroidSDK_API1921V1']['hidden'] = false
  h['AndroidSDK_API1921V1']['friendly_name'] = 'Android SDK Setup (API Level 19 and 21)'
  h['AndroidSDK_API22V1']['selected'] = false
  h['AndroidSDK_API22V1']['hidden'] = false
  h['AndroidSDK_API22V1']['friendly_name'] = 'Android SDK Setup (API Level 22)'
  h['AndroidSDK_API23V1']['selected'] = false
  h['AndroidSDK_API23V1']['hidden'] = false
  h['AndroidSDK_API23V1']['friendly_name'] = 'Android SDK Setup (API Level 23)'
  h['AntV1']['selected'] = false
  h['AntV1']['hidden'] = false
  h['AntV1']['friendly_name'] = 'Apache Ant (1.9.3)'
  h['MDDCPlusPlus_iOSV1']['selected'] = false
  h['MDDCPlusPlus_iOSV1']['hidden'] = false
  h['MDDCPlusPlus_iOSV1']['friendly_name'] = 'Visual C++ iOS Development'
  h['MDDCPlusPlus_AndroidV1']['selected'] = false
  h['MDDCPlusPlus_AndroidV1']['hidden'] = false
  h['MDDCPlusPlus_AndroidV1']['friendly_name'] = 'Visual C++ Android Development'
  h['JavaJDKV1']['selected'] = false
  h['JavaJDKV1']['hidden'] = false
  h['JavaJDKV1']['friendly_name'] = 'Java SE Development Kit (7.0.550.13)'
  h['Node.jsV1']['selected'] = false
  h['Node.jsV1']['hidden'] = false
  h['Node.jsV1']['friendly_name'] = 'Joyent Node.js'
  h['VSEmu_AndroidV1.0.50925.2']['selected'] = false
  h['VSEmu_AndroidV1.0.50925.2']['hidden'] = false
  h['VSEmu_AndroidV1.0.50925.2']['friendly_name'] =
    'Microsoft Visual Studio Emulator for Android (September 2015)'
  h['WebSocket4NetV1']['selected'] = false
  h['WebSocket4NetV1']['hidden'] = false
  h['WebSocket4NetV1']['friendly_name'] = 'WebSocket4Net'
  h['ToolsForWin81_WP80_WP81V1']['selected'] = false
  h['ToolsForWin81_WP80_WP81V1']['hidden'] = false
  h['ToolsForWin81_WP80_WP81V1']['friendly_name'] = 'Tools and Windows SDKs'
  h['WindowsPhone81EmulatorsV1']['selected'] = false
  h['WindowsPhone81EmulatorsV1']['hidden'] = false
  h['WindowsPhone81EmulatorsV1']['friendly_name'] = 'Emulators for Windows Phone 8.1'
  h['GitForWindowsV1']['selected'] = false
  h['GitForWindowsV1']['hidden'] = false
  h['GitForWindowsV1']['friendly_name'] = 'Git for Windows'
  h['GitHubVSV1']['selected'] = false
  h['GitHubVSV1']['hidden'] = false
  h['GitHubVSV1']['friendly_name'] = 'GitHub Extension for Visual Studio'
  h['VS_SDK_GroupV1']['selected'] = false
  h['VS_SDK_GroupV1']['hidden'] = false
  h['VS_SDK_GroupV1']['friendly_name'] = 'Visual Studio Extensibility Tools'
  h['VS_SDK_Breadcrumb_GroupV1']['selected'] = false
  h['VS_SDK_Breadcrumb_GroupV1']['friendly_name'] = 'Visual Studio Extensibility Tools'
  h['Win10_VSToolsV2']['selected'] = false
  h['Win10_VSToolsV2']['hidden'] = false
  h['Win10_VSToolsV2']['friendly_name'] =
    'Tools for Universal Windows Apps (1.1.1) and Windows SDK (10.0.10240)'
  h['Win10SDK_HiddenV1']['selected'] = false
  h['Win10SDK_HiddenV1']['friendly_name'] = 'Windows 10 SDK 10.0.10240'
  h['UWPPatch_KB3073097_HiddenV3']['selected'] = false
  h['UWPPatch_KB3073097_HiddenV3']['friendly_name'] = 'KB3073097'
  h['JavaScript_HiddenV1']['selected'] = false
  h['JavaScript_HiddenV1']['friendly_name'] = 'JavaScript Project System for Visual Studio'
  h['LocalDBHidden']['selected'] = false
  h['LocalDBHidden']['friendly_name'] = 'LocalDBHidden'
  h['ProfilerHidden']['selected'] = false
  h['ProfilerHidden']['friendly_name'] = 'ProfilerHidden'
  h['StoryboardingHidden']['selected'] = false
  h['StoryboardingHidden']['friendly_name'] = 'StoryboardingHidden'
  h['SQLV1']['selected'] = true
  h['SQLV1']['hidden'] = false
  h['SQLV1']['friendly_name'] = 'Microsoft SQL Server Data Tools'
  h['MDDJSDependencyHiddenV1']['selected'] = true
  h['MDDJSDependencyHiddenV1']['friendly_name'] = 'MDDJSDependencyHidden'
  h['BlissHidden']['selected'] = true
  h['BlissHidden']['friendly_name'] = 'BlissHidden'
  h['HelpHidden']['selected'] = true
  h['HelpHidden']['friendly_name'] = 'HelpHidden'
  h['IntelliTraceEnterpriseHidden']['selected'] = true
  h['IntelliTraceEnterpriseHidden']['friendly_name'] = 'IntelliTraceEnterpriseHidden'
  h['JavaScript']['selected'] = true
  h['JavaScript']['friendly_name'] = 'JavascriptHidden'
  h['NetFX4Hidden']['selected'] = true
  h['NetFX4Hidden']['friendly_name'] = 'NetFX4Hidden'
  h['NetFX45Hidden']['selected'] = true
  h['NetFX45Hidden']['friendly_name'] = 'NetFX45Hidden'
  h['NetFX451MTPackHidden']['selected'] = true
  h['NetFX451MTPackHidden']['friendly_name'] = 'NetFX451MTPackHidden'
  h['NetFX451MTPackCoreHidden']['selected'] = true
  h['NetFX451MTPackCoreHidden']['friendly_name'] = 'NetFX451MTPackCoreHidden'
  h['NetFX452MTPackHidden']['selected'] = true
  h['NetFX452MTPackHidden']['friendly_name'] = 'NetFX452MTPackHidden'
  h['NetFX46MTPackHidden']['selected'] = true
  h['NetFX46MTPackHidden']['friendly_name'] = 'NetFX46MTPackHidden'
  h['PortableDTPHidden']['selected'] = true
  h['PortableDTPHidden']['friendly_name'] = 'PortableDTPHidden'
  h['PreEmptiveDotfuscatorHidden']['selected'] = true
  h['PreEmptiveDotfuscatorHidden']['friendly_name'] = 'PreEmptiveDotfuscatorHidden'
  h['PreEmptiveAnalyticsHidden']['selected'] = true
  h['PreEmptiveAnalyticsHidden']['friendly_name'] = 'PreEmptiveAnalyticsHidden'
  h['RoslynLanguageServicesHidden']['selected'] = true
  h['RoslynLanguageServicesHidden']['friendly_name'] = 'RoslynLanguageServicesHidden'
  h['SDKTools3Hidden']['selected'] = true
  h['SDKTools3Hidden']['friendly_name'] = 'SDKTools3Hidden'
  h['SDKTools4Hidden']['selected'] = true
  h['SDKTools4Hidden']['friendly_name'] = 'SDKTools4Hidden'
  h['WCFDataServicesHidden']['selected'] = true
  h['WCFDataServicesHidden']['friendly_name'] = 'WCFDataServicesHidden'
  h['TypeScriptV3']['selected'] = true
  h['TypeScriptV3']['friendly_name'] = 'TypeScript 1.6.3.0 for Visual Studio'
  h['WebToolsV1']['selected'] = true
  h['WebToolsV1']['hidden'] = false
  h['WebToolsV1']['friendly_name'] = 'Microsoft Web Developer Tools'
  h['PowerShellToolsV1']['selected'] = true
  h['PowerShellToolsV1']['hidden'] = false
  h['PowerShellToolsV1']['friendly_name'] = 'PowerShell Tools for Visual Studio'
end
