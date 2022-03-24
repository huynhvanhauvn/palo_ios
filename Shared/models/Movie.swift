//
//  Movie.swift
//  Palo
//
//  Created by Hau Huynh on 23/12/2021.
//

import Foundation

struct Movie: Codable, Identifiable, Hashable {
    let id, title, description, rating: String?
    let vote, trailer: String?
    let poster: String?
    let nation, date, oscars: String?
    let director: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.rating = try container.decodeIfPresent(String.self, forKey: .rating)
        self.vote = try container.decodeIfPresent(String.self, forKey: .vote)
        self.trailer = try container.decodeIfPresent(String.self, forKey: .trailer)
        self.poster = try container.decodeIfPresent(String.self, forKey: .poster)
        self.nation = try container.decodeIfPresent(String.self, forKey: .nation)
        self.date = try container.decodeIfPresent(String.self, forKey: .date)
        self.oscars = try container.decodeIfPresent(String.self, forKey: .oscars)
        self.director = try container.decodeIfPresent(String.self, forKey: .director)
    }
}
