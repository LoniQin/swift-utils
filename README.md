# FoundationLib

This library contains many powerful tools to work with Foundation Library.

## Installation

### Swift Package Manager

Once you have your Swift package set up, you add this code to your Package.swift.

```swift
dependencies: [
    .package(url: "https://github.com/LoniQin/swift-foundation-lib", .upToNextMajor(from: "1.0.0"))
]
```

In Xcode, you can choose File->Swift Packages->Add Pakcage dependancies, and add https://github.com/LoniQin/swift-foundation-lib.


## Modules
- [ ] Extensions
    - [x] Int
    - [x] UInt
    - [x] Double
    - [x] Float
    - [x] String
    - [x] Data
    - [x] NSObject
    - [x] NSLock
    - [x] DispatchQueue
    - [x] UserDefaults
    - [ ] NSAttributedString
    - [ ] URLSession
    - [ ] URLRequest
- [ ] Property Wrappers
    - [x] Default
- [ ] Protocols
    - [x] DataStorageProtocol
    - [x] NumberConvertable
    - [x] Unwrappable
- [ ] Storage
    - [x] FileStorage
    - [x] MemoryCacheStorage
    - [x] NSCacheStorage
    - [x] UserDefaultsStorage
    - [x] StorageManager
    - [ ] KeyChainStorage

- [x] Regex
- [x] Networking
- [x] Crypto
- [ ] Localization
- [ ] Logger
- [ ] Database
- [ ] Data Compression
