//
//  Artist.swift
//  Palo
//
//  Created by Hau Huynh on 25/12/2021.
//

import Foundation

struct Artist: Codable, Identifiable, Hashable {
    let id, name, birthday, gender: String
    let role, nation: String
    let view: String?
    let image: String
    let trend: String?
}
