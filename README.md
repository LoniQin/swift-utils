# FoundationLib

This library contains many powerful tools to work with Foundation Library.

## Functions
- [ ] Extensions
    - [x] Int
    - [x] UInt
    - [x] Double
    - [x] Float
    - [x] String
    - [x] NSObject
    - [x] NSLock
    - [x] DispatchQueue
    - [x] UserDefaults
- [ ] Property Wrappers
    - [x] Default
- [ ] Protocols
    - [x] DataStorageProtocol
    - [x] NumberConvertable
    - [x] Unwrappable
- [ ] Storage
    - [x] FileStorage
    - [x] MemoryCacheStorage
- [x] Test
    - [x] Assert


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
