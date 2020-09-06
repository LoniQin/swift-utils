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
    - [ ] Data
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
    - [ ] NSCacheStorage
    - [ ] UserDefaultsStorage
    - [ ] KeyChainStorage
    - [ ] StorageManager
- [ ] Logger
- [ ] Regex
- [ ] Database
- [ ] Networking
- [ ] Crypto


## Unwrap an `Optional` safely and elegantly
Swift `Optional` sometimes is very troublesome. We can handle them in an elegant way.
This is what **Unwrappable** looks like.
```swift
public protocol Unwrappable {
    
    static var defaultValue: Self { get }
    
}
```
If a type that confirms `Unwrappable`, its `Optional` type can call `unwrapped` property and return a default value if it's nil.
This is what `Default` looks like. Any `Optional` type can apply Default wrapper and return a custimized default value if it's nil.
```swift
@propertyWrapper
public struct Default<T> {

    public init(_ defaultValue: T)
    
    public var wrappedValue: T?

}
```
You can use `Default` property wrapper with following code. Working with `Unwrappable`, it's better.
```swift
struct Item {
  @Default(2) var intValue: Int?
  @Default(3) var doubleValue: Double?
  @Default("Hello") var stringValue: String?
}
var item = Item()
print(item.intValue.unwrapped) // 2
print(item.doubleValue.unwrapped) // 3
print(item.stringValue.unwrapped) // Hello
item.intValue = 4
item.doubleValue = 5
item.stringValue = "World"
print(item.intValue.unwrapped) // 4
print(item.doubleValue.unwrapped) // 5
print(item.stringValue.unwrapped) // World
```
