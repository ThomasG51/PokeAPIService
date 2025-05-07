# PokeAPIService

![](https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png)
![](https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png)
![](https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/9.png)
![](https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/144.png)
![](https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/145.png)
![](https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/146.png)

This Swift package provides a comprehensive and efficient solution for accessing and utilizing data related to Pokemon from the [PokeAPI](https://pokeapi.co). 
It simplifies the process of fetching, parsing, and managing Pokemon information within your iOS applications.

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

## How to use ?

A core strength of this package is its ability to seamlessly fetch data directly from each model. Each Pokemon, Pokedex, Generation or other can initiate a request to PokeAPI and populate its properties.

> ⚠️
> Please note that due to restrictions by the underlying API, some models do not have acces to all fetching functions. 
> Refer to the specific model documentation for more details.

### Examples:

#### Fetch one object by ID
```swift
let pokemonID = 1
Pokemon.selectOne(by: pokemonID)

let generationID = 1
Generation.selectOne(by: generationID)

let pokedexID = 1
Pokedex.selectOne(by: pokedexID)

let versionID = 1
Version.selectOne(by: versionID)
```

#### Fetch one object by name
```swift
let pokemonName = "bulbasaur"
Pokemon.selectOne(by: pokemonName)

let generationName = "generation-i"
Generation.selectOne(by: generationName)

let pokedexName = "kanto"
Pokedex.selectOne(by: pokedexName)

let versionName = "red"
Version.selectOne(by: versionName)
```

#### Fetch a list of objects
```swift
Pokemon.selectAll(from: 151, count: 100)

Generation.selectAll() // Without count argument, the list will be paginate by 20 by default

Pokedex.selectAll(count: 3)

Version.selectAll(from: 0, count: 1)
```

#### Fetch a list of light resources (only id, name and type)
```swift
Pokemon.lightResources(from: 0, count: 151)

Generation.lightResources(from: 0, count: 1)

Pokedex.lightResources(from: 1, count: 1)

Version.lightResources(from: 0, count: 4)
```

<h2 id="resources-by-category">Resources by category</h2>

#### Berries

- [x] Berry
- [x] BerryFirmness
- [x] BerryFlavor

#### Games

- [x] Generation
- [x] Pokedex
- [x] Version
- [x] VersionGroup

#### Pokemon

- [x] Ability
- [x] Characteristic
- [x] EggGroup
- [x] Gender
- [x] GrowthRate
- [ ] Nature
- [ ] PokeathlonStat
- [x] Pokemon
- [ ] PokemonColor
- [ ] PokemonLocationArea
- [ ] PokemonForm
- [ ] PokemonHabitat
- [ ] PokemonShape
- [ ] PokemonSpecies
- [ ] PokemonType
- [ ] Stat

## License

PokeAPIService is available under the [MIT license](LICENSE).
