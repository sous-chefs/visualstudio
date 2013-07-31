# VisualStudio Cookbook
Supports installing Visual Studio 2012 from an ISO.

# Requirements

Windows 7
Windows 2008

.NET framework 4.5

# Usage

Set the node['visualstudio']['url'] attribute to point to the Visual Studio 2012 Professional ISO and add 'visualstudio::default' to your runlist.

# Attributes

## Required
* `node['visualstudio']['url']` - Required, fully qualified path to the ISO. For example: http://myhost.example.com/en_visual_studio_professional_2012_x86_dvd_920779.iso

## Optional
* `node['visualstudio']['enable_nuget_package_restore']` - true or false. Sets the system wide environment variable to enable MSBuild/VisualStudio package restore on build. This defaults to true.
* `node['visualstudio']['checksum']` - SHA256 checksum of the ISO.
* `node['visualstudio']['package_name']` - The name of the package as it shows in Add/Remove programs. Defaults to Microsoft Visual Studio Professional 2012.
* `node['visualstudio']['installer_file']` - The name of the VisualStudio installer executable. Defaults to vs_professional.exe.

# Recipes

## default
Ensures all VisualStudio prereqs are installed first and then only runs the install recipe if they are met. You should add this recipe to your run list.

## install
Installs VisualStudio 2012 using the included AdminDeployment.xml. Excludes all components except for WebTools. Expression blend, Office tools etc are _not_ included. Also ensures 7-zip is installed so the ISO can be extracted. Included by the default recipe.

## nuget
Configures the enable_nuget_package_restore environment variable. Included by the default recipe.

## dotnet_prereq
Includes the dotnetframework cookbook and ensures .NET 4.5 is installed. Included by the default recipe.


# Author

Author:: Shawn Neal (sneal@daptiv.com)
