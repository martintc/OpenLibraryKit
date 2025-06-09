//
//  Search.swift
//  OpenLibraryKit
//
//  Created by Todd Martin on 6/8/25.
//

import Foundation

public struct SearchResponse: Codable {
    let numFound: Int
    let start: Int
    let numFoundExact: Bool
    let numFoundAlternative: Int
    let documentationURL: String
    let query: String
    let offset: Int?
    let docs: [Doc]

    enum CodingKeys: String, CodingKey {
        case numFound
        case start
        case numFoundExact
        case numFoundAlternative = "num_found"
        case documentationURL = "documentation_url"
        case query = "q"
        case offset
        case docs
    }
}
