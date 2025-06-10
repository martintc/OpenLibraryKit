import Testing

@testable import OpenLibraryKit

@Test func searchByTitle() async throws {
    OpenLibraryClient.shared.userAgent = "test/1.0 (example@example.com)"
    let response = try await OpenLibraryClient.shared.searchByTitle("lord of the rings")
    #expect(response.docs.count > 0)
}

@Test func searchByAuthor() async throws {
    OpenLibraryClient.shared.userAgent = "test/1.0 (example@example.com)"
    let response = try await OpenLibraryClient.shared.searchByAuthor("J.R.R. Tolkien")
    #expect(response.docs.count > 0)
}

@Test func isbnSearch() async throws {
    OpenLibraryClient.shared.userAgent = "test/1.0 (example@example.com)"
    // let isbn = "9780593650868"
    let isbn = "9780822342649"
    let response = try await OpenLibraryClient.shared.isbnSearch(isbn: isbn)
    // print(response)
    #expect(response.records.count > 0)
}

@Test func getCoverUrl() async throws {
    let url = OpenLibraryClient.shared.getCoverUrl(isbn: "0385472579", size: Size.small)
    #expect(url == "https://covers.openlibrary.org/b/isbn/0385472579-S.jpg")
}
