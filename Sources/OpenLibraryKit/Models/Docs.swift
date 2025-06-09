//
//  Docs.swift
//  OpenLibraryKit
//
//  Created by Todd Martin on 6/8/25.
//

import Foundation

public struct Doc: Codable, Sendable {
    public let coverID: Int?
    public let hasFullText: Bool?
    public let editionCount: Int?
    public let title: String?
    public let authorNames: [String]?
    public let firstPublishYear: Int?
    public let key: String?
    public let iaIDs: [String]?
    public let authorKeys: [String]?
    public let publicScan: Bool?

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
