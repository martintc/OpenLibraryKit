//
//  File.swift
//  OpenLibraryKit
//
//  Created by Todd Martin on 6/8/25.
//

import Foundation

enum Notes: Codable {
    case string(String)
    case object(NotesObject)

    struct NotesObject: Codable {
        let type: String
        let value: String
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let str = try? container.decode(String.self) {
            self = .string(str)
        } else if let obj = try? container.decode(NotesObject.self) {
            self = .object(obj)
        } else {
            throw DecodingError.typeMismatch(
                Notes.self,
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Expected String or NotesObject for notes"
                ))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let str):
            try container.encode(str)
        case .object(let obj):
            try container.encode(obj)
        }
    }

    var text: String? {
        switch self {
        case .string(let str):
            return str
        case .object(let obj):
            return obj.value
        }
    }
}

public struct BookRecord: Codable, Sendable {
    let isbns: [String]
    let issns: [String]
    let lccns: [String]
    let oclcs: [String]
    let olids: [String]
    let publishDates: [String]
    let recordURL: String
    let data: BookData
    let details: BookDetailsWrapper
}

public struct BookRecordResponse: Codable, Sendable {
    let records: [String: BookRecord]
    let items: [String]  // Currently an empty array
}

public struct BookData: Codable, Sendable {
    let url: String
    let key: String
    let title: String
    let subtitle: String?
    let authors: [Author]
    let numberOfPages: Int?
    let identifiers: BookIdentifiers
    let publishers: [Publisher]
    let publishDate: String
    let subjects: [Subject]
    let notes: Notes?
    let cover: CoverImages

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case key = "key"
        case title
        case subtitle
        case authors
        case numberOfPages = "number_of_pages"
        case publishDate = "publish_date"
        case subjects
        case identifiers
        case publishers
        case notes
        case cover
    }
}

public struct Author: Codable, Sendable {
    let url: String
    let name: String
}

public struct BookIdentifiers: Codable, Sendable {
    let isbn10: [String]?
    let isbn13: [String]?
    let openlibrary: [String]?

    enum CodingKeys: String, CodingKey {
        case isbn10 = "isbn_10"
        case isbn13 = "isbn_13"
        case openlibrary
    }
}

struct Publisher: Codable, Sendable {
    let name: String
}

struct Subject: Codable, Sendable {
    let name: String
    let url: String
}

struct CoverImages: Codable, Sendable {
    let small: String
    let medium: String
    let large: String
}

struct BookDetailsWrapper: Codable, Sendable {
    let bibKey: String
    let infoURL: String
    let preview: String
    let previewURL: String
    let thumbnailURL: String
    let details: BookDetails

    enum CodingKeys: String, CodingKey {
        case bibKey = "bib_key"
        case infoURL = "info_url"
        case preview
        case previewURL = "preview_url"
        case thumbnailURL = "thumbnail_url"
        case details
    }
}

struct BookDetails: Codable, Sendable {
    struct TypeInfo: Codable {
        let key: String
    }

    struct SimpleAuthor: Codable, Sendable {
        let key: String
        let name: String
    }

    struct DateValue: Codable, Sendable {
        let type: String
        let value: String
    }

    let type: TypeInfo
    let authors: [SimpleAuthor]
    let fullTitle: String?
    let notes: Notes?
    let numberOfPages: Int?
    let physicalFormat: String?
    let publishDate: String?
    let publishers: [String]?
    let sourceRecords: [String]?
    let subtitle: String?
    let title: String
    let covers: [Int]?
    let works: [Work]?
    let key: String
    let identifiers: [String: [String]]?
    let isbn10: [String]?
    let isbn13: [String]?
    let classifications: [String: [String]]?
    let localID: [String]?
    let latestRevision: Int?
    let revision: Int?
    let created: DateValue?
    let lastModified: DateValue?

    enum CodingKeys: String, CodingKey {
        case type, authors
        case fullTitle = "full_title"
        case notes
        case numberOfPages = "number_of_pages"
        case physicalFormat = "physical_format"
        case publishDate = "publish_date"
        case publishers
        case sourceRecords = "source_records"
        case subtitle, title, covers, works, key, identifiers
        case isbn10 = "isbn_10"
        case isbn13 = "isbn_13"
        case classifications
        case localID = "local_id"
        case latestRevision = "latest_revision"
        case revision, created
        case lastModified = "last_modified"
    }
}

struct Work: Codable, Sendable {
    let key: String
}
