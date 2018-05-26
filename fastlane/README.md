fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios p
```
fastlane ios p
```
Practice
### ios version
```
fastlane ios version
```

### ios version_patch
```
fastlane ios version_patch
```
Bumps version. Type: patch
### ios version_minor
```
fastlane ios version_minor
```
Bumps version. Type: minor
### ios version_major
```
fastlane ios version_major
```
Bumps version. Type: major
### ios tests
```
fastlane ios tests
```
Runs all the tests
### ios build
```
fastlane ios build
```
Build
### ios meta
```
fastlane ios meta
```
Sets Meta
### ios codeSign
```
fastlane ios codeSign
```
Sets Code Sign
### ios matching
```
fastlane ios matching
```
Sets match for provisioning profiles
### ios oneSig
```
fastlane ios oneSig
```

### ios refresh_dsyms
```
fastlane ios refresh_dsyms
```
Refreshes DSYMS
### ios screenShot
```
fastlane ios screenShot
```
Screenshots
### ios silent_beta
```
fastlane ios silent_beta
```

### ios beta
```
fastlane ios beta
```
Creates Beta
### ios deploy
```
fastlane ios deploy
```
Deploy a new version to the App Store
### ios screenShotFiller
```
fastlane ios screenShotFiller
```
Screenshot Filler
### ios testFlightBeta
```
fastlane ios testFlightBeta
```
Testflight Update

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
