//
//  Docs.swift
//  OpenLibraryKit
//
//  Created by Todd Martin on 6/8/25.
//

import Foundation

// One document in the search result
struct Doc: Codable {
    let coverID: Int?
    let hasFullText: Bool?
    let editionCount: Int?
    let title: String?
    let authorNames: [String]?
    let firstPublishYear: Int?
    let key: String?
    let iaIDs: [String]?
    let authorKeys: [String]?
    let publicScan: Bool?

    enum CodingKeys: String, CodingKey {
        case coverID = "cover_i"
        case hasFullText = "has_fulltext"
        case editionCount = "edition_count"
        case title
        case authorNames = "author_name"
        case firstPublishYear = "first_publish_year"
        case key
        case iaIDs = "ia"
        case authorKeys = "author_key"
        case publicScan = "public_scan_b"
    }
}
