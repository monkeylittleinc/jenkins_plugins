# CHANGELOG

--------------------------------------------------------------------------------

## 1.2.2
### Improvements
- Maven version is now a string not an integer

## 1.2.1
### Improvements
- Add id attribute so it can be specified by wrapper cookbooks.

## 1.2.0
### Features
- Added artifactory lwrp

### Improvements
- Added custom matchers for ChefSpec

### Bug fixes
- Fixed tests for git

## 1.1.0
### Features
- Added git lwrp

### Improvements
- Added serverspec tests
- Added fixture cookbooks for testing with serverspec
- Leveraged the ssh cookbook for the ssh config lwrp
- Made all lwrp's idempotent

## 1.0.0
Initial release of jenkins_lwrp
