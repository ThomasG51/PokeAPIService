//
//  Pokemon.swift
//  PokeAPIService
//
//  Created by Thomas George on 28/02/2025.
//

import Foundation

// MARK: - Model

/// Model for Pokemon API Resource
///
public struct Pokemon: Decodable {
    public let id: Int
    public let name: String
    public let baseExperience: Int
    public let height: Int
    public let isDefault: Bool
    public let order: Int
    public let weight: Int
    public let abilities: [PokemonAbility]
    public let forms: [BaseResource]
    public let gameIndices: [VersionGameIndex]
    public let heldItems: [PokemonHeldItem]
    public let locationAreaEncounters: String
    public let moves: [PokemonMove]
    public let pastTypes: [PokemonTypePast]
    public let pastAbilities: [PokemonAbilityPast]
    public let sprites: PokemonSprites
    public let cries: PokemonCries
    public let species: BaseResource
    public let stats: [PokemonStat]
    public let types: [PokemonType]
}

// MARK: - Nested Types

public extension Pokemon {
    struct PokemonAbility: Decodable {
        public let isHidden: Bool
        public let slot: Int
        public let ability: BaseResource
    }

    struct PokemonHeldItem: Decodable {
        public let item: BaseResource
        public let versionDetails: [PokemonHeldItemVersion]
    }

    struct PokemonHeldItemVersion: Decodable {
        public let version: BaseResource
        public let rarity: Int
    }

    struct PokemonMove: Decodable {
        public let move: BaseResource
        public let versionGroupDetails: [PokemonMoveVersion]
    }

    struct PokemonMoveVersion: Decodable {
        public let moveLearnMethod: BaseResource
        public let versionGroup: BaseResource
        public let levelLearnedAt: Int
    }

    struct PokemonTypePast: Decodable {
        public let generation: BaseResource
        public let types: [PokemonType]
    }

    struct PokemonAbilityPast: Decodable {
        public let generation: BaseResource
        public let abilities: [PokemonAbility]
    }

    struct PokemonSprites: Decodable {
        public let frontDefault: String
        public let frontShiny: String?
        public let frontFemale: String?
        public let frontShinyFemale: String?
        public let backDefault: String?
        public let backShiny: String?
        public let backFemale: String?
        public let backShinyFemale: String?
        public let versions: Versions

        public struct Versions: Decodable {
            public let generationI: GenerationI
            public let generationII: GenerationII
            public let generationIII: GenerationIII
            public let generationIV: GenerationIV
            public let generationV: GenerationV
            public let generationVI: GenerationVI
            public let generationVII: GenerationVII
            public let generationVIII: GenerationVIII

            enum CodingKeys: String, CodingKey {
                case generationI = "generation-i"
                case generationII = "generation-ii"
                case generationIII = "generation-iii"
                case generationIV = "generation-iv"
                case generationV = "generation-v"
                case generationVI = "generation-vi"
                case generationVII = "generation-vii"
                case generationVIII = "generation-viii"
            }

            public struct GenerationI: Decodable {
                public let redBlue: VersionSprites
                public let yellow: VersionSprites

                enum CodingKeys: String, CodingKey {
                    case redBlue = "red-blue"
                    case yellow
                }
            }

            public struct GenerationII: Decodable {
                public let crystal: VersionSprites
                public let gold: VersionSprites
                public let silver: VersionSprites
            }

            public struct GenerationIII: Decodable {
                public let emerald: VersionSprites
                public let fireredLeafgreen: VersionSprites
                public let rubySapphire: VersionSprites

                enum CodingKeys: String, CodingKey {
                    case emerald
                    case fireredLeafgreen = "firered-leafgreen"
                    case rubySapphire = "ruby-sapphire"
                }
            }

            public struct GenerationIV: Decodable {
                public let diamondPearl: VersionSprites
                public let heartgoldSoulsilver: VersionSprites
                public let platinum: VersionSprites

                enum CodingKeys: String, CodingKey {
                    case diamondPearl = "diamond-pearl"
                    case heartgoldSoulsilver = "heartgold-soulsilver"
                    case platinum
                }
            }

            public struct GenerationV: Decodable {
                public let blackWhite: VersionSprites

                enum CodingKeys: String, CodingKey {
                    case blackWhite = "black-white"
                }
            }

            public struct GenerationVI: Decodable {
                let omegarubyAlphasapphire: VersionSprites
                // swiftlint:disable:next identifier_name
                let XY: VersionSprites

                enum CodingKeys: String, CodingKey {
                    case omegarubyAlphasapphire = "omegaruby-alphasapphire"
                    // swiftlint:disable:next identifier_name
                    case XY = "x-y"
                }
            }

            public struct GenerationVII: Decodable {
                let icons: VersionSprites
                let ultraSunUltraMoon: VersionSprites

                enum CodingKeys: String, CodingKey {
                    case icons
                    case ultraSunUltraMoon = "ultra-sun-ultra-moon"
                }
            }

            public struct GenerationVIII: Decodable {
                let icons: VersionSprites
            }

            public struct VersionSprites: Decodable {
                public let animated: VersionAnimatedSprites?
                public let backDefault: String?
                public let backFemale: String?
                public let backTransparent: String?
                public let backGray: String?
                public let backShiny: String?
                public let backShinyFemale: String?
                public let backShinyTransparent: String?
                public let frontDefault: String?
                public let frontFemale: String?
                public let frontTransparent: String?
                public let frontGray: String?
                public let frontShiny: String?
                public let frontShinyFemale: String?
                public let frontShinyTransparent: String?

                public struct VersionAnimatedSprites: Decodable {
                    public let backDefault: String?
                    public let backFemale: String?
                    public let backTransparent: String?
                    public let backGray: String?
                    public let backShiny: String?
                    public let backShinyFemale: String?
                    public let backShinyTransparent: String?
                    public let frontDefault: String?
                    public let frontFemale: String?
                    public let frontTransparent: String?
                    public let frontGray: String?
                    public let frontShiny: String?
                    public let frontShinyFemale: String?
                    public let frontShinyTransparent: String?
                }
            }
        }
    }

    struct PokemonCries: Decodable {
        public let latest: String
        public let legacy: String?
    }

    struct PokemonStat: Decodable {
        public let stat: BaseResource
        public let effort: Int
        public let baseStat: Int
    }

    struct PokemonType: Decodable {
        public let slot: Int
        public let type: BaseResource
    }
}
