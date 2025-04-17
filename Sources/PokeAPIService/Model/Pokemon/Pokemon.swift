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
    public let abilities: [Ability]
    public let forms: [BaseResource]
    public let gameIndices: [VersionGameIndex]
    public let heldItems: [HeldItem]
    public let locationAreaEncounters: String
    public let moves: [Move]
    public let pastTypes: [TypePast]
    public let sprites: Sprites
    public let cries: Cries
    public let species: BaseResource
    public let stats: [Stat]
    public let types: [PokemonType]

    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case baseExperience = "base_experience"
        case height
        case isDefault = "is_default"
        case order
        case weight
        case abilities
        case forms
        case gameIndices = "game_indices"
        case heldItems = "held_items"
        case locationAreaEncounters = "location_area_encounters"
        case moves
        case pastTypes = "past_types"
        case sprites
        case cries
        case species
        case stats
        case types
    }
}

// MARK: - Nested Types

public extension Pokemon {
    struct Ability: Decodable {
        public let isHidden: Bool
        public let slot: Int
        public let ability: BaseResource

        public enum CodingKeys: String, CodingKey {
            case isHidden = "is_hidden"
            case slot
            case ability
        }
    }

    struct HeldItem: Decodable {
        public let item: BaseResource
        public let versionDetails: [HeldItemVersionDetail]

        public enum CodingKeys: String, CodingKey {
            case item
            case versionDetails = "version_details"
        }
    }

    struct HeldItemVersionDetail: Decodable {
        public let version: BaseResource
        public let rarity: Int
    }

    struct Move: Decodable {
        public let move: BaseResource
        public let versionGroupDetails: [MoveVersion]

        enum CodingKeys: String, CodingKey {
            case move
            case versionGroupDetails = "version_group_details"
        }
    }

    struct MoveVersion: Decodable {
        public let moveLearnMethod: BaseResource
        public let versionGroup: BaseResource
        public let levelLearnedAt: Int

        enum CodingKeys: String, CodingKey {
            case moveLearnMethod = "move_learn_method"
            case versionGroup = "version_group"
            case levelLearnedAt = "level_learned_at"
        }
    }

    struct TypePast: Decodable {
        public let generation: BaseResource
        public let types: [PokemonType]
    }

    struct PokemonType: Decodable {
        public let slot: Int
        public let type: BaseResource
    }

    struct Sprites: Decodable {
        public let frontDefault: String
        public let frontShiny: String?
        public let frontFemale: String?
        public let frontShinyFemale: String?
        public let backDefault: String?
        public let backShiny: String?
        public let backFemale: String?
        public let backShinyFemale: String?
        public let versions: Versions

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
            case frontShiny = "front_shiny"
            case frontFemale = "front_female"
            case frontShinyFemale = "front_shiny_female"
            case backDefault = "back_default"
            case backShiny = "back_shiny"
            case backFemale = "back_female"
            case backShinyFemale = "back_shiny_female"
            case versions
        }

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

                enum CodingKeys: String, CodingKey {
                    case animated
                    case backDefault = "back_default"
                    case backFemale = "back_female"
                    case backTransparent = "back_transparent"
                    case backGray = "back_gray"
                    case backShiny = "back_shiny"
                    case backShinyFemale = "back_shiny_female"
                    case backShinyTransparent = "back_shiny_transparent"
                    case frontDefault = "front_default"
                    case frontFemale = "front_female"
                    case frontTransparent = "front_transparent"
                    case frontGray = "front_gray"
                    case frontShiny = "front_shiny"
                    case frontShinyFemale = "front_shiny_female"
                    case frontShinyTransparent = "front_shiny_transparent"
                }

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

                    enum CodingKeys: String, CodingKey {
                        case backDefault = "back_default"
                        case backFemale = "back_female"
                        case backTransparent = "back_transparent"
                        case backGray = "back_gray"
                        case backShiny = "back_shiny"
                        case backShinyFemale = "back_shiny_female"
                        case backShinyTransparent = "back_shiny_transparent"
                        case frontDefault = "front_default"
                        case frontFemale = "front_female"
                        case frontTransparent = "front_transparent"
                        case frontGray = "front_gray"
                        case frontShiny = "front_shiny"
                        case frontShinyFemale = "front_shiny_female"
                        case frontShinyTransparent = "front_shiny_transparent"
                    }
                }
            }
        }
    }

    struct Cries: Decodable {
        public let latest: String
        public let legacy: String?
    }

    struct Stat: Decodable {
        public let stat: BaseResource
        public let effort: Int
        public let baseStat: Int

        enum CodingKeys: String, CodingKey {
            case stat
            case effort
            case baseStat = "base_stat"
        }
    }
}
