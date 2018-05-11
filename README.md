[![Cookbook Version](http://img.shields.io/cookbook/v/visualstudio.svg)](https://supermarket.chef.io/cookbooks/visualstudio)
[![Build status](https://ci.appveyor.com/api/projects/status/ttumjhmmxjo5j7gv/branch/master?svg=true)](https://ci.appveyor.com/project/ChefWindowsCookbooks65871/visualstudio/branch/master)

# VisualStudio Cookbook
This Chef cookbook installs Visual Studio 2010, 2012, 2013, 2015 from an ISO.

# Requirements

This cookbook assumes the appropriate version of the .NET framework has already been installed before running the VisualStudio cookbook. To install .NET you can use the [dotnetframework cookbook](https://supermarket.chef.io/cookbooks/dotnetframework). You must reboot the system after the .NET installation and before the VisualStudio installation.

- VisualStudio 2010, 2012, and 2013 require .NET 4.5.x.
- VisualStudio 2015 requires .NET 4.6.

This cookbook requires 7-zip to be installed so it can extract the ISO. To ensure this happens this cookbook includes the [seven_zip](https://supermarket.chef.io/cookbooks/seven_zip) default recipe.

NOTE - This cookbook cannot be installed over naked WinRM, i.e. knife-winrm without failing with error 1603. This cookbook will work via test-kithen with an elevated user.

## Supported Visual Studio Editions/Versions
- 2010 Professional
- 2012 Professional
- 2012 Test Professional
- 2012 Premium
- 2012 Ultimate
- 2013 Professional
- 2013 Test Professional
- 2013 Premium
- 2013 Ultimate
- 2013 Community
- 2015 Enterprise
- 2015 Professional
- 2015 Test Professional
- 2015 Community

## Supported OSs
- Windows 7
- Windows 8
- Windows 8.1
- Windows 10
- Windows Server 2008
- Windows Server 2008 R2
- Windows Server 2012
- Windows Server 2012 R2

### VS 2012 on Windows Server 2008 SP1 and Windows 7
For Windows7 SP1 and Windows Server 2008 SP1 you must first install [KB2664825](http://support.microsoft.com/kb/2664825), otherwise the VS installer will reboot in the middle of the installation. See [Save yourself from insanity: Visual Studio 2012 silent install](https://gshaw0.wordpress.com/2013/09/06/save-yourself-from-insanity-visual-studio-2012-silent-install/) for more details. To avoid this it is recommended that you first install [SQL CE 4](http://www.microsoft.com/en-us/download/details.aspx?id=17876). You can install SQL CE 4 via Chef using the [sqlce cookbook](http://community.opscode.com/cookbooks/sqlce).

### VS 2015 on Windows Server 2012 R2
If you _really_ want to install VS 2015 on Windows Server 2012R2 over naked WinRM, you can if you first install [KB2999226](http://support.microsoft.com/kb/2999226), otherwise the VS installer will fail with error 1603.

# Attributes

## Optional

| Key | Type | Description | Default |
|-----|------|-------------|---------|
| `['visualstudio']['source']` | URL | HTTP(S) root URL beneath which ISOs for all versions/editions of Visual Studio are stored. | |
| `['visualstudio'][VERSION][EDITION]['source']` | URL | HTTP(S) root URL beneath which the ISO for a specific `VERSION` and `EDITION` of Visual Studio is stored. `VERSION` and `EDITION` should be replaced with one of the supported Visual Studio versions/editions. This attribute, when set, takes precedence over `node['visualstudio']['source']`. | |
| `['visualstudio'][VERSION]['update']['source']` | URL | HTTP(S) root URL beneath which the update ISO for a specific `VERSION` is stored. | |
| `['visualstudio']['edition']` | Boolean | The Visual Studio edition to install, i.e. community, professional, premium, ultimate, testprofessional. | `community` |
| `['visualstudio']['version']` | Integer | The Visual Studio version to install, i.e. 2010, 2012, 2013, 2015. | `2015` |
| `['visualstudio']['enable_nuget_package_restore']` | Boolean | Sets the system wide environment variable to enable MSBuild/Visual Studio package restore on build. | `True` |
| `['visualstudio']['installs']` | Array | An array of hashes that contain the various versions and editions of Visual Studio to install. See Usage below for an example. | |
| `['visualstudio']['install_items'][FEATURE]['selected']` | Boolean | Configures the feature on/off. This currently applies to all versions/editions being installed. | |
| `['visualstudio']['2010']['professional']['config_file']` | String | The name of the Visual Studio 2010 unattend.ini template to use. | |

# Usage

Add `'visualstudio::default'` to your runlist. This will install VS 2015 Community Edition from the publicly available ISO. If you'd like to install another edition set the 'edition' attribute to: 'community', 'professional', 'premium', or 'testprofessional'. If you'd like to install a different version set the 'version' attribute to: '2010', '2012', '2013', '2015'.

If you need to install multiple different versions/editions of VisualStudio on the same node you must instead set the 'installs' attribute. If the installs attribute is set then the version and edition attributes are ignored.

```ruby
node['visualstudio']['installs'] = [{
  'version' => '2015',
  'edition' => 'professional'
}, {
  'version' => '2013',
  'edition' => 'testprofessional'
}]
```

Each VS version/edition pair has their own unique attributes which can be overridden. The most common to override would be `checksum`,  `filename`, and `source`. For example, we can override the VS 2013 Professional checksum and filename attributes like so:

```ruby
node.override['visualstudio']['2013']['professional']['checksum'] = 'c4930bb83454a2fcbc762da79a4227e92fdbef7d0b395c619829a36c3fb4ec54'
node.override['visualstudio']['2013']['professional']['filename'] = 'My_vs2013.iso'
node.override['visualstudio']['2013']['professional']['source'] = 'https://myartifactrepo.example.com/visualstudio/'
```

VisualStudio 2013 and newer have default public download links for all their ISOs. If you're using an older version (2010, 2012) you must first set a download source. Either set the global `node['visualstudio']['source']` download URL or the version/edition specific download source, e.g. `node['visualstudio']['2012']['professional']['source']`. You can also use these same attributes to override the ISO location for newer VS versions.

## Customizing Installed Features
### VS 2012 and Newer

To customize the AdminDeployment.xml file for adding features to an unattended install in VisualStudio 2012 and newer edit the node attribute `node['visualstudio']['install_items']`
adding the 'id' of the `<SelectableItemCustomization>` you want to install, it's 'Selected', 'Hidden', and 'FriendlyName' can then be set assuming the item has the attribute(s).

For example:
`node['visualstudio']['install_items']['NativeLanguageSupport_VCV1']['selected']= true`
while you could also modify the 'Hidden' and 'FriendlyName' attributes for 'NativeLanguageSupport_VCV1' there's rarely a reason to as you won't see the installer anyway.

__Note:__
Do not edit the `node['visualstudio'][<version>][<edition>]['default_install_items']` these are the defaults for the AdminDeployment.xml file if you wish to change the settings see above,
`node['visualstudio']['install_items']` is merged with these effectively overwriting with the desired settings.

### VS 2010

Unlike newer versions of VisualStudio which use an AdminDeployment.xml file, VS 2010 uses an unattend.ini file, which, among other things, is OS-specific. By default, this cookbook uses VS 2010's `/q` option, which works for all Windows versions and specifies a default installation. To customize the installation, you may specify an unattend.ini template instead. The use of a template instead of a static file is required due to relative paths inside the file. This cookbook includes an unattend.ini template sample.

# Recipes

## default
Ensures all VisualStudio prereqs are installed first and then only runs the install recipe if they are met. You should add this recipe to your run list.

## install
Installs VisualStudio using the included AdminDeployment.xml or default silent install. Included by the default recipe.

## nuget
Configures the enable_nuget_package_restore environment variable. Included by the default recipe.

## dotnet_prereq
Logs a warning if .NET 4.5.x is not installed. This recipe does not curently check for .NET 4.6. Included by the default recipe.

# Optional Recipes

## install_update
Installs VS updates from the corresponding VS update ISO that is publicly downloadable from Microsoft. Add this to your runlist to update all versions of VS in your installs attribute array.

## install_vsto
Installs the Microsoft Office Developer Tools for Visual Studio 2012. Add this to your runlist if you need Office development tools for Office plugin development. Other versions of VS are not currently supported and will log a Chef warning.

# Resource/Provider

This cookbook makes the `visualstudio_edition` and `visualstudio_update` resource definitions available.

For example, to install Visual Studio 2015 Pro using the `visualstudio_edition` definition:

```ruby
visualstudio_edition 'vs_2015_professional' do
  edition: 'professional',
  version: '2015',
  install_dir: 'C:\Program Files (x86)\Microsoft Visual Studio 14.0',
  source: 'http://localhost:8080/en_visual_studio_professional_2015_x86_x64_dvd_6846629.iso',
  package_name: 'Microsoft Visual Studio Professional 2015',
  checksum: '8d6d9a13ccb7f409161518e07e610c12180f415995fa417fa1343a4f2f4ce74b',
  installer_file: 'vs_professional.exe'
end
```

# Troubleshooting

If the installer fails very early in the install process, check a few of things:

- Ensure you have the correct .NET version installed first and you've rebooted.
- Check the VS installation log which is located in c:\program files (x86)\Microsoft Visual Studio &lt;version&gt;\vsinstall.log
- Ensure you're not running over naked WinRM, i.e. knife-winrm or test-kitchen. Unfortunately because of the Windows security model this cookbook will not work over WinRM without a scheduled task.

# TO DO

- Check for .NET 4.6 installed, but only if VS 2015 is going to be installed
- Support VSTO on all versions of VS
- More tests
- Refactor duplication between cookbook helper and test helper

# Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. add-vsto-support-for-vs2010)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the build and ensure it passes. `bundle install && bundle exec rake && kitchen verify`
6. Submit a Pull Request

# Author

Author:: Shawn Neal (sneal@sneal.net)
