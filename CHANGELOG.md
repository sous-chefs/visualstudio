# CHANGELOG for visualstudio

This file is used to list changes made in each version of visualstudio.

## Unreleased

- resolved cookstyle error: attributes/default.rb:4:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: attributes/default.rb:7:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: attributes/vs2010.rb:4:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: attributes/vs2010.rb:7:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: attributes/vs2012.rb:4:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: attributes/vs2012.rb:7:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: attributes/vs2013.rb:4:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: attributes/vs2013.rb:7:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: attributes/vs2015.rb:4:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: attributes/vs2015.rb:7:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: libraries/matchers.rb:4:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: libraries/matchers.rb:6:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: libraries/matchers.rb:21:1 refactor: `Chef/Modernize/DefinesChefSpecMatchers`
- resolved cookstyle error: metadata.rb:6:1 refactor: `Chef/Modernize/RespondToInMetadata`
- resolved cookstyle error: metadata.rb:9:1 refactor: `Chef/RedundantCode/LongDescriptionMetadata`
- resolved cookstyle error: providers/edition.rb:4:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: providers/edition.rb:7:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: providers/edition.rb:29:1 refactor: `Chef/Modernize/WhyRunSupportedTrue`
- resolved cookstyle error: providers/update.rb:4:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: providers/update.rb:7:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: providers/update.rb:23:1 refactor: `Chef/Modernize/UnnecessaryMixlibShelloutRequire`
- resolved cookstyle error: providers/update.rb:28:1 refactor: `Chef/Modernize/WhyRunSupportedTrue`
- resolved cookstyle error: recipes/default.rb:4:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: recipes/default.rb:7:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: recipes/dotnet_prereq.rb:4:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: recipes/dotnet_prereq.rb:7:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: recipes/install.rb:4:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: recipes/install.rb:7:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: recipes/install.rb:22:1 refactor: `Chef/Correctness/IncorrectLibraryInjection`
- resolved cookstyle error: recipes/install_update.rb:4:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: recipes/install_update.rb:7:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: recipes/install_update.rb:22:1 refactor: `Chef/Correctness/IncorrectLibraryInjection`
- resolved cookstyle error: recipes/install_vsto.rb:4:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: recipes/install_vsto.rb:7:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: recipes/install_vsto.rb:22:1 refactor: `Chef/Correctness/IncorrectLibraryInjection`
- resolved cookstyle error: recipes/nuget.rb:4:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: recipes/nuget.rb:7:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: resources/edition.rb:4:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: resources/edition.rb:7:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: resources/update.rb:4:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: resources/update.rb:7:1 refactor: `Chef/Style/CommentFormat`

## 2.0.0

* Support Chef 13, drop support for Chef 12.
* Fix VS 2015 Community package name.
* Use ServerRunner instead of SoloRunner for ChefSpec tests.
* Use Windows 2012R2 as target for both ChefSpec and Test Kitchen.
* Use Chef 13 for Test Kitchen since minitest-handler is incompatible with Chef 14.
* Standardize testing environment across repos.  (AppVeyor, Kitchen, Rake, etc.)
* Upgrade development dependencies.

## 1.2.0

* Default to VS 2015 Community Edition
* Add ability to specifiy installed features via install_items attributes.
* Add default_source URLs for VS 2013 and 2015, make source attribute optional.
* Add ability to specifiy download source on a per edition/version basis.
* [GH 58](https://github.com/daptiv/visualstudio/issues/58) Fix enable nuget package restore recipe idempotence.
* [GH 56](https://github.com/daptiv/visualstudio/issues/56) Fix architecture check.

## 1.1.0

* VS 2010 installation defaults to /q without needing an unattend.ini file.
* VS 2012 Update 5.
* VS 2015 Enterprise edition added.
* Product key is now configurable via a node attribute.
* Replaced Tailor with RuboCop and upgraded development dependencies.
* Fixed "Win32::Registry::Error".
* Added TravisCI build.

## 1.0.1

* Exit code 3010 (reboot required) should not fail Chef run
* Fix install_update minitest failure on VS 2015
* Fix VisualStudio 2015 installation error (WebSocket4NetV1) on Windows 2012R2
* Increase VSTO installation timeout from 10m to 30m

## 1.0.0

* Initial release to Chef SuperMarket

- - -
Refer to the [Markdown Syntax Guide](https://daringfireball.net/projects/markdown/syntax) for help with standard Markdown, and [Writing on GitHub](https://help.github.com/categories/writing-on-github/) for help with the GitHub dialect of Markdown.
