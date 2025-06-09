// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

enum OpenLibraryError: Error {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case decodingError(Error)
}

enum Size: String {
    case small = "S"
    case medium = "M"
    case large = "L"
}

public final class OpenLibraryClient: @unchecked Sendable {
    static let shared = OpenLibraryClient()

    private var baseUrl = "https://openlibrary.org/"
    private var search = "search.json"
    private var isbnPath = "api/volumes/brief/isbn/"

    private var _userAgent: String = ""
    var userAgent: String {
        get {
            return _userAgent
        }
        set {
            _userAgent = newValue
        }
    }

    private init() {}

    func searchByTitle(_ title: String) async throws -> SearchResponse {
        let requestUrl = baseUrl + search + "?title=\(title.urlSafeString)"
        do {
            return try await search(url: requestUrl)
        } catch {
            throw error
        }
    }

    func searchByAuthor(_ author: String) async throws -> SearchResponse {
        let requestUrl = baseUrl + search + "?author=\(author.urlSafeString)&sort=new"
        do {
            return try await search(url: requestUrl)
        } catch {
            throw error
        }
    }

    private func search(url: String) async throws -> SearchResponse {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue(_userAgent, forHTTPHeaderField: "User-Agent")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw OpenLibraryError.invalidResponse
        }

        if httpResponse.statusCode != 200 {
            throw OpenLibraryError.httpError(httpResponse.statusCode)
        }

        let decoder = JSONDecoder()
        return try decoder.decode(SearchResponse.self, from: data)
    }

    func isbnSearch(isbn: String) async throws -> BookRecordResponse {
        let url = baseUrl + isbnPath + isbn.isbnQueryable
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue(_userAgent, forHTTPHeaderField: "User-Agent")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw OpenLibraryError.invalidResponse
        }

        if httpResponse.statusCode != 200 {
            throw OpenLibraryError.httpError(httpResponse.statusCode)
        }

        let decoder = JSONDecoder()
        return try decoder.decode(BookRecordResponse.self, from: data)
    }

    func getCoverUrl(isbn: String, size: Size = Size.small) -> String {
        return "https://covers.openlibrary.org/b/isbn/\(isbn)-\(size.rawValue).jpg"
    }
}
