# Flying Civet iOS

Shinier, slimmer, better, faster.

![baby-civet-cat](https://camo.githubusercontent.com/08d9dbcbfee8b005869943189a8d05c342126254/687474703a2f2f6c2e79696d672e636f6d2f616f2f323031322f6e6577732f6f63746f6265722f6f637431312d63697665742d6361745f3633302e6a7067)

# Requirements

- Fastlane

  ```
  brew cask install fastlane
  ```

# Getting started

```
git clone git@github.com:pivotal-sg/flying-civet-ios
cd flying-civet-ios
match run
```

# Deploy to TestFlight

### 🚨 Disclaimer 🚨

_Please ensure that you are on `master` branch and
do not have any local unstaged/unpushed changes_

---

```
fastlane ios beta
```

Running this command will perform the following:
- Syncs code-signing profiles and certificates
- Increments, commits and pushes build number
- Builds the project
- Uploads the app to TestFlight

# Updating Fastlane

```
fastlane update_fastlane
```
