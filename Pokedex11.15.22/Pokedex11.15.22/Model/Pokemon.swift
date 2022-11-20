//
//  Pokemon.swift
//  Pokedex11.15.22
//
//  Created by Consultant on 11/18/22.
//

import Foundation

struct PageResult : Decodable{
    let count : Int
    let next : URL?
    let previous : URL?
    let results : [NameLink]
    
}


struct Pokemon: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let abilities: [Ability]
    let moves: [Move]
    let types: [Types]
    let sprites: Sprite
}

struct Ability: Decodable {
    let ability: AbilityName
}

struct AbilityName: Decodable {
    let name: String
}

struct Move: Decodable {
    let move: MoveName
}

struct MoveName: Decodable {
    let name: String
}

struct Types: Decodable {
    let type: TypeName
}

struct TypeName: Decodable {
    let name: String
}

struct Sprite: Decodable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct NameLink : Decodable{
    let name : String
    let url : String?
}

