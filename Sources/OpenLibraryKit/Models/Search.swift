//
//  Search.swift
//  OpenLibraryKit
//
//  Created by Todd Martin on 6/8/25.
//

import Foundation

public struct SearchResponse: Codable, Sendable {
    public let numFound: Int
    public let start: Int
    public let numFoundExact: Bool
    public let numFoundAlternative: Int
    public let documentationURL: String
    public let query: String
    public let offset: Int?
    public let docs: [Doc]

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
