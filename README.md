# PokeAPIService

#### 📦 A package to use PokeAPI in Swift

![swift](https://img.shields.io/badge/Swift-5.10-orange?logo=Swift&logoColor=white)
![xcode-version](https://img.shields.io/badge/Xcode-16-blue?logo=xcode&logoColor=white)
![github actions](https://github.com/ThomasG51/PokeAPIService/actions/workflows/swift.yml/badge.svg)

> ⚠️ <br>
> As the package is still in development phase, not all PokeAPI resources are available yet <br>
> Please check-out the [resources by category](#resources-by-category) section.

## Installation

#### Swift Package Manager
```swift
.package(url: "https://github.com/ThomasG51/PokeAPIService", from: "<version>")
```

#### Xcode Package Dependency
```
https://github.com/ThomasG51/PokeAPIService
```

## Network Requests

Each model above is an API resource that can fetch data directly from itself using the following functions

##### Fetch one object by ID or name
```swift
// Fetch by id

let pokemonID = 1
Pokemon.selectOne(by: pokemonID)

let generationID = 1
Generation.selectOne(by: generationID)

let pokedexID = 1
Pokedex.selectOne(by: pokedexID)

let gameVersionID = 1
GameVersion.selectOne(by: gameVersionID)


// Fetch by name

let pokemonName = "bulbasaur"
Pokemon.selectOne(by: pokemonName)

let generationName = "generation-i"
Generation.selectOne(by: generationName)

let pokedexName = "kanto"
Pokedex.selectOne(by: pokedexName)

let gameVersionName = "red"
GameVersion.selectOne(by: gameVersionName)
```

##### Fetch a list of objects
```swift
Pokemon.selectAll(from: 151, count: 100)

Generation.selectAll() // Without count argument, the list will be paginate by 20 by default

Pokedex.selectAll(count: 3)

GameVersion.selectAll(from: 0, count: 1)
```

##### Fetch a list of base resources (only id, name and type)
```swift
Pokemon.baseResources(from: 0, count: 151)

Generation.baseResources(from: 0, count: 1)

Pokedex.baseResources(from: 1, count: 1)

GameVersion.baseResources(from: 0, count: 4)
```

<h2 id="resources-by-category">Resources by category</h2>

##### Pokemon

- [ ] Ability
- [x] Pokemon
- [ ] PokemonColor
- [ ] PokemonLocationArea
- [ ] PokemonForm
- [ ] PokemonHabitat
- [ ] PokemonShape
- [ ] PokemonSpecies
- [ ] PokemonType
- [ ] Stat

##### Games

- [x] GameVersion
- [x] GameVersionGroup
- [x] Generation
- [x] Pokedex

##### Berries

- [x] Berry
- [ ] BerryFirmness
- [ ] BerryFlavor
