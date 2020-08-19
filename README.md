# FoundationLib

This library contains many powerful tools to work with Foundation Library.


## Unwrappable and Default
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
