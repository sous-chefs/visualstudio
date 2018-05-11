# CHANGELOG for visualstudio

This file is used to list changes made in each version of visualstudio.

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

## 1.0.1:

* Exit code 3010 (reboot required) should not fail Chef run
* Fix install_update minitest failure on VS 2015
* Fix VisualStudio 2015 installation error (WebSocket4NetV1) on Windows 2012R2
* Increase VSTO installation timeout from 10m to 30m

## 1.0.0:

* Initial release to Chef SuperMarket

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
