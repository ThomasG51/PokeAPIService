# PokeAPIService

#### 📦 A package to use PokeAPI in Swift

![swift](https://img.shields.io/badge/Swift-5.10-orange?logo=Swift&logoColor=white)
![xcode-version](https://img.shields.io/badge/Xcode-16-blue?logo=xcode&logoColor=white)
![github actions](https://github.com/ThomasG51/PokeAPIService/actions/workflows/swift.yml/badge.svg)


## Resources by category

##### Pokemon
```swift
Pokemon
```
##### Games
```swift
Generation
```

## Network Requests

Each model above is an API resource that can fetch data directly from itself using the following functions

##### Fetch one object resource
```swift
let id: Int = 1
Pokemon.selectOne(by: id)

let name = "bulbasaur"
Pokemon.selectOne(by: name)
```

##### Fetch a list of object resources
```swift
Pokemon.selectAll()

Pokemon.selectAll(count: 151)

Pokemon.selectAll(from: 151, count: 100)
```

##### Fetch a list of base resources (only id, name, type)
```swift
Pokemon.baseResources(from: 0, count: 151)
```

> _⚠️ Some models can't use `SelectAll()` and `baseResources()` functions because the API doesn't allow it. As a result, these two methods are not available for these models._
