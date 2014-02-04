# VisualStudio Cookbook
This Chef cookbook installs Visual Studio 2012 from an ISO.

# Requirements

This cookbook assumes .NET 4.5 has already been installed and rebooted the system before running the VisualStudio cookbook. If you forget to install .NET 4.5 first this cookbook will log a warning.

This cookbook requires 7-zip to be installed so it can extract the ISO. To ensure this happens this cookbook includes the [seven_zip](https://github.com/daptiv/seven_zip) default recipe.

For Windows7 SP1 and Windows Server 2008 SP1 you must first install [KB2664825](http://support.microsoft.com/kb/2664825), otherwise the VS installer will reboot in the middle of the installation. To avoid this it is recommended that you first install [SQL CE 4](http://www.microsoft.com/en-us/download/details.aspx?id=17876). You can install SQL CE 4 via Chef using the [sqlce cookbook](http://community.opscode.com/cookbooks/sqlce).

Windows 7
Windows 2008

.NET Framework 4.5

# Usage

Set the `node['visualstudio']['source']` attribute to the download location of the VisualStudio ISO and add 'visualstudio::default' to your runlist. For example: http://example.com/installs

By default this cookbook assumes you're installing VisualStudio 2012 Ultimate. If you'd like to install another version set the 'edition' attribute to: 'professional', 'premium', or 'testprofessional'.

# Attributes

## Required
* `node['visualstudio']['source']` - Required, fully qualified http(s) path to the ISO directory. For example: http://example.com/installs

## Optional
* `node['visualstudio']['enable_nuget_package_restore']` - true or false. Sets the system wide environment variable to enable MSBuild/VisualStudio package restore on build. This defaults to true.
* `node['visualstudio']['checksum']` - SHA256 checksum of the ISO.
* `node['visualstudio']['package_name']` - The name of the package as it shows in Add/Remove programs. Defaults to Microsoft Visual Studio Ultimate 2012.
* `node['visualstudio']['installer_file']` - The name of the VisualStudio installer executable. Defaults to vs_ultimate.exe.

# Recipes

## default
Ensures all VisualStudio prereqs are installed first and then only runs the install recipe if they are met. You should add this recipe to your run list.

## install
Installs VisualStudio 2012 using the included AdminDeployment.xml. Ensures 7-zip is installed so the ISO can be extracted via the seven_zip cookbook. Included by the default recipe.

## nuget
Configures the enable_nuget_package_restore environment variable. Included by the default recipe.

## dotnet_prereq
Logs a warning if .NET 4.5 is not installed. This is included in the default recipe.

# Optional Recipes

## install_update
Installs VS 2012 SP4 from the VS2012.4.iso. Add this to your runlist to update to the latest VS2012 SP. By default you must place the iso in the same folder as the VS 2012 iso.

## install_updateweb
Same as above but it uses the web downloader.

## install_vsto
Installs the Microsoft Office Developer Tools for VS2012. Add this to your runlist if you need Office development tools for Office plugin development.

# Author

Author:: Shawn Neal (sneal@daptiv.com)
