# ``PokeAPIService``

## Overview

This Swift package provides a comprehensive and efficient solution for accessing and utilizing data related to Pokemon from the [PokeAPI](https://pokeapi.co). 
It simplifies the process of fetching, parsing, and managing Pokemon information within your iOS applications.

```swift
/// Example of fetching a Pokemon
///
Task {
    do {
        let pokemonName = "pikachu"
        let pikachu = try await Pokemon.selectOne(by: pokemonName)
    } catch {
        print(error.localizedDescription)
    }
 }
```

## How to fetch data


