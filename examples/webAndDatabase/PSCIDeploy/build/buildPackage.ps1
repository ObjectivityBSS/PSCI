<#
The MIT License (MIT)

Copyright (c) 2015 Objectivity Bespoke Software Specialists

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
#>

<#
.SYNOPSIS
Starts the build process. 

.DESCRIPTION
This is project-specific file that contains custom build steps.

.PARAMETER Version
Version number of the current build.
#>

param(
    [Parameter(Mandatory=$false)]
	[string]
	$Version
)


<# Get-ConfigurationPaths returns an object with the following properties:
   ProjectRootPath         - base directory of the project, relative to the directory where this script resides (it is used as a base directory for other directories)
   PackagesPath            - path to directory with packages
   PackagesExist           - $true if $PackagesPath exists and is valid PSCI package
   DeployConfigurationPath - path to directory with configuration files
   DeployScriptsPath       - path to directory with deploy.ps1
#>

$configPaths = Get-ConfigurationPaths
$projectRootPath = $configPaths.ProjectRootPath
$packagesPath = $configPaths.PackagesPath

Build-WebPackage -PackageName 'SampleWebApplication' -RestoreNuGet
Build-EntityFrameworkMigratePackage -PackageName 'Migrations' `
                                    -ProjectPath 'SampleWebApplication\DataModel\DataModel.csproj' `
                                    -MigrationsDir 'SampleWebApplication\DataModel\bin\Release' `
                                    -EntityFrameworkDir 'SampleWebApplication\packages\EntityFramework.6.1.2' 

# Package configuration scripts and PSCI itself
Build-DeploymentScriptsPackage 
