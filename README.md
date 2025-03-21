# PokeAPIService

![swift](https://img.shields.io/badge/Swift-5.10-orange?logo=Swift&logoColor=white)
![xcode-version](https://img.shields.io/badge/Xcode-16-blue?logo=xcode&logoColor=white)
![github actions](https://github.com/ThomasG51/PokeAPIService/actions/workflows/swift.yml/badge.svg)

#### A package to use PokeAPI in Swift

###### Fetch a list of base resources (only id, name, type)
```swift
Pokemon.baseResources(from: 0, count: 151)
```

###### Fetch a list of object resources
```swift
Pokemon.selectAll()

Pokemon.selectAll(count: 151)

Pokemon.selectAll(from: 151, count: 100)
```

###### Fetch one object resource
```swift
let id: Int = 1
Pokemon.selectOne(by: id)

let name = "bulbasaur"
Pokemon.selectOne(by: name)
```
