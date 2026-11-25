# CydiaClone — visual Cydia for non-jailbroken devices

Fork of [lgq2015/CydiaClone](https://github.com/lgq2015/CydiaClone) (2017, Swift 3), migrated to modern Swift 5 / Xcode 26 so it builds and runs on current iOS.

This is a **visual clone only**: it shows the classic Cydia home page (local `homepage.htm`, the real 2016 Cydia home UI), the five tabs (Cydia / Sources / Changes / Installed / Search) and the classic tab icons. It installs nothing and does not touch the system — it works on a non-jailbroken device.

## Changes from upstream
- Swift 3 → Swift 5, deployment target iOS 10 → 17.0, bundle id `com.hmk849.cydia`
- `UIWebView` → `WKWebView` (created in code; removed from the storyboard)
- Removed the `UISearchDisplayController` from the storyboard (removed from the SDK)
- Removed the first-launch `exit(0)` behaviour (the original app closed itself on first run)
- App icon: classic Cydia icon upscaled to 1024 (CgBI PNGs decoded)

## Build
Tag a version (`v1.0.0`) and the GitHub Actions workflow builds an unsigned IPA and publishes it as a Release. Sign it with LCSign (ordinary certificate) to install.
