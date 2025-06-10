//
//  File.swift
//  OpenLibraryKit
//
//  Created by Todd Martin on 6/8/25.
//

import Foundation

public enum Notes: Codable, Sendable {
    case string(String)
    case object(NotesObject)

    public struct NotesObject: Codable, Sendable {
        public let type: String
        public let value: String
    }

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let str):
            try container.encode(str)
        case .object(let obj):
            try container.encode(obj)
        }
    }

    public var text: String? {
        switch self {
        case .string(let str):
            return str
        case .object(let obj):
            return obj.value
        }
    }
}

public struct BookRecord: Codable, Sendable {
    public let isbns: [String]
    public let issns: [String]
    public let lccns: [String]
    public let oclcs: [String]
    public let olids: [String]
    public let publishDates: [String]
    public let recordURL: String
    public let data: BookData
    public let details: BookDetailsWrapper
}

public struct BookRecordResponse: Codable, Sendable {
    public let records: [String: BookRecord]
    public let items: [String]  // Currently an empty array
}

public struct BookData: Codable, Sendable {
    public let url: String
    public let key: String
    public let title: String
    public let subtitle: String?
    public let authors: [Author]
    public let numberOfPages: Int?
    public let identifiers: BookIdentifiers
    public let publishers: [Publisher]
    public let publishDate: String
    public let subjects: [Subject]
    public let notes: Notes?
    public let cover: CoverImages

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
    public let url: String
    public let name: String
}

public struct BookIdentifiers: Codable, Sendable {
    public let isbn10: [String]?
    public let isbn13: [String]?
    public let openlibrary: [String]?

    enum CodingKeys: String, CodingKey {
        case isbn10 = "isbn_10"
        case isbn13 = "isbn_13"
        case openlibrary
    }
}

public struct Publisher: Codable, Sendable {
    public let name: String
}

public struct Subject: Codable, Sendable {
    public let name: String
    public let url: String
}

public struct CoverImages: Codable, Sendable {
    public let small: String
    public let medium: String
    public let large: String
}

public struct BookDetailsWrapper: Codable, Sendable {
    public let bibKey: String
    public let infoURL: String
    public let preview: String
    public let previewURL: String
    public let thumbnailURL: String
    public let details: BookDetails

    enum CodingKeys: String, CodingKey {
        case bibKey = "bib_key"
        case infoURL = "info_url"
        case preview
        case previewURL = "preview_url"
        case thumbnailURL = "thumbnail_url"
        case details
    }
}

public struct BookDetails: Codable, Sendable {
    public struct TypeInfo: Codable, Sendable {
        public let key: String
    }

    public struct SimpleAuthor: Codable, Sendable {
        public let key: String
        public let name: String
    }

    public struct DateValue: Codable, Sendable {
        public let type: String
        public let value: String
    }

    public let type: TypeInfo
    public let authors: [SimpleAuthor]
    public let fullTitle: String?
    public let notes: Notes?
    public let numberOfPages: Int?
    public let physicalFormat: String?
    public let publishDate: String?
    public let publishers: [String]?
    public let sourceRecords: [String]?
    public let subtitle: String?
    public let title: String
    public let covers: [Int]?
    public let works: [Work]?
    public let key: String
    public let identifiers: [String: [String]]?
    public let isbn10: [String]?
    public let isbn13: [String]?
    public let classifications: [String: [String]]?
    public let localID: [String]?
    public let latestRevision: Int?
    public let revision: Int?
    public let created: DateValue?
    public let lastModified: DateValue?

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

public struct Work: Codable, Sendable {
    public let key: String
}
