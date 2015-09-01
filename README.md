# VisualStudio Cookbook
This Chef cookbook installs Visual Studio 2010, 2012, 2013, 2015 from an ISO.

# Requirements

This cookbook assumes .NET 4.5/4.6 has already been installed and rebooted the system before running the VisualStudio cookbook. If you forget to install .NET first this cookbook will log a warning.

This cookbook requires 7-zip to be installed so it can extract the ISO. To ensure this happens this cookbook includes the [seven_zip](https://github.com/daptiv/seven_zip) default recipe.

## Supported OSs
- Windows 7
- Windows 8
- Windows 8.1
- Windows 10
- Windows Server 2008
- Windows Server 2008 R2
- Windows Server 2012
- Windows Server 2012 R2

### Windows Server 2008 SP1 and Windows 7
For Windows7 SP1 and Windows Server 2008 SP1 you must first install [KB2664825](http://support.microsoft.com/kb/2664825), otherwise the VS installer will reboot in the middle of the installation. See [Save yourself from insanity: Visual Studio 2012 silent install](https://gshaw0.wordpress.com/2013/09/06/save-yourself-from-insanity-visual-studio-2012-silent-install/) for more details. To avoid this it is recommended that you first install [SQL CE 4](http://www.microsoft.com/en-us/download/details.aspx?id=17876). You can install SQL CE 4 via Chef using the [sqlce cookbook](http://community.opscode.com/cookbooks/sqlce).

# Usage

Set the `node['visualstudio']['source']` attribute to the download location of the VisualStudio ISO, for example: http://example.com/installs. Then add `'visualstudio::default'` to your runlist.

By default this cookbook assumes you're installing VisualStudio 2012 Ultimate. If you'd like to install another edition set the 'edition' attribute to: 'professional', 'premium', or 'testprofessional'. If you'd like to install a different version set the 'version' attribute to: '2010', '2012', '2013', '2015'.

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

In order to install VisualStudio 2010, you must provide an unattend.ini template. A working example is included in this recipe. The template is required due to relative paths inside the recipe.

# Attributes

## Required
* `node['visualstudio']['source']` - Required, fully qualified http(s) path to the ISO directory. For example: http://example.com/installs. This should not include the ISO filename, only the path where to find the ISO.

## Optional
* `node['visualstudio']['enable_nuget_package_restore']` - true or false. Sets the system wide environment variable to enable MSBuild/VisualStudio package restore on build. This defaults to true.
* `node['visualstudio']['installs']` - An array of hashes that contain the various versions and editions of VS to install. See Usage above for an example.
* `node['visualstudio']['2010']['professional']['config_file']` - The name of the config file to use (i.e. unattend.ini) This should correspond to a template. Only required for Visual Studio 2010.

Each VS version/edition pair has their own unique attributes which can be overridden. The most common to override would be `checksum` and `filename`. For example, we can override the VS 2013 Professional checksum and file_name attributes like so:

```ruby
node.override['visualstudio']['2013']['professional']['checksum'] = 'c4930bb83454a2fcbc762da79a4227e92fdbef7d0b395c619829a36c3fb4ec54'
node.override['visualstudio']['2013']['professional']['file_name'] = 'My_vs2013.iso'
```

# Recipes

## default
Ensures all VisualStudio prereqs are installed first and then only runs the install recipe if they are met. You should add this recipe to your run list.

## install
Installs VisualStudio using the included AdminDeployment.xml. Included by the default recipe.

## nuget
Configures the enable_nuget_package_restore environment variable. Included by the default recipe.

## dotnet_prereq
Logs a warning if .NET is not installed. Included by the default recipe.

# Optional Recipes

## install_update
Installs VS 2012 SP4 from the VS2012.4.iso. Add this to your runlist to update to the latest VS2012 SP. By default you must place the iso in the same folder as the VS 2012 iso.

## install_updateweb
Same as above but it uses the web downloader.

## install_vsto
Installs the Microsoft Office Developer Tools for VS2012. Add this to your runlist if you need Office development tools for Office plugin development.

## LWRP

This recipe does nothing but makes the `visualstudio_edition` and `visualstudio_update` resource definitions available.

For example, to install Visual Studio 2010 using the `visualstudio_edition` definition:

```ruby
visualstudio_edition 'vs_2015_professional' do
  edition: 'professional',
  version: '2015',
  install_dir: 'C:\Program Files (x86)\Microsoft Visual Studio 14.0',
  source: 'http://localhost:8080/en_visual_studio_professional_2015_x86_x64_dvd_6846629',
  package_name: 'Microsoft Visual Studio Professional 2015',
  checksum: '8d6d9a13ccb7f409161518e07e610c12180f415995fa417fa1343a4f2f4ce74b',
  installer_file: 'vs_professional.exe'
end
```

# Author

Author:: Shawn Neal (sneal@daptiv.com)
